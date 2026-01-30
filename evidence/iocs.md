# Indicators of Compromise (IOCs)

## Overview
This document contains all Indicators of Compromise (IOCs) identified during the Widget Co. breach investigation. These IOCs should be used for threat hunting, blocking rules, and SIEM alert configuration.

---

## IOC Summary

| Category | Count | Severity |
|----------|-------|----------|
| Malicious Domains | 2 | CRITICAL |
| Suspicious IP Addresses | 1 | CRITICAL |
| Compromised User Accounts | 3 | CRITICAL |
| Affected Systems | 6 | HIGH |
| Attack Techniques | 5 | HIGH |

---

## Network IOCs

### Malicious Domains

#### Domain 1: glasslu.com
```
Domain: glasslu.com
Type: Phishing infrastructure
First Seen: 2022-10-12 08:15:23
Last Seen: 2022-10-12 08:15:23
Resolution: 203.0.113.45 (example IP)
Status: ACTIVE (as of investigation)
Threat Level: CRITICAL
```

**Recommended Actions**:
- ✅ Block at DNS resolver
- ✅ Block at web proxy
- ✅ Add to threat intelligence feeds
- ✅ Configure SIEM alert for any future queries

**Detection Query**:
```spl
index=* query="glasslu.com" OR query="*.glasslu.com"
| table _time, src_ip, user, query
```

---

#### Domain 2: www.aeon.jp.co.glasslu.com
```
Domain: www.aeon.jp.co.glasslu.com
Type: Phishing subdomain (typosquatting)
First Seen: 2022-10-14 09:30:12
Last Seen: 2022-10-14 09:30:12
Parent Domain: glasslu.com
Status: ACTIVE
Threat Level: CRITICAL
```

**Characteristics**:
- Impersonates legitimate Japanese retailer (AEON)
- Uses subdomain obfuscation
- Targets specific individuals

**Recommended Actions**:
- ✅ Block entire .glasslu.com domain and all subdomains
- ✅ Implement subdomain wildcard blocking

**Detection Query**:
```spl
index=* query="*.glasslu.com"
| rex field=query "(?<subdomain>.+)\.glasslu\.com"
| table _time, src_ip, user, subdomain, query
```

---

### IP Addresses

#### IP 1: 180.76.54.93
```
IP Address: 180.76.54.93
Geolocation: China (CN)
ASN: Unknown
First Seen: 2022-10-12 10:42:17
Last Seen: 2022-10-24 22:45:00
Activity Duration: 12 days
Threat Level: CRITICAL
```

**Associated Activities**:
- MFA bypass attempts (5+ instances)
- Brute force attacks (23 failed logins)
- Password vault access
- Cloud portal authentication
- IT Admin portal access

**Attack Pattern**:
- Consistent IP (no rotation)
- After-hours activity
- Multiple system access
- Privilege escalation

**Recommended Actions**:
- ✅ Block at perimeter firewall
- ✅ Add to IDS/IPS blocklist
- ✅ Check historical logs for prior activity
- ✅ Monitor for future connection attempts
- ✅ Add to global threat intel sharing

**Detection Query**:
```spl
index=* src_ip="180.76.54.93" OR dst_ip="180.76.54.93"
| stats count by sourcetype, action, user
| sort -count
```

---

## Account IOCs

### Compromised Accounts

#### Account 1: BDRVLS
```
Username: BDRVLS
Status: COMPROMISED
Compromise Method: Phishing
First Compromise: 2022-10-12 08:15:23
Attack Vector: Clicked malicious link, credentials stolen
Systems Accessed by Attacker:
  - Billing Portal
  - Productivity Suite
  - WidgetApp
  - Password Vault
Current Status: DISABLED
```

**Timeline**:
1. Oct 12, 08:15 - Clicked phishing link
2. Oct 12, 10:42 - Account used for MFA bypass
3. Oct 12, 11:45 - Brute force attack
4. Oct 13, 14:23 - Password vault accessed

**Recommended Actions**:
- ✅ Account disabled
- ✅ Force password reset (post-investigation)
- ✅ Review all historical activity
- ✅ Notify user for security awareness training
- ✅ Enable enhanced monitoring on account

---

