# Whitelist System Documentation

> How the whitelist system works, how to contribute, and how GitHub Actions automation is integrated.

---

## Table of Contents

- [Overview](#overview)
- [Whitelist Files](#whitelist-files)
- [IP Whitelist Flow](#ip-whitelist-flow)
- [Domain Whitelist Flow](#domain-whitelist-flow)
- [Community Contributions](#community-contributions)
- [GitHub Actions Automation](#github-actions-automation)
- [Conflict Avoidance Design](#conflict-avoidance-design)
- [For Maintainers](#for-maintainers)

---

## Overview

The whitelist system prevents false positives by excluding known-legitimate IPs and domains from blocklists. It operates across two independent pipelines:

- **IP Whitelist**: Protects CDN ranges (Cloudflare, Akamai, Fastly), DNS resolvers, and community-submitted IPs
- **Domain Whitelist**: Protects legitimate services via OSINT-curated lists, Pi-hole exports, and community-submitted domains

Whitelists are applied **during** blocklist generation — an IP/domain in the whitelist is removed from the final blocklist output.

### Override Mechanism

Some IPs that fall within whitelisted ranges are confirmed malicious (e.g., a compromised server on a CDN). These are tracked in `referenced_malicious_ips.txt` and **always kept in the blocklist**, overriding the whitelist.

---

## Whitelist Files

### IP Whitelists (`whitelist/wl_iplist/`)

| File | Source | Format | Updated By |
| ------ | -------- | -------- | ------------ |
| `cdnips.txt` | Auto-generated | CIDR ranges + comments | `update_cdn_whitelist.py` (daily cron) |
| `forcedwhitelistips.txt` | Manual | Individual IPs + comments | Maintainer (manual edits) |
| `community_whitelist_ips.txt` | Community | IPs/CIDRs + comments | GitHub Actions (on approval) |
| `removed_ips.db` | Auto-generated | SQLite database | `filter_blocklist.py` (tracks removed IPs) |

**CDN Sources** (auto-fetched for `cdnips.txt`):

- Cloudflare IPv4/IPv6
- Akamai IPv4
- Fastly (JSON API)
- UptimeRobot
- Tailscale DERP map

**Forced Whitelist** (`forcedwhitelistips.txt`):

- Public DNS resolvers: Cloudflare (1.1.1.1), Google (8.8.8.8), Quad9 (9.9.9.9), ControlD, AdGuard

### Domain Whitelists (`whitelist/wl_domainlist/`)

| File | Source | Format | Updated By |
| ------ | -------- | -------- | ------------ |
| `osintwhitelisteddomains.txt` | OSINT sources | Plain domains, one per line | External download script (daily) |
| `mypiholewhitelisteddomains.txt` | Pi-hole export | Regex patterns + plain domains | Manual Pi-hole export |
| `publicwhitelisted.txt` | Manual | Plain domains + comments | Maintainer (manual edits) |
| `community_whitelist_domains.txt` | Community | Plain domains + comments | GitHub Actions (on approval) |

---

## IP Whitelist Flow

```text
┌──────────────────────────────────────────────────────────────┐
│  DAILY CRON: update_cdn_whitelist.py                         │
│  Downloads Cloudflare/Akamai/Fastly/UptimeRobot/Tailscale   │
│  → Validates CIDR format                                     │
│  → Writes: whitelist/wl_iplist/cdnips.txt                    │
└──────────────────┬───────────────────────────────────────────┘
                   │
┌──────────────────▼───────────────────────────────────────────┐
│  DAILY CRON: main_ip_pipeline.sh                             │
│                                                              │
│  Step 1: Run aggregate_feeds.py                              │
│          → Downloads external feeds → master_malicious_iplist │
│                                                              │
│  Step 2: Merge whitelists                                    │
│          cat cdnips.txt                                      │
│            + forcedwhitelistips.txt                           │
│            + community_whitelist_ips.txt                      │
│          | sort -u → /tmp/combined_whitelist.XXXXXX           │
│                                                              │
│  Step 3: filter_blocklist.py                                 │
│          For each IP in master blocklist:                     │
│            - In referenced_malicious? → KEEP (override)      │
│            - In any whitelist CIDR?   → REMOVE → SQLite DB   │
│            - Otherwise                → KEEP                 │
│          → filtered_malicious_iplist.txt                      │
│                                                              │
│  Step 4: Same filter for permanent_IPList.txt                │
│                                                              │
│  Step 5: Optional ref_analyses.py                            │
│          Re-evaluates removed IPs via AbuseIPDB/ThreatFox    │
└──────────────────────────────────────────────────────────────┘
```

### Key Functions

- **`read_whitelist(file_path)`** in `filter_blocklist.py`: Parses each line as `ipaddress.ip_network(strict=False)` — handles both individual IPs and CIDR ranges
- **`filter_blocklist(blocklist, whitelist, referenced_malicious)`**: The core matching logic. `referenced_malicious` always takes priority (IPs are kept even if they match a whitelist range)
- **`insert_removed_ips()`**: Archives removed IPs to SQLite with `INSERT OR IGNORE` to prevent duplicates

---

## Domain Whitelist Flow

```text
┌──────────────────────────────────────────────────────────────┐
│  DAILY CRON: main_domain_pipeline.sh                         │
│                                                              │
│  Runs: aggregate_domain_feeds.py                             │
│                                                              │
│  Step 1: Download domain feeds from external sources         │
│  Step 2: Categorize: Malicious / Ads-Tracking / Spam         │
│  Step 3: load_whitelist(whitelist/wl_domainlist/)             │
│          → Reads ALL .txt files in directory                  │
│          → Converts regex patterns: (\.|^)domain\.com$ → domain.com  │
│          → Normalizes and deduplicates into a set            │
│  Step 4: filter_domain_list() per category                   │
│          → should_remove() checks exact match + parent domains│
│  Step 5: Write filtered outputs per category                 │
└──────────────────────────────────────────────────────────────┘
```

### Key Domain Functions

- **`load_whitelist(whitelist_dir)`** in `aggregate_domain_feeds.py`: Reads **every `.txt` file** in `wl_domainlist/`. This means any new `.txt` file placed in the directory is automatically picked up — no code changes needed.
- **`should_remove(domain, whitelisted_set)`**: Two-tier matching:
  1. **Exact match**: `example.com` in whitelist → remove `example.com`
  2. **Parent domain match**: `example.com` in whitelist → also removes `sub.example.com`
  - Does NOT remove parent if only a subdomain is whitelisted

### Category Independence

Domain categories (Malicious, Ads/Tracking, Spam) are filtered **independently**. A domain can appear in multiple categories — this is intentional for Pi-hole multi-list compatibility.

---

## Community Contributions

### How to Submit a Whitelist Request

1. Go to [**New Issue**](https://github.com/spydisec/spydithreatintel/issues/new/choose)
2. Select either:
   - **Whitelist Request: IP Address** — for IPs or CIDR ranges
   - **Whitelist Request: Domain** — for domain names
3. Fill out the form:
   - **Entry**: The IP/CIDR or domain to whitelist
   - **Reason**: Select from the dropdown
   - **Justification**: Explain why this is a false positive
   - **Evidence URL** (optional): Supporting documentation
4. Submit the issue

### What Happens Next

1. **Automated Validation**: A GitHub Action validates the format and checks for duplicates
2. **Maintainer Review**: A maintainer reviews the request
3. **Approval**: If approved, the maintainer adds the `approved` label
4. **Auto-Processing**: A GitHub Action automatically:
   - Appends the entry to the appropriate community whitelist file
   - Commits and pushes to `main`
   - Closes the issue with a confirmation
5. **Pipeline Pickup**: On the next cron run, the server pulls the latest changes and the new whitelist entry takes effect

### Accepted Formats

**IP Addresses:**

- Single IPv4: `192.168.1.1`
- Single IPv6: `2001:db8::1`
- CIDR range: `10.0.0.0/24`

**Domains:**

- Plain domain: `example.com`
- No protocol (`https://`), no paths, no wildcards

---

## GitHub Actions Automation

### Workflow 1: Validation (`whitelist-validate.yml`)

**Trigger**: Issue opened or edited with `whitelist-request` label

| Step | Action |
| ------ | -------- |
| Parse | Extracts IP/domain from issue form fields |
| Validate | IP: `ipaddress.ip_network()` check. Domain: regex format check |
| Duplicate Check | Scans all existing whitelist files for matches |
| Comment | Posts validation result (pass/fail + warnings) |
| Label | Adds `validated` or `invalid-format` label |

### Workflow 2: Processing (`whitelist-process.yml`)

**Trigger**: `approved` label added to an issue with `whitelist-request` label

| Step | Action |
| ------ | -------- |
| Parse | Extracts entry and reason from issue body |
| Duplicate Guard | Final check before writing |
| Append | Adds entry to `community_whitelist_ips.txt` or `community_whitelist_domains.txt` |
| Commit | Commits with message: `Whitelist: Add <type> <entry> (Issue #N)` |
| Push | Pushes directly to `main` |
| Close | Closes issue with confirmation comment |

### Label Workflow

```text
Issue Created (with whitelist-request label)
  → Validation runs
    → Pass: adds "validated" label
    → Fail: adds "invalid-format" label
  → Maintainer reviews
    → Adds "approved" label
      → Processing runs → entry added → issue closed
    → Or closes as "not planned" (rejected)
```

---

## Conflict Avoidance Design

### The Problem

The project runs on a local Linux machine via cron jobs. The `updated_git_auto_push.sh` script commits and pushes whitelist changes to GitHub. If GitHub Actions also commits to the same files, merge conflicts occur.

### The Solution: Separate Community Files

Community whitelist files are **owned exclusively by GitHub Actions**:

| File | Modified By | Never Modified By |
| ------ | ------------- | ------------------- |
| `cdnips.txt` | Server cron (`update_cdn_whitelist.py`) | GitHub Actions |
| `forcedwhitelistips.txt` | Maintainer (manual) | GitHub Actions |
| `osintwhitelisteddomains.txt` | Server cron (download script) | GitHub Actions |
| `mypiholewhitelisteddomains.txt` | Maintainer (Pi-hole export) | GitHub Actions |
| **`community_whitelist_ips.txt`** | **GitHub Actions only** | Server cron |
| **`community_whitelist_domains.txt`** | **GitHub Actions only** | Server cron |

### How It Works

1. **GitHub Action** commits community entries to `community_whitelist_*.txt` → pushes to `main`
2. **Server cron** runs `updated_git_auto_push.sh` → does `git pull --rebase` before push → picks up Action's commits
3. **No conflict**: Server never writes to community files. Actions never write to server-managed files.
4. **Pipeline integration**:
   - IP: `main_ip_pipeline.sh` merges `cdnips.txt` + `forcedwhitelistips.txt` + `community_whitelist_ips.txt` into combined whitelist
   - Domain: `aggregate_domain_feeds.py` auto-loads ALL `.txt` from `wl_domainlist/` — community file is picked up automatically

### Edge Case: Simultaneous Push

If the server pushes at the exact same time as a GitHub Action, the server's retry logic handles it:

- `git pull --rebase` before each push attempt
- 10 retry attempts with 20-second delays
- Slack notification on persistent failure (manual intervention)

---

## For Maintainers

### Reviewing Whitelist Requests

1. Check the validation comment (auto-posted by the workflow)
2. Verify the justification and evidence
3. Cross-reference with threat intelligence if needed
4. **To approve**: Add the `approved` label → automation handles the rest
5. **To reject**: Close the issue as "not planned" with a comment explaining why

### Manual Whitelist Edits

- **CDN IPs**: Auto-managed. Don't edit `cdnips.txt` directly — it's overwritten daily
- **DNS Resolvers**: Edit `forcedwhitelistips.txt` on the server
- **Domains**: Edit `publicwhitelisted.txt` on the server (or `mypiholewhitelisteddomains.txt` via Pi-hole)
- **Community files**: Don't edit manually on the server — only GitHub Actions should modify these

### Config Reference

```yaml
# config.yaml
filter:
  whitelist_file: whitelist/wl_iplist/cdnips.txt
  force_whitelist_file: whitelist/wl_iplist/forcedwhitelistips.txt
  community_whitelist_file: whitelist/wl_iplist/community_whitelist_ips.txt
  referenced_malicious: iplist/referenced_malicious_ips.txt

# Domain whitelist: loaded from all .txt files in this directory
whitelist_dir: whitelist/wl_domainlist/
```

### Git-Tracked Whitelist Files

All whitelist files are tracked in git for transparency:

```text
whitelist/wl_iplist/cdnips.txt                    # CDN IP ranges (auto-generated)
whitelist/wl_iplist/forcedwhitelistips.txt         # Forced IPs (manual)
whitelist/wl_iplist/community_whitelist_ips.txt    # Community IPs (GitHub Actions)
whitelist/wl_iplist/removed_ips.db                 # Removed IP tracking (auto)
whitelist/wl_domainlist/osintwhitelisteddomains.txt      # OSINT domains (auto)
whitelist/wl_domainlist/mypiholewhitelisteddomains.txt   # Pi-hole domains (manual)
whitelist/wl_domainlist/community_whitelist_domains.txt  # Community domains (GitHub Actions)
```
