# Attack Timeline - Widget Co. Breach Investigation

## Overview
This document provides a comprehensive chronological timeline of the security breach that occurred at Widget Co. during October 2022. The attack spanned **12 days** and progressed through **6 distinct phases**.

---

## Timeline Visualization

```
Oct 12, 2022                                                  Oct 24, 2022
    |                                                                |
    |---------------------------------------------------------------|
    ↓                                                                ↓
INITIAL          MFA           BRUTE        VAULT        LATERAL      PRIVILEGE
COMPROMISE      BYPASS         FORCE        ACCESS       MOVEMENT     ESCALATION
```

---

## Detailed Event Timeline

### 📅 October 12, 2022 - Day 1: Initial Compromise

#### Event 1: Phishing Email Received
**Time**: ~08:00 AM EST  
**Target**: User BDRVLS  
**Description**: Phishing email delivered containing malicious link  
**Status**: Email gateway did not block

#### Event 2: Malicious Link Clicked
**Time**: 08:15:23 AM EST  
**User**: BDRVLS  
**Action**: Clicked link to `https://glasslu.com`  
**Source IP**: Internal (10.0.1.50)  
**Evidence**: DNS logs show query to glasslu.com  

```
Evidence ID: DNS-001
Timestamp: 2022-10-12 08:15:23
User: BDRVLS
Query: glasslu.com
Response: 203.0.113.45
Status: RESOLVED
```

#### Event 3: Credential Submission (Assumed)
**Time**: 08:15-08:20 AM EST  
**Assumption**: User entered credentials on fake login page  
**Note**: No direct evidence, inferred from subsequent attacker activity

#### Event 4: First MFA Bypass Attempt
**Time**: 10:42:17 AM EST  
**User**: BDRVLS  
**System**: Billing Portal  
**Source IP**: 180.76.54.93 (CN - China)  
**Action**: MFA bypass successful  
**Method**: Unknown (possible backup code or SMS interception)

```
Evidence ID: MFA-001
Timestamp: 2022-10-12 10:42:17
User: BDRVLS
App: Billing
Action: bypass
Source IP: 180.76.54.93
Geo: China (CN)
```

#### Event 5: Additional MFA Bypasses
**Time**: 10:42 AM - 11:30 AM EST  
**Systems Affected**:
- Productivity Suite (10:55 AM)
- WidgetApp (11:12 AM)
- Billing Portal (11:30 AM)

**Total Bypass Count**: 5 attempts  
**Success Rate**: 100%

#### Event 6: Brute Force Attack Begins
**Time**: 11:45:00 AM EST  
**Target**: WidgetApp login portal  
**User**: BDRVLS (attacker using stolen credentials)  
**Source IP**: 180.76.54.93  
**Failed Attempts**: 23 in 15 minutes  

```
Evidence ID: AUTH-001
Time Window: 11:45:00 - 12:00:00
Failed Logins: 23
Success: 1 (after failed attempts)
Pattern: Automated/scripted attack
```

---

### 📅 October 13, 2022 - Day 2: Credential Harvesting

#### Event 7: Password Vault Access
**Time**: 14:23:45 PM EST  
**User**: BDRVLS  
**Source IP**: 180.76.54.93  
**Action**: Successful login to Password Vault  
**Vulnerability**: No MFA enforcement on vault access  

```
Evidence ID: VAULT-001
Timestamp: 2022-10-13 14:23:45
User: BDRVLS
Source IP: 180.76.54.93
Action: login
Status: SUCCESS
MFA Required: NO (vulnerability confirmed)
```

#### Event 8: Credential Retrieval
**Time**: 14:24:00 - 14:35:00 PM EST  
**Credentials Accessed**: 8 different accounts  
**Target Accounts**:
- DDDXUB (IT Admin)
- TIIYAW (Manager)
- 6 other accounts (non-privileged)

**Evidence**: Vault access logs show retrieval pattern

```
Evidence ID: VAULT-002
Credentials Retrieved:
  - DDDXUB (Privilege Level: Admin)
  - TIIYAW (Privilege Level: Manager)
  - [6 others redacted]
Duration: 11 minutes
Action Type: BULK_RETRIEVAL
Alert: CRITICAL
```

---

### 📅 October 14, 2022 - Day 3: Lateral Movement Preparation

#### Event 9: Second Phishing Attempt
**Time**: 09:30:12 AM EST  
**Target**: User TIIYAW  
**Domain**: `www.aeon.jp.co.glasslu.com` (subdomain variant)  
**Outcome**: Link clicked but credentials NOT submitted  
**Note**: User likely recognized attack and did not proceed

```
Evidence ID: DNS-002
Timestamp: 2022-10-14 09:30:12
User: TIIYAW
Query: www.aeon.jp.co.glasslu.com
Action: Domain accessed
Credential Submission: NO (assumed)
Follow-up Activity: NONE
```

#### Event 10: First Use of DDDXUB Credentials
**Time**: 16:45:33 PM EST  
**User**: DDDXUB (compromised credentials)  
**System**: Cloud Portal  
**Source IP**: 180.76.54.93  
**Action**: Successful authentication  

```
Evidence ID: CLOUD-001
Timestamp: 2022-10-14 16:45:33
User: DDDXUB
Source IP: 180.76.54.93
System: Cloud Infrastructure Portal
Action: login
Status: SUCCESS
Previous Activity: NONE (first use of this account from this IP)
Alert: HIGH - Anomalous login location
```

#### Event 11: Cloud Resource Enumeration
**Time**: 16:45 - 17:30 PM EST  
**Actions**:
- List virtual machines (16:47 PM)
- View security groups (16:52 PM)
- Access storage buckets (17:05 PM)
- Query IAM policies (17:22 PM)

