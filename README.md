# Spydi's ThreatIntel 🚨

Welcome to the **spydithreatintel** repository! 

This is a work-in-progress repository dedicated to sharing various Indicators of Compromise (IOCs) from production systems experiencing security incidents. 🔍💻

- **Update Status Malicious IP List**
  - ![Status](https://github.com/spydisec/spydithreatintel/actions/workflows/getuniqueips.yml/badge.svg)

## 🔒 Block / Filter List Usage 📜

### C2 IP Feed (extracted from Shodan)

- **File:** [Master_C2_iplist.txt](https://raw.githubusercontent.com/spydisec/spydithreatintel/refs/heads/main/C2IPFeed/master_c2_iplist.txt)
- A Shodan-powered threat feed identifying exposed C2 infrastructure (malware/botnet-linked). Integrates with firewalls/SIEMs (e.g., pfSense) to block malicious traffic.
- Special thanks to various CTI researchers in open-source land. For More information please visit: [Montysecurity](https://github.com/montysecurity/C2-Tracker)

### Tracked C2, Malware & Botnets
<details>
<summary>Click to expand the full list ▶️</summary>

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

### IP Addresses

- **File:** [agr_unique_ips.txt](https://raw.githubusercontent.com/spydisec/spydithreatintel/refs/heads/main/agr_unique_ips.txt)
- Blocklist contains a list of IP addresses that have been identified as malicious. Community members can directly integrate this file into their firewall configurations to block these IPs and enhance network security. Please ensure to review the contents before implementing to suit your specific security needs.

### Domains

The repository also includes a list of domains categorized for blocking:  
The lists below are generated from various OSINT feeds (Sefinek-Blocklist, Maltrail, Firebog, AdAway, and more). 

**A unique feature of this list is that it does not include any duplicate entries, ensuring that all three categories malicious, spam, and advers are distinct.**

- **🛑 Advers/Tracking Domains:**  
  A collection of domains used for tracking and advertising purposes.  
  - **File:** [advs/unique_advtracking_domains.txt](https://raw.githubusercontent.com/spydisec/spydithreatintel/refs/heads/main/advs/unique_advtracking_domains.txt)  

- **⚠️ Malicious Domains:**  
  Domains identified as associated with malicious activity.  
  - **File:** [mal/unique_malicious_domains.txt](https://raw.githubusercontent.com/spydisec/spydithreatintel/refs/heads/main/mal/unique_malicious_domains.txt)  

- **❌ Spam Domains:**  
  Domains recognized for sending spam and potentially harmful content.  
  - **File:** [spam/unique_spamscamabuse_domains.txt](https://raw.githubusercontent.com/spydisec/spydithreatintel/refs/heads/main/spam/unique_spamscamabuse_domains.txt)  

These domains can be integrated with **Pi-hole** or firewall configurations to block unwanted traffic, enhancing your network's security.

## ⚠️ False Positives

If you come across any false positives or believe an IP address or domain listed in this repository should not be blocked, please let us know! Your input is crucial and helps enhance the quality of data shared here. You can report false positives by opening an issue and providing detailed information for prompt review.

## 📝 Contributions

Your contributions are welcome! If you have relevant data or IOCs to share, please feel free to submit a pull request or open an issue.

## 📫 Contact

For inquiries or further collaboration, reach out via [spyditi@proton.me](mailto:spyditi@proton.me).  
I have a public PGP key available for sending encrypted emails: https://pastebin.com/igL3mGVb