#### Account 2: DDDXUB
```
Username: DDDXUB
Status: CREDENTIALS STOLEN
Theft Method: Password vault breach
First Unauthorized Use: 2022-10-14 16:45:33
Privilege Level: IT Administrator
Systems Accessed by Attacker:
  - Cloud Infrastructure Portal
  - IT Administration Portal
Current Status: DISABLED
```

**Timeline**:
1. Oct 13, 14:24 - Credentials stolen from vault
2. Oct 14, 16:45 - First unauthorized use (Cloud)
3. Oct 24, 22:15 - IT Admin portal access

**Impact**:
- HIGH - Administrative access compromised
- Potential for persistent backdoors
- Risk of configuration changes

**Recommended Actions**:
- ✅ Account disabled
- ✅ Audit all administrative actions (Oct 14-24)
- ✅ Review system configurations for unauthorized changes
- ✅ Check for created backdoor accounts
- ✅ Force password reset across all systems

---

#### Account 3: TIIYAW
```
Username: TIIYAW
Status: TARGETED (Not Compromised)
Attack Method: Phishing attempt
Date: 2022-10-14 09:30:12
Outcome: User did not submit credentials
Current Status: ACTIVE (monitored)
```

**Observation**:
- User clicked link but recognized phishing attempt
- No credential submission
- No subsequent unauthorized activity

**Recommended Actions**:
- ✅ Commend user for recognizing attack
- ✅ Monitor account for anomalies
- ✅ Use as case study in security training

---

## System IOCs

### Affected Systems

| System | Access Method | First Access | Severity |
|--------|---------------|--------------|----------|
| **Billing Portal** | MFA Bypass | 2022-10-12 10:42:17 | HIGH |
| **Productivity Suite** | MFA Bypass | 2022-10-12 10:55:00 | MEDIUM |
| **WidgetApp** | Brute Force + MFA Bypass | 2022-10-12 11:45:00 | HIGH |
| **Password Vault** | Stolen Credentials (No MFA) | 2022-10-13 14:23:45 | CRITICAL |
| **Cloud Portal** | Stolen Credentials (DDDXUB) | 2022-10-14 16:45:33 | CRITICAL |
| **IT Admin Portal** | Stolen Credentials (DDDXUB) | 2022-10-24 22:15:47 | CRITICAL |

---

## Behavioral IOCs

### Attack Techniques (MITRE ATT&CK Mapping)

#### T1566.002 - Phishing: Spearphishing Link
```
Technique: Spearphishing Link
Description: User BDRVLS clicked malicious link in email
Date: 2022-10-12 08:15:23
IOC: glasslu.com domain access
Evidence: DNS logs
```

---

#### T1078 - Valid Accounts
```
Technique: Use of Valid Accounts
Description: Attacker used stolen credentials (BDRVLS, DDDXUB)
Date Range: 2022-10-12 to 2022-10-24
IOC: Authentication from unusual IP (180.76.54.93)
Evidence: VPN, MFA, application logs
```

---

#### T1110 - Brute Force
```
Technique: Password Guessing
Description: 23 failed login attempts in 15 minutes
Date: 2022-10-12 11:45:00
Target: WidgetApp
IOC: Repeated failed authentication from same IP
Evidence: WidgetApp authentication logs
```

---

#### T1550 - Use Alternate Authentication Material
```
Technique: MFA Bypass
Description: Circumvented multi-factor authentication
Date: 2022-10-12 10:42:17 onwards
Systems: Billing, Productivity Suite, WidgetApp
IOC: MFA bypass events from 180.76.54.93
Evidence: MFA logs
```

---

#### T1078.003 - Valid Accounts: Local Accounts
```
Technique: Credential Access via Password Vault
Description: Accessed password vault to harvest credentials
Date: 2022-10-13 14:23:45
Credentials Stolen: 8 accounts including DDDXUB (admin)
IOC: Bulk credential retrieval pattern
Evidence: Password vault access logs
```

---

## Detection Rules

### SIEM Alert Rules

#### Alert 1: Malicious Domain Access
```spl
# Alert on glasslu.com domain queries
index=* sourcetype=dns query="*.glasslu.com"
| stats count by user, src_ip, query
| eval severity="CRITICAL"
| where count > 0
```
**Alert Trigger**: Any DNS query to glasslu.com  
**Action**: Immediate investigation + user isolation

---

