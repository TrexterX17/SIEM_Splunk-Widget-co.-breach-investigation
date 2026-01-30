# Affected Accounts - Widget Co. Breach

## Overview
This document details all user accounts affected during the October 2022 security breach at Widget Co. It includes compromise status, impact assessment, and remediation actions.

---

## Account Impact Summary

| Account | Status | Compromise Method | Severity | Remediation Status |
|---------|--------|-------------------|----------|-------------------|
| **BDRVLS** | Compromised | Phishing | CRITICAL | ✅ Disabled |
| **DDDXUB** | Credentials Stolen | Vault Breach | CRITICAL | ✅ Disabled |
| **TIIYAW** | Targeted (Not Compromised) | Phishing Attempt | MEDIUM | ⚠️ Monitored |
| **6 Additional Accounts** | Credentials Exposed | Vault Breach | HIGH | ✅ Reset Required |

**Total Affected**: 9 accounts  
**Directly Compromised**: 2 accounts  
**Credentials Stolen**: 7 accounts  
**Attempted (Unsuccessful)**: 1 account

---

## Detailed Account Analysis

### 🔴 BDRVLS - Primary Victim Account

#### Account Information
```
Username: BDRVLS
Department: [Redacted for privacy]
Role: Standard User
Privilege Level: User (non-admin)
Employment Status: Active
Account Created: [Historical data]
```

#### Compromise Details
```
Compromise Date: October 12, 2022, 08:15:23 AM
Compromise Method: Phishing (clicked malicious link)
Phishing URL: https://glasslu.com
Credential Submission: Assumed YES (based on subsequent activity)
Attacker First Use: October 12, 2022, 10:42:17 AM
```

#### Systems Accessed by Attacker

| System | Access Time | Access Method | Actions Performed |
|--------|-------------|---------------|-------------------|
| **Billing Portal** | Oct 12, 10:42 AM | MFA Bypass | Login, view billing data |
| **Productivity Suite** | Oct 12, 10:55 AM | MFA Bypass | Email access, document viewing |
| **WidgetApp** | Oct 12, 11:45 AM | Brute Force + MFA Bypass | Multiple failed attempts, eventual access |
| **Password Vault** | Oct 13, 14:23 PM | Direct Login (No MFA) | Credential harvesting |

#### Attack Timeline
```
Oct 12, 08:15 → Phishing link clicked
Oct 12, 10:42 → First unauthorized access (Billing)
Oct 12, 10:55 → Productivity Suite accessed
Oct 12, 11:45 → Brute force attack on WidgetApp
Oct 13, 14:23 → Password Vault compromised
Oct 13, 14:35 → Last observed activity with this account
```

#### Impact Assessment
```
Data Accessed:
  ✓ Billing records and financial data
  ✓ Internal emails and documents
  ✓ Password vault (8 credentials stolen)
  ✓ Application data

Lateral Movement:
  ✓ Used as stepping stone to access Password Vault
  ✓ Enabled theft of DDDXUB admin credentials
  
Duration of Compromise: 1.5 days
Unauthorized Actions: 15+ login events
Systems Compromised: 4
```

#### Remediation Actions Taken
- [x] Account disabled (Oct 25, 2022)
- [x] All active sessions terminated
- [x] Password reset performed
- [x] MFA re-enrolled with hardware token
- [x] User notified and interviewed
- [x] Mandatory security awareness training scheduled

#### Post-Incident Monitoring
```
Monitoring Period: 90 days
Enhanced Logging: Enabled
Behavioral Analytics: Active
Geo-restriction: US-only access
Alert Threshold: Any anomalous activity
```

#### User Notification
```
Date Notified: October 25, 2022
Notification Method: In-person meeting with IT Security
User Cooperation: Full cooperation, recognized phishing in retrospect
User Quote: "I thought it was a legitimate billing notification"
Training Scheduled: October 28, 2022
```

---

### 🔴 DDDXUB - Stolen Administrative Credentials

#### Account Information
```
Username: DDDXUB
Department: Information Technology
Role: IT Administrator
Privilege Level: Full Administrator
Critical Systems Access:
  - Cloud Infrastructure
  - IT Administration Portal
  - User Management
  - System Configuration
Employment Status: Active
```

