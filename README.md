<div align="center">
  <h1>Spydi's ThreatIntel Feed 🛡️</h1>

  ![GitHub repo size](https://img.shields.io/github/repo-size/spydisec/spydithreatintel) [![Daily IP List Update](https://github.com/spydisec/spydithreatintel/actions/workflows/updatemasterfeed.yml/badge.svg)](https://github.com/spydisec/spydithreatintel/actions/workflows/updatemasterfeed.yml) [![Daily C2 Feed Update](https://github.com/spydisec/spydithreatintel/actions/workflows/osintc2feed.yml/badge.svg)](https://github.com/spydisec/spydithreatintel/actions/workflows/osintc2feed.yml)  
</div>

## Table of Contents
- 🔥[IP Threat Feeds](https://github.com/spydisec/spydithreatintel/tree/main?tab=readme-ov-file#-ip-threat-feeds)
- 🌐[Domain Blocklists](https://github.com/spydisec/spydithreatintel/tree/main?tab=readme-ov-file#-ip-threat-feeds)
- 🕵️[Tracked Threats](https://github.com/spydisec/spydithreatintel/tree/main?tab=readme-ov-file#%EF%B8%8F-tracked-threats)
- 📁[Whitelist Files](https://github.com/spydisec/spydithreatintel?tab=readme-ov-file#-whitelist-files)
- 📦[Permanent Blocklists](https://github.com/spydisec/spydithreatintel/tree/main?tab=readme-ov-file#-permanent-blocklists)
- 🙌[Acknowledgements](https://github.com/spydisec/spydithreatintel/tree/main?tab=readme-ov-file#-acknowledgements)
- 🤝[Community Contributions](https://github.com/spydisec/spydithreatintel/tree/main?tab=readme-ov-file#-community-contributions)
- 📡[Contact me](https://github.com/spydisec/spydithreatintel/tree/main?tab=readme-ov-file#-contact-me)

---
## 📋 Blocklists  
### 🔥 IP Blocklists  
| Name                              | Description                                                                 | Raw URL                                                                 |
|-----------------------------------|-----------------------------------------------------------------------------|-------------------------------------------------------------------------|
| **Master IP Blocklist**           | Raw aggregated IPs from 12+ OSINT feeds (may contain FPs)                  | [📥 Raw](https://raw.githubusercontent.com/spydisec/spydithreatintel/main/master_malicious_iplist.txt) |
| **Filtered IP Blocklist (Low FP)**| Curated IPs with whitelisting applied for minimal false positives           | [📥 Raw](https://spydisec.com/maliciousips.txt)                         |
| **C2 Server IPs**                 | Command-and-Control infrastructure from threat actors                       | [📥 Raw](https://raw.githubusercontent.com/spydisec/spydithreatintel/main/iplist/C2IPs/osintc2feed.txt) |

### 🌐 Domain Blocklists  
| Name                              | Description                                                                 | Raw URL                                                                 |
|-----------------------------------|-----------------------------------------------------------------------------|-------------------------------------------------------------------------|
| **Spam/Scam Domains**             | Phishing, scam, and spam domains                                           | [📥 Raw](https://spydisec.com/spamblocklist.txt)                        |
| **Malware Domains**               | Active malware distribution, C2, and exploit kit domains                   | [📥 Raw](https://spydisec.com/maliciousblocklist.txt)                   |
| **Ads & Tracking Domains**        | Aggressive ads, trackers, and analytics domains                            | [📥 Raw](https://spydisec.com/adsblocklist.txt)                         |

### 📦 Permanent Blocklists  
Persistent threats validated over 6+ months.  
| Name                              | Description                                                                 | Raw URL                                                                 |
|-----------------------------------|-----------------------------------------------------------------------------|-------------------------------------------------------------------------|
| **Permanent Malicious IPs**       | High-confidence IPs with long-term malicious activity                      | [📥 Raw](https://spydisec.com/permanentMaliciousIPList.txt)             |
| **Permanent Malicious Domains**   | Domains linked to persistent campaigns (e.g., ransomware, APTs)            | [📥 Raw](https://spydisec.com/permanentMaliciousDomainList.txt)         |

### 📁 Whitelisting  
**Reduce false positives using these curated lists:**  
| Name                              | Purpose                                                                 | Raw URL                                                                 |
|-----------------------------------|-----------------------------------------------------------------------------|-------------------------------------------------------------------------|
| **Whitelisted IPs**               | Legitimate IPs removed from the master blocklist                         | [📥 Raw](https://raw.githubusercontent.com/spydisec/spydithreatintel/main/removed_from_blocklist.txt) |
| **CDN IP Ranges**                 | Critical infrastructure IPs (Cloudflare, Akamai, Fastly)                 | [📥 Raw](https://raw.githubusercontent.com/spydisec/spydithreatintel/main/whitelist/cdnips.txt) |

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
| More coming Soon!         | [Future Updates](#)                                                        |
</details>

3. Whitelist CDN Coverage Matrix:

<details>
<summary> View CDN Whitelsit 🛡️</summary>

| Provider       | Type         | Coverage                             |
|----------------|--------------|--------------------------------------|
| Cloudflare     | CDN IPv4/IPv6    | Global CDN                |
| Akamai         | CDN IPv4/IPv6   | Global CDN & Shield IPs              |
| Fastly         | CDN IPv4/IPv6        | Global CDN                |
| Tailscale      | DERP & Control Panel | Relay servers and control plane      |
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

**Special Thanks** to MontySecurity for their C2 Tracker framework.

The active sources listed contribute to the compilation of block lists but do not have a direct one-to-one correspondence. Each source has its own license; please consult the source files or repositories for details.

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

---
