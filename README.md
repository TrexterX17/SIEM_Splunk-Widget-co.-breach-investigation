# 🔐 Widget Co. Forensic Investigation - Cybersecurity Breach Analysis

[![Splunk](https://img.shields.io/badge/Splunk-000000?style=for-the-badge&logo=splunk&logoColor=white)](https://www.splunk.com/)
[![Security](https://img.shields.io/badge/Security-Forensics-red?style=for-the-badge)](https://github.com)
[![SIEM](https://img.shields.io/badge/SIEM-Analysis-blue?style=for-the-badge)](https://github.com)

A comprehensive cybersecurity forensic investigation using Splunk SIEM to analyze a multi-stage breach involving phishing, MFA bypass, credential theft, and privilege escalation.

---

## 📋 Table of Contents

- [Project Overview](#-project-overview)
- [Key Findings](#-key-findings)
- [Attack Timeline](#-attack-timeline)
- [Technical Analysis](#-technical-analysis)
- [Dashboards](#-dashboards)
- [Technologies Used](#-technologies-used)
- [Investigation Methodology](#-investigation-methodology)
- [Recommendations](#-recommendations)
- [Repository Structure](#-repository-structure)
- [How to Use](#-how-to-use)
- [Team](#-team)

---

## 🎯 Project Overview

This project represents a real-world forensic investigation conducted on Widget Co.'s infrastructure following a suspected security breach in October 2022. Using **Splunk Enterprise** as the primary SIEM platform, our team analyzed over **10 different log sources** to identify, track, and document a sophisticated multi-stage cyberattack.

### Investigation Scope
- **Duration**: October 12-26, 2022
- **Log Sources**: 10 CSV datasets (VPN, DNS, Cloud, MFA, WidgetApp, Password Vault)
- **Platform**: Splunk Enterprise
- **Outcome**: Confirmed breach with complete attack timeline and IOCs

---

## 🚨 Key Findings

### Breach Confirmed ✅

**Attack Vector**: Phishing → Credential Theft → MFA Bypass → Lateral Movement → Privilege Escalation

| Date | Event | Affected User | Evidence |
|------|-------|---------------|----------|
| **Oct 12** | Phishing Attack | BDRVLS | Clicked malicious link `glasslu.com` |
| **Oct 12** | MFA Bypass | BDRVLS | Multiple bypass attempts from IP `180.76.54.93` |
| **Oct 12** | Brute Force | BDRVLS | Repeated login failures on WidgetApp |
| **Oct 13** | Vault Compromise | BDRVLS | Successful Password Vault access |
| **Oct 14** | Second Phishing | TIIYAW | Attempted phishing (unsuccessful) |
| **Oct 14, 24** | Privilege Escalation | DDDXUB | Cloud & IT Admin Portal access with stolen credentials |

### Indicators of Compromise (IOCs)

```
Malicious Domains:
- glasslu.com
- www.aeon.jp.co.glasslu.com

Suspicious IP Addresses:
- 180.76.54.93 (Primary attacker IP)

Compromised Accounts:
- BDRVLS (Initial victim)
- DDDXUB (Escalated privileges)
- TIIYAW (Attempted phishing)
```

---

## 📊 Attack Timeline

```
┌──────────────────────────────────────────────────────────────┐
│                    ATTACK KILL CHAIN                          │
└──────────────────────────────────────────────────────────────┘

Oct 12, 2022
    ↓
[Phishing Email] → User BDRVLS clicks malicious link
    ↓
[Credential Theft] → Attacker obtains username/password
    ↓
[MFA Bypass] → Exploits weak MFA configuration
    ↓
[Brute Force] → Multiple login attempts on WidgetApp
    ↓
Oct 13, 2022
    ↓
[Password Vault Access] → Successful login from 180.76.54.93
    ↓
[Credential Harvesting] → DDDXUB credentials stolen
    ↓
Oct 14, 2022
    ↓
[Lateral Movement] → Access to Cloud systems
    ↓
Oct 24, 2022
    ↓
[Privilege Escalation] → IT Admin Portal compromised
```

---

## 🔬 Technical Analysis

### Splunk Queries & Detection Logic

Our investigation leveraged multiple Splunk Processing Language (SPL) queries to correlate events across different data sources:

#### 1. **Phishing Detection**
```spl
index=widget_co sourcetype=dns
| search query IN ("glasslu.com", "*.glasslu.com")
| stats count by user, query, src_ip
| sort -count
```

#### 2. **MFA Bypass Identification**
```spl
index=widget_co sourcetype=mfa action="bypass"
| stats count by user, src_ip, app
| where count > 3
```

#### 3. **Brute Force Detection**
```spl
index=widget_co sourcetype=widgetapp action="failed_login"
| stats count by user, src_ip
| where count > 5
```

#### 4. **Password Vault Anomalies**
```spl
index=widget_co sourcetype=password_vault action="login"
| search src_ip="180.76.54.93"
| table _time, user, src_ip, action
```

#### 5. **Privilege Escalation Tracking**
```spl
index=widget_co (sourcetype=cloud OR sourcetype=it_admin)
| search user="DDDXUB"
| table _time, user, src_ip, action, system
```

### Data Sources Analyzed

| Source | Events Analyzed | Key Findings |
|--------|----------------|--------------|
| DNS Logs | 15,000+ | Malicious domain access |
| MFA Logs | 8,500+ | Multiple bypass attempts |
| VPN Logs | 12,000+ | Suspicious IP geolocations |
| WidgetApp | 20,000+ | Brute force patterns |
| Password Vault | 3,200+ | Unauthorized access |
| Cloud Portal | 5,600+ | Privilege escalation |

---

## 📈 Dashboards

We created three comprehensive Splunk dashboards for real-time monitoring and incident visualization:

### Dashboard 1: Breach Correlation Dashboard
- Consolidated view of all breach-related events
- Timeline visualization of attack progression
- User activity correlation matrix

### Dashboard 2: Malicious Activity Detection
- Real-time DNS threat monitoring
- VPN geolocation analysis
- MFA bypass alerts
- Failed authentication tracking

### Dashboard 3: Executive Summary Dashboard
- High-level metrics and KPIs
- Attack vector visualization
- Impact assessment charts
- Remediation status tracker

📁 *Dashboard XML files available in `/dashboards` directory*

---

## 🛠️ Technologies Used

| Technology | Purpose |
|------------|---------|
| **Splunk Enterprise** | SIEM platform for log aggregation and analysis |
| **SPL (Splunk Processing Language)** | Query language for data correlation |
| **CSV Data Sources** | Log file format for ingestion |
| **Splunk Dashboards** | Visualization and reporting |
| **Git/GitHub** | Version control and documentation |

---

## 🔍 Investigation Methodology

### 1. Data Ingestion
- Imported 10 CSV datasets into Splunk
- Configured field extractions and data normalization
- Created indexes for efficient searching

### 2. Anomaly Detection
Focused on identifying:
- ✅ After-hours activity patterns
- ✅ Geolocation anomalies
- ✅ Failed authentication spikes
- ✅ Unusual DNS queries
- ✅ Privilege escalation attempts

### 3. IOC Correlation
- Cross-referenced suspicious IPs with known threat intelligence
- Traced malicious domains across multiple log sources
- Built event timelines for affected users

### 4. Evidence Collection
- Documented all findings with screenshots
- Preserved log entries for forensic integrity
- Created exportable reports for stakeholders

### 5. Dashboard Development
- Built interactive visualizations
- Configured real-time alerting
- Designed for both technical and executive audiences

---

## 💡 Recommendations

### For IT/Security Teams (Technical)

#### Immediate Actions
1. **Account Isolation**
   - Disable accounts: BDRVLS, DDDXUB
   - Force password reset for all users
   - Review access logs for additional compromises

2. **MFA Hardening**
   - Eliminate bypass mechanisms
   - Enforce hardware token/authenticator apps
   - Remove SMS/email fallback options

3. **Endpoint Forensics**
   - Scan all devices used by compromised accounts
   - Deploy EDR solutions
   - Perform memory analysis for persistence mechanisms

#### Long-term Security Enhancements
- ✅ Implement geo-fencing for authentication
- ✅ Deploy real-time Splunk alerting for IOCs
- ✅ Enforce password rotation every 60 days
- ✅ Configure account lockout after 3 failed attempts
- ✅ Extend MFA to legacy applications

### For Leadership (Procedural)

1. **Security Awareness Training**
   - Quarterly phishing simulations
   - Mandatory cybersecurity training for all employees
   - Department-specific threat briefings

2. **Incident Response Planning**
   - Update IR playbooks for phishing scenarios
   - Define breach notification procedures
   - Establish communication protocols

3. **Resource Allocation**
   - Hire dedicated SOC analyst
   - Invest in EDR/XDR solutions
   - Budget for regular security audits

4. **Access Governance**
   - Quarterly access reviews
   - Implement Just-In-Time (JIT) privileged access
   - Enforce principle of least privilege

---

## 🤝 Contributing

This is a completed academic project. However, feedback and suggestions are welcome! Feel free to open an issue or submit a pull request.

---

## ⭐ Acknowledgments

- Widget Co. (fictional case study)
- Splunk Documentation and Community
- Cybersecurity Analytics Course Instructors

---

<div align="center">

**If you found this project helpful, please consider giving it a ⭐!**

Made with <3 by Team 09

</div>
