<div align="center">
  <h1>Spydi's ThreatIntel Feed 🛡️</h1>

  ![Daily IP List Update](https://healthchecks.io/b/2/b76af744-7b3f-4de6-b0cb-227a88bbc5aa.svg) ![Daily C2 Feed Update](https://healthchecks.io/b/2/ad6b7683-29fc-49f4-95d1-70c169e3d8e4.svg)
</div>

> 📢 **Update**: Blocklists are now served from **Cloudflare R2** for faster global delivery and reduced latency. Use the download links below instead of raw GitHub URLs. Website & API coming soon!

## 🚀 About

Comprehensive threat intelligence blocklists aggregated from multiple OSINT sources, honeypot networks, and C2 trackers. Multi-source validation, confidence-based tiers, and CDN-aware whitelisting.

**📑 Quick Links:** [IP Blocklists](#-ip-blocklists) • [Domain Blocklists](#-domain-blocklists) • [Sources](#%EF%B8%8F-tracked-threats--source-list) • [Credits](#-acknowledgements)

> ⚠️ **License Notice**: Each OSINT feed is governed by its own terms. Users must review original source documentation for specific licensing details.

---

## 🔥 IP Blocklists

*Confidence-based tiers with multi-source validation*

| Tier | Blocklist | Download |
|:----:|-----------|:--------:|
| 🎯 **High** | High Confidence (Limited ~5K) | [📥 Download](https://spydisec.com/high_confidence_limited.txt) |
| 🎯 **High** | High Confidence (Unlimited) | [📥 Download](https://spydisec.com/high_confidence_unlimited.txt) |
| ⚖️ **Medium** | Medium Confidence (Limited ~25K) | [📥 Download](https://spydisec.com/medium_confidence_limited.txt) |
| ⚖️ **Medium** | Medium Confidence (Unlimited) | [📥 Download](https://spydisec.com/medium_confidence_unlimited.txt) |
| 🔬 **Low** | Low Confidence (All Others) | [📥 Download](https://spydisec.com/low_confidence.txt) |
| 📊 **Research** | Full Research Blocklist | [📥 Download](https://spydisec.com/fullIPblocklist.txt) |
| 🗄️ **Archive** | Permanent (Append-Only) | [📥 Download](https://spydisec.com/permanentfullIPblocklist.txt) |

<details>
<summary>🔍 <strong>Confidence Scoring Details</strong></summary>

**Multi-Source Validation**: IPs are scored by how many independent threat intelligence sources report them.

| Tier | Threshold | Description |
|------|-----------|-------------|
| 🎯 **High Limited** | 5+ sources | Strictest tier - confirmed malicious across 5+ feeds |
| 🎯 **High Unlimited** | 3+ sources | High confidence - validated by 3+ independent sources |
| ⚖️ **Medium** | 2+ sources | Medium confidence - corroborated by 2 sources |
| 🔬 **Low** | 1 source | Single-source reports - use with caution |

**Example**: An IP reported by ThreatFox, Feodo Tracker, IPsum, CINS Score, and Blocklist.de would have `source_count=5` → appears in **High Limited**.

**Whitelist Protection**: CDN ranges (Cloudflare, Akamai, Fastly, Tailscale) are automatically excluded to prevent false positives.

</details>

---

## 🌐 Domain Blocklists

*Independent category processing - import any/all into Pi-hole/AdGuard*

| Category | Blocklist | Download |
|:--------:|-----------|:--------:|
| 🛡️ **Security** | Malicious Domains | [📥 Download](https://spydisec.com/maliciousblocklist.txt) |
| 📧 **Spam** | Spam/Scam/Abuse Domains | [📥 Download](https://spydisec.com/spamblocklist.txt) |
| 📺 **Privacy** | Ads & Tracking Domains | [📥 Download](https://spydisec.com/adsblocklist.txt) |
| 🗄️ **Archive** | Permanent Domains (Append-Only) | [📥 Download](https://spydisec.com/permanentMaliciousDomainList.txt) |
---

### 📁 Whitelisting

**Reduce false positives using these curated lists:**

| Name | Purpose | Raw URL |
|------|---------|---------|
| **Removed IPs** | Legitimate IPs removed from blocklists | [📥 Raw](https://raw.githubusercontent.com/spydisec/spydithreatintel/refs/heads/main/whitelist/wl_iplist/removed_ips.db) |
| **Whitelisted IPs** | Critical infrastructure IPs (Cloudflare, Akamai, Fastly) | [📥 Raw](https://raw.githubusercontent.com/spydisec/spydithreatintel/refs/heads/main/whitelist/wl_iplist/cdnips.txt) |
| **Community IPs** | Community-submitted IP whitelist | [📥 Raw](https://raw.githubusercontent.com/spydisec/spydithreatintel/refs/heads/main/whitelist/wl_iplist/community_whitelist_ips.txt) |
| **Community Domains** | Community-submitted domain whitelist | [📥 Raw](https://raw.githubusercontent.com/spydisec/spydithreatintel/refs/heads/main/whitelist/wl_domainlist/community_whitelist_domains.txt) |

> 💡 **Found a false positive?** Submit a [Whitelist IP Request](https://github.com/spydisec/spydithreatintel/issues/new?template=whitelist-ip-request.yml) or [Whitelist Domain Request](https://github.com/spydisec/spydithreatintel/issues/new?template=whitelist-domain-request.yml) — automated validation and processing via GitHub Actions.

---

## 🕵️ Tracked Threats & Source list

1. Actively monitored infrastructure across 50+ threat actors:

<details>
<summary>🔍 Expand Threat Catalog</summary>

| C2s | Malware | Botnets |
|-----|---------|---------|
| Cobalt Strike | AcidRain Stealer | 7777 |
| Metasploit Framework | Misha Stealer (AKA Grand Misha) | BlackNET |
| Covenant | Patriot Stealer | Doxerina |
| Mythic | RAXNET Bitcoin Stealer | Scarab |
| Brute Ratel C4 | Titan Stealer | 63256 |
| Posh | Collector Stealer | Kaiji |
| Sliver | Mystic Stealer | MooBot |
| Deimos | Gotham Stealer | Mozi |
| PANDA | Meduza Stealer | |
| NimPlant C2 | Quasar RAT | |
| Havoc C2 | ShadowPad | |
| Caldera | AsyncRAT | |
| Empire | DcRat | |
| Ares | BitRAT | |
| Hak5 Cloud C2 | DarkComet Trojan | |
| Pantegana | XtremeRAT Trojan | |
| Supershell | NanoCore RAT Trojan | |
| Poseidon C2 | Gh0st RAT Trojan | |
| Viper C2 | DarkTrack RAT Trojan | |
| Vshell | njRAT Trojan | |
| Villain | Remcos Pro RAT Trojan | |
| Nimplant C2 | Poison Ivy Trojan | |
| RedGuard C2 | Orcus RAT Trojan | |
| Oyster C2 | ZeroAccess Trojan | |
| byob C2 | HOOKBOT Trojan | |
| | RisePro Stealer | |
| | NetBus Trojan | |
| | Bandit Stealer | |
| | Mint Stealer | |
| | Mekotio Trojan | |
| | Gozi Trojan | |
| | Atlandida Stealer | |
| | VenomRAT | |
| | Orcus RAT | |
| | BlackDolphin | |
| | Artemis RAT | |
| | Godzilla Loader | |
| | Jinx Loader | |
| | Netpune Loader | |
| | SpyAgent | |
| | SpiceRAT | |
| | Dust RAT | |
| | Pupy RAT | |
| | Atomic Stealer | |
| | Lumma Stealer | |
| | Serpent Stealer | |
| | Axile Stealer | |
| | Vector Stealer | |
| | Z3us Stealer | |
| | Rastro Stealer | |
| | Darkeye Stealer | |
| | AgniStealer | |
| | Epsilon Stealer | |
| | Bahamut Stealer | |
| | Unam Web Panel / SilentCryptoMiner | |
| | Vidar Stealer | |
| | Kraken RAT | |
| | Bumblebee Loader | |
| | Viper RAT | |
| | Spectre Stealer | |

</details>

2. **Sources**: Curated feeds including C2 servers, honeypot data, Mass-scanners, and OSINT feeds.

<details>
<summary>📚 View Full Source List</summary>

| Sources | Source URL |
|---------|------------|
| C2 IP Feed | [C2_iplist.txt](https://raw.githubusercontent.com/spydisec/spydithreatintel/refs/heads/main/iplist/C2IPs/osintc2feed.txt) |
| Honeypot Master list | [honeypot_iplist.txt](https://raw.githubusercontent.com/spydisec/spydithreatintel/refs/heads/main/iplist/honeypot/honeypot_extracted_feed.txt) |
| maltrail_scanners | [maltrail_ips.txt](https://raw.githubusercontent.com/stamparm/maltrail/master/trails/static/mass_scanner.txt) |
| botvrij_eu | [botvrij_eu](https://www.botvrij.eu/data/ioclist.ip-dst.raw) |
| feodotracker | [feodotracker](https://feodotracker.abuse.ch/downloads/ipblocklist.txt) |
| feodotracker_recommended | [feodotracker_recommended](https://feodotracker.abuse.ch/downloads/ipblocklist_recommended.txt) |
| Blocklist_de_all | [Blocklist_de_all](https://lists.blocklist.de/lists/all.txt) |
| ThreatView_High_Confidence | [ThreatView_High_Confidence](https://threatview.io/Downloads/IP-High-Confidence-Feed.txt) |
| IPsumLevel_7 | [IPsumLevel7](https://raw.githubusercontent.com/stamparm/ipsum/refs/heads/master/levels/7.txt) |
| CINS_Score | [CINS_Score](https://cinsscore.com/list/ci-badguys.txt) |
| DigitalSide | [DigitalSide](https://osint.digitalside.it/Threat-Intel/lists/latestips.txt) |
| duggytuxy | [duggytuxy](https://raw.githubusercontent.com/duggytuxy/malicious_ip_addresses/refs/heads/main/botnets_zombies_scanner_spam_ips.txt) |
| etnetera.cz | [etnetera.cz](https://security.etnetera.cz/feeds/etn_aggressive.txt) |
| emergingthreats-compromised | [ET_Comp](https://rules.emergingthreats.net/blockrules/compromised-ips.txt) |
| greensnow.co | [greensnow.co](https://blocklist.greensnow.co/greensnow.txt) |
| Threatfox | [Threatfox](https://threatfox.abuse.ch/export) |
| More coming Soon! | [Future Updates](#) |

</details>

3. Whitelist Coverage Matrix:

<details>
<summary>View Whitelist Sources 🛡️</summary>

| Provider | Type | Coverage | Source Link |
|----------|------|----------|-------------|
| Cloudflare | CDN IPv4/IPv6 | Global CDN | [Cloudflare IPs](https://www.cloudflare.com/ips/) |
| Akamai | CDN IPv4/IPv6 | Global CDN & Shield IPs | [Akamai IPs](https://techdocs.akamai.com/property-manager/pdfs/akamai_ipv4_CIDRs.txt) |
| Fastly | CDN IPv4/IPv6 | Global CDN | [Fastly IPs](https://api.fastly.com/public-ip-list) |
| Tailscale | DERP & Control Panel | Relay servers and control plane | [Tailscale DERP](https://login.tailscale.com/derpmap/default) |
| Uptime Robot | IPv4 | UptimeRobot Monitoring | [UptimeRobot IPs](https://uptimerobot.com/inc/files/ips/IPv4.txt) |

</details>

---

## 🙌 Acknowledgements

**Gratitude to our OSINT partners**
This project stands on the shoulders of these valuable resources:

- [Abuse.ch](https://abuse.ch) - Feodo Tracker
- [Botvrij.eu](https://botvrij.eu) - Threat Intelligence
- [Blocklist.de](https://blocklist.de) - Attack Data
- [CINS Army](https://cinsscore.com) - Threat Scoring
- [DigitalSide](https://osint.digitalside.it) - Italian CERT
- ...and 10+ other community maintainers

**Special Thanks** to [MontySecurity](https://github.com/montysecurity/C2-Tracker) for their C2 Tracker framework and [elliotwutingfeng](https://github.com/elliotwutingfeng/Inversion-DNSBL-Blocklists) for Inversion DNSBL Blocklists.

---

## 🤝 Community Contributions

**Help us build the most reliable threat intelligence feed in the open-source community!** 🚀

We welcome contributions from security researchers, network administrators, and cybersecurity enthusiasts to enhance this resource for:

- **🏠 Individuals**: Strengthen personal network security with accurate blocklists
- **🏢 SMBs**: Deploy cost-effective threat blocking without enterprise overhead  
- **🏗️ Enterprises**: Integrate scalable, production-ready threat intelligence

### 🎯 Key Focus Areas

We're particularly interested in contributions that help us:

- **🔄 Deduplication**: Eliminate redundant entries across multiple feeds
- **🎯 False Positive Reduction**: Identify and remove legitimate IPs/domains incorrectly flagged
- **✅ Validation**: Flag outdated indicators or confirm active threats
- **🏷️ Context Enhancement**: Add threat actor attribution, geolocation tags, or threat categories
- **⚡ Automation**: Suggest workflow improvements for data processing and curation

### 💡 How to Contribute

**Get involved in multiple ways:**

1. **📝 Request Whitelisting** - Submit a [Whitelist IP](https://github.com/spydisec/spydithreatintel/issues/new?template=whitelist-ip-request.yml) or [Whitelist Domain](https://github.com/spydisec/spydithreatintel/issues/new?template=whitelist-domain-request.yml) request to report false positives (automated validation & processing)
2. **🐛 Report Issues** - Flag duplicates, false positives, or outdated entries in [GitHub Issues](https://github.com/spydisec/spydithreatintel/issues)
3. **💬 Share Feedback** - Help improve enterprise/SMB integration patterns and use cases
4. **📚 Documentation** - Enhance guides for non-technical users and integration tutorials
5. **🔧 Code Contributions** - Improve processing scripts, add new data sources, or enhance automation

**Every contribution helps make cybersecurity more accessible and effective for everyone!** 🌐

---

## 📡 Contact me
📧 Email: spydisec@proton.me