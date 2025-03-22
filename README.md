---

# Spydi's ThreatIntel Feed 🛡️
Welcome to the **Spydi Threat Intelligence Repository** – A curated collection of security indicators derived from real-world incidents and open-source feeds.  

This repository aggregates IOCs (IPs and domains) from multiple OSINT feeds, enforces deduplication, and removes false positives to maintain **clean, actionable blocklists**. Designed for clarity and reliability, the feeds are optimized for use in personal networks, SMBs, and enterprise security systems.  

## Table of Contents
- 🔥[IP Threat Feeds](https://github.com/spydisec/spydithreatintel/tree/main?tab=readme-ov-file#-ip-threat-feeds)
- 🌐[Domain Blocklists](https://github.com/spydisec/spydithreatintel/tree/main?tab=readme-ov-file#-ip-threat-feeds)
- 🕵️[Tracked Threats](https://github.com/spydisec/spydithreatintel/tree/main?tab=readme-ov-file#%EF%B8%8F-tracked-threats)
- 📁[Whitelist Files]()
- 📦[Permanent Blocklists](https://github.com/spydisec/spydithreatintel/tree/main?tab=readme-ov-file#-permanent-blocklists)
- 🙌[Acknowledgements](https://github.com/spydisec/spydithreatintel/tree/main?tab=readme-ov-file#-acknowledgements)
- 🤝[Community Contributions](https://github.com/spydisec/spydithreatintel/tree/main?tab=readme-ov-file#-community-contributions)
- 📡[Contact me](https://github.com/spydisec/spydithreatintel/tree/main?tab=readme-ov-file#-contact-me)

---

## 📊 Feed Status Badges
[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fspydisec%2Fspydithreatintel&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://github.com/spydisec/spydithreatintel) [![Honeypot Unique IPs](https://github.com/spydisec/spydithreatintel/actions/workflows/honeypot_ips.yml/badge.svg)](https://github.com/spydisec/spydithreatintel/actions/workflows/honeypot_ips.yml) [![Daily Malicious IP List Update](https://github.com/spydisec/spydithreatintel/actions/workflows/updatemasterfeed.yml/badge.svg)](https://github.com/spydisec/spydithreatintel/actions/workflows/updatemasterfeed.yml) [![Daily C2 IP Feed Update](https://github.com/spydisec/spydithreatintel/actions/workflows/osintc2feed.yml/badge.svg)](https://github.com/spydisec/spydithreatintel/actions/workflows/osintc2feed.yml)

---

## 🔥 IP Threat Feeds
### 📜 Malicious IP Master List
**High-confidence indicators** from multiple OSINT Feed, this deduplicated list provides a unified view of malicious IP addresses. Moreover, whitelisted IPs are removed from the this list reducing false positive.
```
https://spydisec.com/maliciousips.txt
```
- **Sources**: 12+ curated feeds including C2 servers, honeypot data, Mass-scanners, and OSINT feeds.

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

---

## 🌐 Domain Blocklists Download (Pi-Hole, AdGuard, uBlock Origin)
#### 🔫 Spam/Scam :
```
https://spydisec.com/spamblocklist.txt
```
#### 🎯 Malicious :
```
https://spydisec.com/maliciousblocklist.txt
```
#### 🛑 Advers/Tracking :
```
https://spydisec.com/adsblocklist.txt
```
---
## 🕵️ Tracked Threats
**Actively monitored infrastructure** across 50+ threat actors:

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

---
## Whitelist Files 📁
**A curated security filtering system that combines blocklisting with intelligent whitelisting for essential services.**

| Whitelist Name          | Purpose                                                                 | File                      | Raw Link                                                                 |
|-------------------------|-------------------------------------------------------------------------|---------------------------|--------------------------------------------------------------------------|
| Personal Allowlist      | My personal Pihole allow list                                           | `mypiholewhitelisteddomains.txt`  | [`📥 Raw`](https://raw.githubusercontent.com/spydisec/spydithreatintel/refs/heads/main/whitelist/mypiholewhitelisteddomains.txt) |
| OSINT Verified          | Domains derived from OSINT whitelist feeds                              | `osintwhitelisteddomains.txt`     | [`📥 Raw`](https://raw.githubusercontent.com/spydisec/spydithreatintel/refs/heads/main/whitelist/osintwhitelisteddomains.txt)    |
| CDN Infrastructure      | Critical CDN IP ranges excluded from IP Blocklist                       | `cdnips.txt`   | [`📥 Raw`](https://raw.githubusercontent.com/spydisec/spydithreatintel/refs/heads/main/whitelist/cdnips.txt)  |

<details>
<summary>CDN Coverage Matrix 🛡️</summary>

| Provider       | Type         | Coverage                             |
|----------------|--------------|--------------------------------------|
| Cloudflare     | CDN IPv4/IPv6    | Global CDN                |
| Akamai         | CDN IPv4/IPv6   | Global CDN & Shield IPs              |
| Fastly         | CDN IPv4/IPv6        | Global CDN                |
| Tailscale      | DERP & Control Panel | Relay servers and control plane      |
</details>

---
## 📦 Permanent Blocklists
**Persistent IOCs** with historical tracking:

| Type       | Description                          | Raw URL                                                                     |
|------------|--------------------------------------|----------------------------------------------------------------------------|
| 📡 IPs     | Permanent malicious IP addresses     | [permanent_IPList.txt](https://raw.githubusercontent.com/.../permanent_IPList.txt) |
| 🌍 Domains | Long-term malicious domains (WIP)    | [permanent_DomainList.txt](https://raw.githubusercontent.com/.../permanent_DomainList.txt) |

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
