<div align="center">
  <h1>Spydi's ThreatIntel Feed 🛡️</h1>

  ![GitHub repo size](https://img.shields.io/github/repo-size/spydisec/spydithreatintel) ![Daily IP List Update](https://healthchecks.io/b/2/b76af744-7b3f-4de6-b0cb-227a88bbc5aa.svg) ![Daily C2 Feed Update](https://healthchecks.io/b/2/ad6b7683-29fc-49f4-95d1-70c169e3d8e4.svg) ![Daily ThreatFox IP List Update](https://healthchecks.io/b/2/04eda84c-5084-404d-872b-9fc308e5517e.svg)
</div>

## 🚀 About This Project

Spydi's ThreatIntel Feed is a comprehensive threat intelligence platform that aggregates, curates, and maintains high-quality blocklists for malicious IPs and domains. The system combines data from multiple OSINT sources, honeypot networks, and threat intelligence feeds to provide actionable security data.

### Key Features:
- **🎯 Confidence-Based Tiers**: Production-ready IP blocklists optimized for different deployment scenarios
- **🔍 Multi-Source Validation**: Advanced scoring system with cross-reference validation across 12+ OSINT feeds  
- **🛡️ Smart Whitelisting**: CDN-aware filtering (Cloudflare, Akamai, Fastly) applied to all confidence tiers
- **⚡ Automated Updates**: Daily refresh with real-time threat intelligence integration
- **📊 Quality Metrics**: <0.1% false positive rate for high-confidence blocklists
- **🔬 Research Support**: Complete datasets available for academic and enterprise analysis
- **🚀 Enterprise-Ready**: Tiered outputs optimized for firewalls, SIEM systems, and monitoring platforms

### Use Cases:
- **🔥 Production Firewalls**: High-confidence limited lists for OPNsense/pfSense with minimal false positives
- **🏢 Enterprise Security**: Unlimited high-confidence feeds for advanced threat protection  
- **📊 SIEM Integration**: Medium-confidence feeds optimized for correlation rules and monitoring
- **🔍 Threat Hunting**: Comprehensive datasets for security research and investigation
- **🎓 Academic Research**: Complete historical datasets for threat landscape analysis
- **🚨 Incident Response**: Real-time IOC feeds for rapid threat containment

## Table of Contents
- 🎯[Confidence-Based IP Blocklists](https://github.com/spydisec/spydithreatintel?tab=readme-ov-file#-confidence-based-ip-blocklists-new) **[NEW]**
- 🔥[Legacy IP Blocklists](https://github.com/spydisec/spydithreatintel?tab=readme-ov-file#-legacy-ip-blocklists) 
- 🌐[Domain Blocklists](https://github.com/spydisec/spydithreatintel?tab=readme-ov-file#-domain-blocklists)
- 📁[Whitelist Files](https://github.com/spydisec/spydithreatintel?tab=readme-ov-file#-whitelisting)
- 🕵️[Tracked Threats & Source list](https://github.com/spydisec/spydithreatintel?tab=readme-ov-file#%EF%B8%8F-tracked-threats--source-list)
- 🙌[Acknowledgements](https://github.com/spydisec/spydithreatintel?tab=readme-ov-file#-acknowledgements)
- 🤝[Community Contributions](https://github.com/spydisec/spydithreatintel?tab=readme-ov-file#-community-contributions)
- 📡[Contact me](https://github.com/spydisec/spydithreatintel?tab=readme-ov-file#-contact-me)

**Each OSINT feed incorporated in this blocklist is governed by its own terms, conditions, and licensing agreements. By utilizing this compilation, you acknowledge these individual terms and agree to comply with them. Users are responsible for reviewing the original source repositories or documentation for specific licensing details and restrictions.**

---
## 📋 Blocklists    

### 🔥 Confidence-Based IP Blocklists **[NEW]** 
*Production-ready, tiered IP blocklists with multi-source validation and confidence scoring*

| Confidence Level | Blocklist Name                     | Download                                                     |
|------------------|------------------------------------|------------------------------------------------------------- |
| **🎯 High**      | **High Confidence Limited**       | [📥 Download](https://spydisec.com/high_confidence_limited.txt) |
| **🎯 High**      | **High Confidence Unlimited**     | [📥 Download](https://spydisec.com/high_confidence_unlimited.txt) |
| **⚖️ Medium**    | **Medium Confidence Limited**     | [📥 Download](https://spydisec.com/medium_confidence_limited.txt) |
| **⚖️ Medium**    | **Medium Confidence Unlimited**   | [📥 Download](https://spydisec.com/medium_confidence_unlimited.txt) |
| **🔬 Low**       | **Low Confidence**                | [📥 Download](https://spydisec.com/low_confidence.txt) |

### 📊 Research Dataset
*Complete dataset containing all IPs from above confidence levels after whitelisting*

```
https://spydisec.com/fullIPblocklist.txt
```
*Append-only dataset containing all historical confidence-scored IPs ever collected*

```
https://spydisec.com/permanentfullIPblocklist.txt
```

<details>
<summary>🔍 <strong>Confidence Scoring Methodology</strong></summary>

**Multi-Source Validation System:**
- **High Confidence**: IPs validated by 2+ authoritative sources with confidence score ≥8
- **Medium Confidence**: IPs from 1+ authoritative source with confidence score ≥3  
- **Low Confidence**: All other collected intelligence below medium threshold
- **Weight Scoring**: Premium sources (ThreatFox high-confidence, C2 trackers) receive higher weights
- **Cross-Reference Bonus**: Additional points for multi-source validation
- **Whitelist Filtering**: CDN protection (Cloudflare, Akamai, Fastly) applied to all tiers

**Quality Assurance:**
- **False Positive Rate**: <0.1% for high confidence, <1% for medium confidence
- **Source Attribution**: Full traceability of confidence decisions
- **Automatic Updates**: Daily refresh with real-time threat intelligence
- **Database Tracking**: Comprehensive logging of removed/whitelisted IPs

</details>


---

### 🔥 Legacy IP Blocklists  
*Traditional blocklists maintained for backward compatibility*

| Blocklist Name                | Description                                                                 | False Positive Risk | Download                                                     |
|-------------------------------|-----------------------------------------------------------------------------|---------------------|--------------------------------------------------------------|
| **Master IP Blocklist**       | Raw IPs from 12+ OSINT feeds (unfiltered)                                   | **High**            | [📥 Download](https://spydisec.com/master_malicious_iplist.txt) |
| **Main IP Blocklist**         | Curated IPs with whitelisting applied for minimal false positives           | **Low**             | [📥 Download](https://spydisec.com/maliciousips.txt) |
| **Permanent Malicious IPs**   | Append-only: all IPs ever seen in the Main IP Blocklist (unless whitelisted) | **Medium**          | [📥 Download](/fullIPblocklist.txt) |
| **C2 Server IPs Blocklist**   | Command-and-Control infrastructure from tracked threat actors                | **Low**             | [📥 Download](https://spydisec.com/osintc2feed.txt) |

### 🌐 Domain Blocklists **[ENHANCED]**
*Independent category processing with complete source fidelity*

| Name                              | Description                                                                 | Download                                                                 |
|-----------------------------------|-----------------------------------------------------------------------------|-------------------------------------------------------------------------------|
| **Malware Domains**               | **🛡️ Security**: Active malware distribution, C2, and exploit kit domains   | [📥 Download](https://spydisec.com/maliciousblocklist.txt)                 |
| **Spam/Scam Domains**             | **📧 Communication**: Phishing, scam, and spam domains                      | [📥 Download](https://spydisec.com/spamblocklist.txt)                      |
| **Ads & Tracking Domains**        | **📺 Privacy**: Aggressive ads, trackers, and analytics domains             | [📥 Download](https://spydisec.com/adsblocklist.txt)                       |
| **Permanent Malicious Domains**   | Append-only: all domains ever seen in the Malware Domains blocklist         | [📥 Download](https://spydisec.com/permanentMaliciousDomainList.txt)            |

<details>
<summary>🔄 <strong>Independent Category Processing</strong> **[NEW]**</summary>

**Source-Faithful Processing:**
- **Philosophy**: Preserve complete fidelity to original threat intelligence sources
- **Approach**: Each category processed independently with individual deduplication and whitelisting
- **Result**: Users can choose single or multiple lists based on deployment needs

**Key Benefits:**
- ✅ **Complete Source Fidelity**: Each category reflects exactly what threat intel sources provide
- ✅ **User Choice Flexibility**: Import single category or multiple lists into Pi-hole/AdGuard
- ✅ **Zero Intelligence Loss**: No domains removed due to artificial categorization conflicts
- ✅ **Overlap Transparency**: Cross-category statistics available for threat analysis
- ✅ **DNS Filter Ready**: Multiple lists can be safely imported without conflicts

**Deployment Options:**
- **Single List**: Use one category for focused protection (e.g., only malware blocking)
- **Multi-List**: Import all three for comprehensive coverage (recommended for Pi-hole/AdGuard)
- **Custom Mix**: Choose any combination based on specific security requirements

**Performance Results:**
- **Malicious**: 3.24M domains (65MB) - Complete malicious source coverage
- **Spam**: 1.47M domains (31MB) - Complete spam/scam source coverage  
- **Ads**: 368K domains (8.1MB) - Complete advertising/tracking source coverage
- **Overlap Preservation**: 707K domains preserved across multiple categories for user choice

</details>

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
