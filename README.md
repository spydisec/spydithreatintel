# Spydi's ThreatIntel 🚨

Welcome to the **spydithreatintel** repository! 

This is a work-in-progress repository dedicated to sharing various Indicators of Compromise (IOCs) from production systems experiencing security incidents. 🔍💻

## 🔒 Block / Filter List Usage 📜

### IP Addresses

- **File:** `agr_unique_ips.txt`  
  The `agr_unique_ips.txt` file contains a list of IP addresses that have been identified as malicious. Community members can directly integrate this file into their firewall configurations to block these IPs and enhance network security. Please ensure to review the contents before implementing to suit your specific security needs.

### Domains

The repository also includes a list of domains categorized for blocking:

- **🛑 Advers/Tracking Domains:**  
  A collection of domains used for tracking and advertising purposes.

- **⚠️ Malicious Domains:**  
  Domains identified as associated with malicious activity.

- **❌ Spam Domains:**  
  Domains recognized for sending spam and potentially harmful content.

These domains can be integrated with **Pi-hole** or firewall configurations to block unwanted traffic, enhancing your network's security.

## ⚠️ False Positives

If you encounter any false positives or believe that an IP address or domain listed in this repository should not be blocked, please report it! Your feedback is valuable and helps improve the quality of data shared in this repository. You can report false positives by opening an issue, including details of your findings for prompt review.

## 📝 Contributions

Your contributions are welcome! If you have relevant data or IOCs to share, please feel free to submit a pull request or open an issue.

## 📫 Contact

For inquiries or further collaboration, reach out via [spyditi@proton.me](mailto:spyditi@proton.me).  
I have a public PGP key available for sending encrypted emails:
-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZ4ifbBYJKwYBBAHaRw8BAQdA3TIpmme/vRVrR2lOAJt+7rBjzgfkcaUG
TSMrHVS+GifNJXNweWRpdGlAcHJvdG9uLm1lIDxzcHlkaXRpQHByb3Rvbi5t
ZT7CwBEEExYKAIMFgmeIn2wDCwkHCZBAGPdOpR0sQ0UUAAAAAAAcACBzYWx0
QG5vdGF0aW9ucy5vcGVucGdwanMub3JnXcV8+Hk5rOteuN4880MQXGINqF4k
IU6KCLl5L/jyEmwDFQoIBBYAAgECGQECmwMCHgEWIQSCxc2fNYqCMgk7WlhA
GPdOpR0sQwAAkrABAMivNFedkiobICBI1MkHkcHIBA33oGfVU02Ov644V8Mz
AQD24q7n7BTUTE0KnJe7YE3k3YwVvBWLV7GhdLO8IwEWA844BGeIn2wSCisG
AQQBl1UBBQEBB0DFOAYEXvEHnYh7ygqB7OwboTGcKpE4u5IDry83+ALPdQMB
CAfCvgQYFgoAcAWCZ4ifbAmQQBj3TqUdLENFFAAAAAAAHAAgc2FsdEBub3Rh
dGlvbnMub3BlbnBncGpzLm9yZzUK6UEob0ITQGIegJ9t3yqselHmyDIDVovv
VYjJSGvKApsMFiEEgsXNnzWKgjIJO1pYQBj3TqUdLEMAAIUeAQDUkepIptgg
CASjk+bUbKhyDiWL+m4ozmcDD2RJE5tGsAEA3ReacBMSLRBGGjLe0fwe6dpK
w4VGcApXV/zwq+oQzwo=
=rMVp
-----END PGP PUBLIC KEY BLOCK-----