#### Compromise Details
```
Credential Theft Date: October 13, 2022, 14:24 PM
Theft Method: Password Vault breach (BDRVLS account)
First Unauthorized Use: October 14, 2022, 16:45:33 PM
Last Unauthorized Use: October 24, 2022, 22:45:00 PM
Total Duration: 10 days
```

#### Systems Accessed by Attacker

| System | First Access | Last Access | Risk Level |
|--------|-------------|-------------|------------|
| **Cloud Infrastructure Portal** | Oct 14, 16:45 PM | Oct 23, 18:30 PM | CRITICAL |
| **IT Administration Portal** | Oct 24, 22:15 PM | Oct 24, 22:45 PM | CRITICAL |

#### Unauthorized Administrative Actions

##### Cloud Portal Activity (Oct 14 - Oct 23)
```
Oct 14, 16:47 → List virtual machines (reconnaissance)
Oct 14, 16:52 → View security groups
Oct 14, 17:05 → Access storage buckets (potential data exfiltration risk)
Oct 14, 17:22 → Query IAM policies
Oct 15-23 → Sporadic logins (3 instances, minimal activity)
```

##### IT Admin Portal Activity (Oct 24)
```
Oct 24, 22:16 → View user directory
Oct 24, 22:23 → Access system configuration
Oct 24, 22:31 → Review audit logs (anti-forensics concern)
Oct 24, 22:38 → Query backup systems
```

#### Impact Assessment
```
Administrative Privilege Abuse:
  ✓ Full access to cloud infrastructure
  ✓ Ability to create/modify/delete resources
  ✓ User management capabilities
  ✓ Audit log access (potential evidence tampering)
  
Potential Persistent Access:
  ⚠️ Possible backdoor account creation (under investigation)
  ⚠️ SSH key deployment risk
  ⚠️ Configuration changes pending audit
  
Data Exposure Risk:
  ⚠️ Storage bucket access (data exfiltration possible)
  ⚠️ VM access (lateral movement risk)
  ⚠️ Backup system queries (ransom ware concern)

Duration: 10 days of privileged access
Severity: CRITICAL
```

#### Forensic Investigation Status
```
Configuration Audit: IN PROGRESS
  - Reviewing all config changes Oct 14-24
  - Checking for unauthorized accounts
  - Analyzing SSH key deployments
  
Data Exfiltration Analysis: IN PROGRESS
  - Network traffic analysis (outbound transfers)
  - Storage access logs under review
  - No confirmed exfiltration (as of report date)
  
Backdoor Detection: IN PROGRESS
  - Scanning for unauthorized accounts
  - Reviewing scheduled tasks/cron jobs
  - Analyzing startup scripts
```

#### Remediation Actions Taken
- [x] Account disabled (Oct 25, 2022)
- [x] All sessions terminated globally
- [x] Password changed (new secure credential generated)
- [x] MFA reset and re-enrolled
- [x] Audit of all administrative actions Oct 14-24
- [x] Legitimate account owner interviewed
- [ ] Comprehensive cloud environment audit (ONGOING)
- [ ] Backdoor elimination (if found)

#### Post-Incident Monitoring
```
Monitoring Period: 180 days (extended due to admin privileges)
Cloud Activity: Full audit logging enabled
Admin Actions: Require secondary approval
Geo-restriction: US-only + VPN required
Alert Threshold: ANY administrative action
```

#### Legitimate User Notification
```
Date Notified: October 25, 2022
User Awareness: Unaware of credential theft until notified
Cooperation: Full cooperation with investigation
User Quote: "I never accessed these systems from that IP or at those times"
Additional Training: Advanced security for privileged users
```

---

### ⚠️ TIIYAW - Attempted Phishing (Unsuccessful)

#### Account Information
```
Username: TIIYAW
Department: [Redacted]
Role: Manager
Privilege Level: Manager (elevated, non-admin)
Employment Status: Active
```

#### Attack Details
```
Attack Date: October 14, 2022, 09:30:12 AM
Attack Method: Phishing (subdomain variant)
Phishing URL: https://www.aeon.jp.co.glasslu.com
Link Clicked: YES
Credentials Submitted: NO (user recognized attack)
Outcome: Attack unsuccessful, no compromise
```

