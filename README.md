<div align="center">
  <h1>Spydi's ThreatIntel Feed 🛡️</h1>

  ![Daily IP List Update](https://healthchecks.io/b/2/b76af744-7b3f-4de6-b0cb-227a88bbc5aa.svg) ![Daily C2 Feed Update](https://healthchecks.io/b/2/ad6b7683-29fc-49f4-95d1-70c169e3d8e4.svg)
</div>

<!-- STATS_START -->
```
📊 LIVE STATISTICS                                    Last Updated: 2025-12-02 06:30 UTC
─────────────────────────────────────────────────────────────────────────────

   🔢 Total IPs               603.5K     │     🌐 Total Domains           11.1M
   🎯 High Confidence           5.0K     │     🕵️ C2 Infrastructure       11.3K
   ✅ Whitelisted               1.3K     │     🛡️ Sources            12+ OSINT

─────────────────────────────────────────────────────────────────────────────
```


## 🚀 About

Comprehensive threat intelligence blocklists aggregated from 12+ OSINT sources, honeypot networks, and C2 trackers. Multi-source validation, confidence-based tiers, and CDN-aware whitelisting.

**📑 Quick Links:** [IP Blocklists](#-ip-blocklists) • [Domain Blocklists](#-domain-blocklists) • [Sources](#%EF%B8%8F-tracked-threats--source-list) • [Credits](#-acknowledgements)

> ⚠️ **License Notice**: Each OSINT feed is governed by its own terms. Users must review original source documentation for specific licensing details.

---

## 🔥 IP Blocklists

*Confidence-based tiers with multi-source validation*

<!-- IP_STATS_START -->
| Tier | Blocklist | Download |
|:----:|-----------|:--------:|
| 🎯 **High** | High Confidence (Limited ~5K) | [📥 Download](https://spydisec.com/high_confidence_limited.txt) |
| 🎯 **High** | High Confidence (Unlimited) | [📥 Download](https://spydisec.com/high_confidence_unlimited.txt) |
| ⚖️ **Medium** | Medium Confidence (Limited ~25K) | [📥 Download](https://spydisec.com/medium_confidence_limited.txt) |
| ⚖️ **Medium** | Medium Confidence (Unlimited) | [📥 Download](https://spydisec.com/medium_confidence_unlimited.txt) |
| 🔬 **Low** | Low Confidence (All Others) | [📥 Download](https://spydisec.com/low_confidence.txt) |
| 📊 **Research** | Full Research Blocklist | [📥 Download](https://spydisec.com/fullIPblocklist.txt) |
| 🗄️ **Archive** | Permanent (Append-Only) | [📥 Download](https://spydisec.com/permanentfullIPblocklist.txt) |


<details>
<summary>🔍 <strong>Confidence Scoring Details</strong></summary>

- **High**: 2+ sources, score ≥8 (ThreatFox high-conf, C2 trackers)
- **Medium**: 1+ sources, score ≥3
- **Low**: All other intelligence
- **Whitelist**: CDN protection (Cloudflare, Akamai, Fastly)

</details>

---

## 🌐 Domain Blocklists

*Independent category processing - import any/all into Pi-hole/AdGuard*

<!-- DOMAIN_STATS_START -->
| Category | Blocklist | Download |
|:--------:|-----------|:--------:|
| 🛡️ **Security** | Malicious Domains | [📥 Download](https://spydisec.com/maliciousblocklist.txt) |
| 📧 **Spam** | Spam/Scam/Abuse Domains | [📥 Download](https://spydisec.com/spamblocklist.txt) |
| 📺 **Privacy** | Ads & Tracking Domains | [📥 Download](https://spydisec.com/adsblocklist.txt) |
| 🗄️ **Archive** | Permanent Domains (Append-Only) | [📥 Download](https://spydisec.com/permanentMaliciousDomainList.txt) |



---

### 📁 Whitelisting  

**Reduce false positives using these curated lists:**  

| Name                              | Purpose                                                                 | Raw URL                                                                 |
|-----------------------------------|-----------------------------------------------------------------------------|-------------------------------------------------------------------------|
| **Removed IPs**       | Legitimate IPs removed from the various IP blocklist                         | [📥 Raw](https://github.com/spydisec/spydithreatintel/tree/main/iplist/removedips) |
| **Whitelisted IPs**                 | Critical infrastructure IPs (Cloudflare, Akamai, Fastly, and more)                 | [📥 Raw](https://raw.githubusercontent.com/spydisec/spydithreatintel/refs/heads/main/whitelist/wl_iplist/cdnips.txt) |

---

## 🕵️ Tracked Threats & Source list

1. Actively monitored infrastructure across 50+ threat actors:

<details>
<summary>🔍 Expand Threat Catalog</summary>

| C2s                       | Malware                          | Botnets      |
|---------------------------|----------------------------------|--------------|
| Cobalt Strike             | AcidRain Stealer                | 7777         |
| Metasploit Framework      | Misha Stealer (AKA Grand Misha) | BlackNET     |
| Covenant                  | Patriot Stealer                 | Doxerina     |
| Mythic                    | RAXNET Bitcoin Stealer          | Scarab       |
| Brute Ratel C4            | Titan Stealer                   | 63256        |
| Posh                      | Collector Stealer               | Kaiji        |
| Sliver                    | Mystic Stealer                  | MooBot       |
| Deimos                    | Gotham Stealer                  | Mozi         |
| PANDA                     | Meduza Stealer                  |              |
| NimPlant C2               | Quasar RAT                      |              |
| Havoc C2                  | ShadowPad                       |              |
| Caldera                   | AsyncRAT                        |              |
| Empire                    | DcRat                           |              |
| Ares                      | BitRAT                          |              |
| Hak5 Cloud C2             | DarkComet Trojan                |              |
| Pantegana                 | XtremeRAT Trojan                |              |
| Supershell                | NanoCore RAT Trojan             |              |
| Poseidon C2               | Gh0st RAT Trojan                |              |
| Viper C2                  | DarkTrack RAT Trojan            |              |
| Vshell                    | njRAT Trojan                    |              |
| Villain                   | Remcos Pro RAT Trojan           |              |
| Nimplant C2               | Poison Ivy Trojan               |              |
| RedGuard C2               | Orcus RAT Trojan                |              |
| Oyster C2                 | ZeroAccess Trojan               |              |
| byob C2                   | HOOKBOT Trojan                  |              |
|                           | RisePro Stealer                 |              |
|                           | NetBus Trojan                   |              |
|                           | Bandit Stealer                  |              |
|                           | Mint Stealer                    |              |
|                           | Mekotio Trojan                  |              |
|                           | Gozi Trojan                     |              |
|                           | Atlandida Stealer               |              |
|                           | VenomRAT                        |              |
|                           | Orcus RAT                       |              |
|                           | BlackDolphin                    |              |
|                           | Artemis RAT                     |              |
|                           | Godzilla Loader                 |              |
|                           | Jinx Loader                     |              |
|                           | Netpune Loader                  |              |
|                           | SpyAgent                        |              |
|                           | SpiceRAT                        |              |
|                           | Dust RAT                        |              |
|                           | Pupy RAT                        |              |
|                           | Atomic Stealer                  |              |
|                           | Lumma Stealer                   |              |
|                           | Serpent Stealer                 |              |
|                           | Axile Stealer                   |              |
|                           | Vector Stealer                  |              |
|                           | Z3us Stealer                    |              |
|                           | Rastro Stealer                  |              |
|                           | Darkeye Stealer                 |              |
|                           | AgniStealer                     |              |
|                           | Epsilon Stealer                 |              |
|                           | Bahamut Stealer                 |              |
|                           | Unam Web Panel / SilentCryptoMiner |           |
|                           | Vidar Stealer                   |              |
|                           | Kraken RAT                      |              |
|                           | Bumblebee Loader                |              |
|                           | Viper RAT                       |              |
|                           | Spectre Stealer                 |              |

</details>

2. **Sources**: 12+ curated feeds including C2 servers, honeypot data, Mass-scanners, and OSINT feeds.

<details>
<summary>📚 View Full Source List</summary>

| Sources                   | Source URL                                                                 |
|---------------------------|----------------------------------------------------------------------------|
| C2 IP Feed                | [C2_iplist.txt](https://raw.githubusercontent.com/spydisec/spydithreatintel/refs/heads/main/iplist/C2IPs/osintc2feed.txt) |
| Honeypot Master list      | [honeypot_iplist.txt](https://raw.githubusercontent.com/spydisec/spydithreatintel/refs/heads/main/iplist/honeypot/honeypot_extracted_feed.txt)     |
| maltrail_scanners         | [maltrail_ips.txt](https://raw.githubusercontent.com/stamparm/maltrail/master/trails/static/mass_scanner.txt)         |
| botvrij_eu                | [botvrij_eu](https://www.botvrij.eu/data/ioclist.ip-dst.raw)                                                        |
| feodotracker              | [feodotracker](https://feodotracker.abuse.ch/downloads/ipblocklist.txt)                                                        |
| feodotracker_recommended  | [feodotracker_recommended](https://feodotracker.abuse.ch/downloads/ipblocklist_recommended.txt)                                                        |
| Blocklist_de_all          | [Blocklist_de_all](https://lists.blocklist.de/lists/all.txt)                                                        |
| ThreatView_High_Confidence| [ThreatView_High_Confidence](https://threatview.io/Downloads/IP-High-Confidence-Feed.txt)                                                        |
| IPsumLevel_7              | [IPsumLevel7](https://raw.githubusercontent.com/stamparm/ipsum/refs/heads/master/levels/7.txt)                                                        |
| CINS_Score                | [CINS_Score](https://cinsscore.com/list/ci-badguys.txt)                                                        |
| DigitalSide               | [DigitalSide](https://osint.digitalside.it/Threat-Intel/lists/latestips.txt)                                                        |
| duggytuxy                 | [duggytuxy](https://raw.githubusercontent.com/duggytuxy/malicious_ip_addresses/refs/heads/main/botnets_zombies_scanner_spam_ips.txt)                                                        |
| etnetera.cz               | [etnetera.cz](https://security.etnetera.cz/feeds/etn_aggressive.txt)                                                        |
| emergingthreats-compromised| [ET_Comp](https://rules.emergingthreats.net/blockrules/compromised-ips.txt)                                                        |
| greensnow.co              | [greensnow.co](https://blocklist.greensnow.co/greensnow.txt)                                                         |
| Threatfox         | [Threatfox](https://threatfox.abuse.ch/export)     |
| More coming Soon!         | [Future Updates](#)                                                        |

</details>

3. Whitelist Coverage Matrix:

<details>
<summary> View Whitelist Sources 🛡️</summary>

| Provider       | Type                   | Coverage                      | Source Link                                                                 |
|----------------|------------------------|-------------------------------|-----------------------------------------------------------------------------|
| Cloudflare     | CDN IPv4/IPv6          | Global CDN                    | [Cloudflare IPs](https://www.cloudflare.com/ips/)                           |
| Akamai         | CDN IPv4/IPv6          | Global CDN & Shield IPs       | [Akamai IPs](https://techdocs.akamai.com/property-manager/pdfs/akamai_ipv4_CIDRs.txt)    |
| Fastly         | CDN IPv4/IPv6          | Global CDN                    | [Fastly IPs](https://api.fastly.com/public-ip-list)                         |
| Tailscale      | DERP & Control Panel   | Relay servers and control plane| [Tailscale DERP](https://login.tailscale.com/derpmap/default)                            |
| Uptime Robot   | IPv4                   | UptimeRobot Monitoring        | [UptimeRobot IPs](https://uptimerobot.com/inc/files/ips/IPv4.txt)           |

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

**Build a cleaner, more actionable feed**  
We welcome contributions to enhance this resource for:  

- **Individuals**: Simplify personal network security  
- **SMBs**: Deploy cost-effective threat blocking  
- **Enterprises**: Integrate scalable threat intelligence  

**Key Focus Areas**:  
🔹 **Deduplication**: Help eliminate redundant entries across feeds  
🔹 **Reduce False Positive**: Help eliminate false positive IOCs from the feeds.  
🔹 **Validation**: Flag false positives or outdated indicators  
🔹 **Context**: Add threat actor/geo-tags for better filtering  
🔹 **Automation**: Suggest workflow improvements for data curation  

**How to Help**:  

1. Submit verified IOCs via Pull Request  
2. Report duplicate entries in [Issues](https://github.com/spydisec/spydithreatintel/issues)
3. Report false positive in [Issues](https://github.com/spydisec/spydithreatintel/issues)  
4. Share feedback on enterprise/SMB integration patterns  
5. Improve documentation for non-technical users  

All contributors are acknowledged in our [Credits](https://github.com/spydisec/spydithreatintel/wiki/Contributors).  

---

## 📡 Contact me

- **E-Mail**: [spyditi@proton.me](mailto:spyditi@proton.me) (PGP: [Key](https://pastebin.com/igL3mGVb))

[![OSINT Powered](https://img.shields.io/badge/Intel-OSINT_Powered-yellow?style=for-the-badge)](#)