#### Alert 2: Suspicious IP Authentication
```spl
# Alert on authentication from 180.76.54.93
index=* src_ip="180.76.54.93" action IN ("login", "auth", "success")
| table _time, user, sourcetype, action
| eval severity="CRITICAL"
```
**Alert Trigger**: Any auth attempt from attacker IP  
**Action**: Block IP + disable account

---

#### Alert 3: MFA Bypass Detection
```spl
# Alert on multiple MFA bypasses
index=* sourcetype=mfa action="bypass"
| stats count by user, src_ip
| where count > 2
| eval severity="HIGH"
```
**Alert Trigger**: 3+ MFA bypasses from same source  
**Action**: Account review + MFA config audit

---

#### Alert 4: Password Vault Bulk Access
```spl
# Alert on unusual vault access patterns
index=* sourcetype=password_vault action IN ("login", "retrieve")
| bucket _time span=10m
| stats count by _time, user, src_ip
| where count > 3
| eval severity="CRITICAL"
```
**Alert Trigger**: 3+ credential retrievals in 10 minutes  
**Action**: Immediate vault lockdown + investigation

---

#### Alert 5: After-Hours Admin Access
```spl
# Alert on after-hours privileged access
index=* sourcetype IN ("it_admin", "cloud") action="login"
| eval hour=tonumber(strftime(_time, "%H"))
| where hour < 6 OR hour > 22
| eval severity="HIGH"
| table _time, user, src_ip, sourcetype
```
**Alert Trigger**: Admin portal access outside 6 AM - 10 PM  
**Action**: Verify legitimacy + alert SOC

---

## IOC Distribution Formats

### CSV Export
```csv
ioc_type,ioc_value,first_seen,last_seen,severity,description
domain,glasslu.com,2022-10-12 08:15:23,2022-10-12 08:15:23,CRITICAL,Phishing infrastructure
domain,www.aeon.jp.co.glasslu.com,2022-10-14 09:30:12,2022-10-14 09:30:12,CRITICAL,Phishing subdomain
ip,180.76.54.93,2022-10-12 10:42:17,2022-10-24 22:45:00,CRITICAL,Attacker source IP
account,BDRVLS,2022-10-12 08:15:23,2022-10-13 14:35:00,CRITICAL,Compromised via phishing
account,DDDXUB,2022-10-14 16:45:33,2022-10-24 22:45:00,CRITICAL,Stolen admin credentials
```

### STIX 2.1 Format (Sample)
```json
{
  "type": "indicator",
  "spec_version": "2.1",
  "id": "indicator--widget-co-2022-001",
  "created": "2022-10-25T00:00:00.000Z",
  "modified": "2025-04-23T00:00:00.000Z",
  "name": "Widget Co. Breach - Malicious Domain",
  "pattern": "[domain-name:value = 'glasslu.com']",
  "pattern_type": "stix",
  "valid_from": "2022-10-12T08:15:23.000Z",
  "indicator_types": ["malicious-activity"],
  "threat_intelligence_rank": 95
}
```

---

## Threat Intelligence Sharing

### Recommended Sharing Platforms
- ✅ VirusTotal
- ✅ AlienVault OTX
- ✅ MISP (Malware Information Sharing Platform)
- ✅ Sector-specific ISACs

### Anonymized Sharing Template
```
Threat Type: Phishing + Credential Theft + Privilege Escalation
Industry: [Redacted]
Geography: United States
Attacker Origin: China (CN)
IOCs:
  - Domain: glasslu.com
  - IP: 180.76.54.93
Attack Duration: 12 days
Impact: CRITICAL - Admin access compromised
```

---

## IOC Refresh Schedule

| IOC Category | Review Frequency | Last Updated | Next Review |
|--------------|------------------|--------------|-------------|
| Domains | Weekly | 2025-04-23 | 2025-04-30 |
| IP Addresses | Weekly | 2025-04-23 | 2025-04-30 |
| User Accounts | Monthly | 2025-04-23 | 2025-05-23 |
| Behavioral Patterns | Quarterly | 2025-04-23 | 2025-07-23 |

---

## Additional Resources

- **MITRE ATT&CK**: https://attack.mitre.org/
- **VirusTotal**: https://www.virustotal.com/
- **AlienVault OTX**: https://otx.alienvault.com/
- **Splunk ES Content**: https://docs.splunk.com/

---

**Document Owner**: Team 09 - Security Operations  
**Classification**: TLP:WHITE (Shareable)  
**Last Updated**: April 23, 2025  
**Version**: 1.0