#### User Behavior (Positive Security Indicator)
```
User Recognition: Identified suspicious URL structure
Action Taken: Did not submit credentials
Reported: Notified IT immediately after
Outcome: No unauthorized access detected
```

#### Impact Assessment
```
Compromise Status: NOT COMPROMISED
Data Accessed: NONE
Systems Affected: NONE
Severity: LOW (attempted only)
```

#### Remediation Actions
- [x] Account monitored for anomalies (30 days)
- [x] User commended for recognizing attack
- [x] Credential rotation (precautionary)
- [x] User debriefed for training materials

#### Recognition
```
Security Awareness: EXCELLENT
Used as Case Study: Security awareness training
Commendation: Formal recognition from IT Security
```

---

### 🟠 Additional Vault-Exposed Accounts (6 Accounts)

#### Overview
```
Total Accounts: 6
Exposure Method: Password Vault breach (Oct 13)
Credential Access: Stolen by attacker
Unauthorized Use: UNKNOWN (under investigation)
Risk Level: HIGH (precautionary measures required)
```

#### Affected Account List
*[Account names redacted for privacy - available in classified appendix]*

```
Account 1: [REDACTED] - Standard User
Account 2: [REDACTED] - Standard User  
Account 3: [REDACTED] - Developer
Account 4: [REDACTED] - Manager
Account 5: [REDACTED] - Analyst
Account 6: [REDACTED] - Support Staff
```

#### Remediation Actions (All 6 Accounts)
- [x] Credentials forcibly reset
- [x] Users notified of potential exposure
- [x] Enhanced monitoring (60 days)
- [x] MFA re-enrollment
- [x] Historical activity review (no anomalies found)
- [x] Geo-restriction enabled

#### Investigation Status
```
Credential Usage: No unauthorized use detected (as of report date)
Log Analysis: Complete - no suspicious activity
Risk Assessment: MEDIUM (exposed but not actively used)
Ongoing Monitoring: Active
```

---

## Remediation Summary

### Immediate Actions (Completed)
- ✅ Disabled 2 compromised accounts (BDRVLS, DDDXUB)
- ✅ Terminated all active sessions
- ✅ Forced password reset for 8 accounts
- ✅ MFA re-enrollment for all affected users
- ✅ Enhanced logging enabled

### Short-term Actions (In Progress)
- 🔄 Comprehensive cloud environment audit
- 🔄 Backdoor detection and elimination
- 🔄 Data exfiltration analysis
- 🔄 Configuration change review

### Long-term Actions (Planned)
- 📅 Mandatory MFA for Password Vault
- 📅 Enhanced security awareness training (all staff)
- 📅 Privileged Access Management (PAM) implementation
- 📅 Just-In-Time (JIT) access for admin accounts
- 📅 Behavioral analytics deployment

---

## Lessons Learned

### Account Security Gaps Identified
1. **Password Vault**: No MFA enforcement (CRITICAL)
2. **MFA Bypass**: Weak configuration allowing circumvention
3. **Phishing Susceptibility**: Users not recognizing advanced phishing
4. **Privileged Account Management**: Credentials stored in vault (high risk)

### Positive Observations
1. **User TIIYAW**: Excellent security awareness (attack prevented)
2. **Quick Detection**: Anomalous activity detected within 24 hours
3. **Incident Response**: Swift action to disable accounts

---

## Account Access Matrix

| Account | Billing | Productivity | WidgetApp | Vault | Cloud | IT Admin |
|---------|---------|--------------|-----------|-------|-------|----------|
| BDRVLS | ✓ Compromised | ✓ Compromised | ✓ Compromised | ✓ Compromised | ✗ | ✗ |
| DDDXUB | ✗ | ✗ | ✗ | ✗ | ✓ Stolen Creds | ✓ Stolen Creds |
| TIIYAW | ✗ | ✗ | ✗ | ✗ | ✗ | ✗ |

---

## Contact Information

**For questions about specific accounts**:  
IT Security Team - security@widgetco.com

**For user support and password resets**:  
IT Help Desk - helpdesk@widgetco.com

---

**Document Classification**: CONFIDENTIAL - Internal Use Only  
**Document Owner**: Team 09 - Incident Response  
**Last Updated**: April 23, 2025  
**Version**: 1.0