**Pattern**: Reconnaissance phase, attacker mapping infrastructure

---

### 📅 October 15-23, 2022 - Days 4-12: Dormancy Period

**Activity**: Minimal to no observable activity  
**Duration**: 8 days  
**Hypothesis**: Attacker analyzing gathered data and planning next steps  

**Low-level Activity Detected**:
- Sporadic Cloud Portal logins (3 instances)
- No administrative actions
- No data exfiltration detected

---

### 📅 October 24, 2022 - Day 13: Privilege Escalation

#### Event 12: IT Admin Portal Access
**Time**: 22:15:47 PM EST (After hours)  
**User**: DDDXUB  
**Source IP**: 180.76.54.93  
**System**: IT Administration Portal  
**Action**: Successful login with admin privileges  

```
Evidence ID: ADMIN-001
Timestamp: 2022-10-24 22:15:47
User: DDDXUB
Source IP: 180.76.54.93
System: IT Admin Portal
Privilege Level: FULL ADMINISTRATOR
Time Context: After hours (10:15 PM)
Alert: CRITICAL - Privileged access from suspicious IP
```

#### Event 13: Administrative Actions
**Time**: 22:16 - 22:45 PM EST  
**Actions Performed**:
1. View user directory (22:16 PM)
2. Access system configuration (22:23 PM)
3. Review audit logs (22:31 PM) - Possible anti-forensics
4. Query backup systems (22:38 PM)

**Impact**: High-level reconnaissance of critical infrastructure

#### Event 14: Investigation Initiated
**Time**: October 25, 2022 (Day 14)  
**Trigger**: Security team noticed anomalous after-hours admin access  
**Action**: Incident response initiated  
**Outcome**: Accounts disabled, investigation launched

---

## Attack Progression Summary

| Phase | Duration | Systems Compromised | Accounts Affected |
|-------|----------|---------------------|-------------------|
| **Phase 1**: Initial Compromise | 4 hours | DNS, Email | BDRVLS |
| **Phase 2**: MFA Bypass | 1 hour | Billing, Productivity, WidgetApp | BDRVLS |
| **Phase 3**: Brute Force | 15 minutes | WidgetApp | BDRVLS |
| **Phase 4**: Credential Theft | 11 minutes | Password Vault | BDRVLS → 8 accounts |
| **Phase 5**: Lateral Movement | 45 minutes | Cloud Portal | DDDXUB |
| **Phase 6**: Privilege Escalation | 30 minutes | IT Admin Portal | DDDXUB |

**Total Attack Duration**: 12 days (Oct 12 - Oct 24)  
**Active Attack Duration**: ~7 hours across multiple days  
**Dormancy Period**: 8 days (reconnaissance/planning)

---

## Critical Timestamps

```
2022-10-12 08:15:23 → Phishing link clicked (BDRVLS)
2022-10-12 10:42:17 → First MFA bypass (Billing)
2022-10-12 11:45:00 → Brute force attack begins
2022-10-13 14:23:45 → Password vault accessed
2022-10-13 14:24:00 → Credentials harvested (DDDXUB)
2022-10-14 16:45:33 → First use of DDDXUB account (Cloud)
2022-10-24 22:15:47 → IT Admin portal accessed
2022-10-25 09:00:00 → Incident response initiated
```

---

## Geographic Movement

| Time | Location | IP Address | ASN |
|------|----------|------------|-----|
| Oct 12, 08:15 | United States (Internal) | 10.0.1.50 | Widget Co. Network |
| Oct 12, 10:42 | China | 180.76.54.93 | Unknown ISP |
| Oct 13-24 | China | 180.76.54.93 | Consistent IP (possible VPS) |

**Analysis**: Attacker operated from single IP in China, suggesting:
- VPS/Cloud server usage
- No attempt to hide via VPN rotation
- Possible state-sponsored or organized cybercrime group

---

## Indicators of Compromise (IOCs) - Temporal

| IOC Type | Value | First Seen | Last Seen |
|----------|-------|------------|-----------|
| Domain | glasslu.com | 2022-10-12 08:15:23 | 2022-10-12 08:15:23 |
| Domain | www.aeon.jp.co.glasslu.com | 2022-10-14 09:30:12 | 2022-10-14 09:30:12 |
| IP Address | 180.76.54.93 | 2022-10-12 10:42:17 | 2022-10-24 22:45:00 |
| User Account | BDRVLS (compromised) | 2022-10-12 08:15:23 | 2022-10-13 14:35:00 |
| User Account | DDDXUB (stolen credentials) | 2022-10-14 16:45:33 | 2022-10-24 22:45:00 |

---

## Key Observations

1. **Speed of Attack**: Initial compromise to vault access in 1.5 days
2. **Persistence**: 12-day total duration suggests advanced threat actor
3. **Dormancy**: 8-day gap indicates patience and planning
4. **After-Hours Activity**: Final escalation at 10 PM (off-hours)
5. **Single IP**: Consistent use of 180.76.54.93 (no IP rotation)

---

## Next Steps from Timeline Analysis

1. ✅ Disable accounts: BDRVLS, DDDXUB
2. ✅ Block IP: 180.76.54.93 at firewall
3. ✅ Block domains: *.glasslu.com at DNS/proxy
4. ✅ Review all actions by DDDXUB from Oct 14-24
5. ✅ Audit all credentials accessed from vault on Oct 13
6. ✅ Force password reset for all 8+ affected accounts

---

**Timeline Compiled By**: Team 09  
**Source Data**: Splunk SIEM Analysis (10 log sources)  
**Confidence Level**: HIGH (corroborated across multiple sources)  
**Last Updated**: April 23, 2025
