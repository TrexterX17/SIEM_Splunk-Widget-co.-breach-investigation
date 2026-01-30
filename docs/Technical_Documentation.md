# Technical Documentation - Widget Co. Breach Investigation

## Table of Contents
1. [Investigation Architecture](#investigation-architecture)
2. [Data Sources & Ingestion](#data-sources--ingestion)
3. [Splunk Configuration](#splunk-configuration)
4. [Analysis Techniques](#analysis-techniques)
5. [Query Development](#query-development)
6. [Dashboard Creation](#dashboard-creation)
7. [Evidence Preservation](#evidence-preservation)

---

## Investigation Architecture

### System Overview

```
┌─────────────────────────────────────────────────────────────┐
│                   DATA COLLECTION LAYER                      │
├─────────────────────────────────────────────────────────────┤
│  VPN Logs  │  DNS Logs  │  MFA Logs  │  Cloud Logs  │  etc. │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                   SPLUNK INGESTION                           │
├─────────────────────────────────────────────────────────────┤
│  • CSV Upload                                                │
│  • Field Extraction                                          │
│  • Index Configuration                                       │
│  • Time Normalization                                        │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                   ANALYSIS ENGINE                            │
├─────────────────────────────────────────────────────────────┤
│  • SPL Query Processing                                      │
│  • Pattern Recognition                                       │
│  • Correlation Logic                                         │
│  • Anomaly Detection                                         │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                   OUTPUT LAYER                               │
├─────────────────────────────────────────────────────────────┤
│  Dashboards  │  Reports  │  Alerts  │  Exported Evidence    │
└─────────────────────────────────────────────────────────────┘
```

---

## Data Sources & Ingestion

### Log Sources Overview

| Source Type | File Format | Events | Time Range | Key Fields |
|------------|-------------|--------|------------|------------|
| VPN Logs | CSV | ~12,000 | Oct 1-31, 2022 | user, src_ip, dst_ip, action, geo |
| DNS Logs | CSV | ~15,000 | Oct 1-31, 2022 | user, query, src_ip, response_code |
| MFA Logs | CSV | ~8,500 | Oct 1-31, 2022 | user, action, src_ip, app, result |
| WidgetApp Logs | CSV | ~20,000 | Oct 1-31, 2022 | user, action, src_ip, status |
| Password Vault | CSV | ~3,200 | Oct 1-31, 2022 | user, action, src_ip, credential_id |
| Cloud Portal | CSV | ~5,600 | Oct 1-31, 2022 | user, action, src_ip, resource |
| IT Admin Portal | CSV | ~4,100 | Oct 1-31, 2022 | user, action, src_ip, privilege_level |
| Billing System | CSV | ~6,300 | Oct 1-31, 2022 | user, action, src_ip |
| Productivity Suite | CSV | ~18,000 | Oct 1-31, 2022 | user, action, src_ip, app |
| Email Gateway | CSV | ~25,000 | Oct 1-31, 2022 | user, sender, recipient, subject |

### Ingestion Process

#### Step 1: Data Preparation
```bash
# Ensure all CSV files have consistent headers
# Verify timestamp formats
# Check for encoding issues

# Example CSV structure:
timestamp,user,action,src_ip,dst_ip,geo,status
2022-10-12 08:15:23,BDRVLS,login,180.76.54.93,10.0.1.50,CN,success
```

#### Step 2: Splunk Upload
```spl
# Settings → Add Data → Upload
# Source Type: csv
# Index: widget_co
# Host: widget_co_infrastructure
```

#### Step 3: Field Extraction
```xml
<!-- props.conf configuration -->
[csv]
INDEXED_EXTRACTIONS = csv
TIME_PREFIX = ^
TIME_FORMAT = %Y-%m-%d %H:%M:%S
SHOULD_LINEMERGE = false
```

---

## Splunk Configuration

### Index Configuration

```conf
# indexes.conf

[widget_co]
homePath = $SPLUNK_DB/widget_co/db
coldPath = $SPLUNK_DB/widget_co/colddb
thawedPath = $SPLUNK_DB/widget_co/thaweddb
maxTotalDataSizeMB = 512000
```

### Source Type Definitions

```conf
# props.conf

[dns_logs]
INDEXED_EXTRACTIONS = csv
TIMESTAMP_FIELDS = timestamp
TIME_FORMAT = %Y-%m-%d %H:%M:%S

[mfa_logs]
INDEXED_EXTRACTIONS = csv
TIMESTAMP_FIELDS = timestamp
TIME_FORMAT = %Y-%m-%d %H:%M:%S

[vpn_logs]
INDEXED_EXTRACTIONS = csv
TIMESTAMP_FIELDS = timestamp
TIME_FORMAT = %Y-%m-%d %H:%M:%S
```

### Field Aliases

```conf
# Create consistent field naming across sources

[mfa_logs]
FIELDALIAS-user = username AS user
FIELDALIAS-ip = source_ip AS src_ip

[vpn_logs]
FIELDALIAS-user = login_name AS user
```

---

## Analysis Techniques

### 1. Baseline Establishment

**Objective**: Understand normal user behavior patterns

```spl
# Establish normal login hours
index=widget_co sourcetype=vpn action="login"
| eval hour=strftime(_time, "%H")
| stats count by hour, user
| where count > 10

# Identify typical source IPs per user
index=widget_co
| stats dc(src_ip) as unique_ips by user
| where unique_ips < 5
```

### 2. Anomaly Detection Methods

#### Temporal Anomalies
```spl
# Detect after-hours activity (outside 8 AM - 6 PM)
index=widget_co
| eval hour=tonumber(strftime(_time, "%H"))
| where hour < 8 OR hour > 18
| stats count by user, hour, src_ip
| sort -count
```

#### Geolocation Anomalies
```spl
# Identify logins from unusual countries
index=widget_co sourcetype=vpn
| iplocation src_ip
| stats values(Country) as countries by user
| where mvcount(countries) > 2
```

#### Frequency Anomalies
```spl
# Detect unusual spike in failed logins
index=widget_co action="failed_login"
| timechart span=1h count by user
| where count > 10
```

### 3. IOC Correlation

```spl
# Create IOC lookup table
| inputlookup ioc_list.csv
| fields malicious_ip, malicious_domain, severity

# Correlate with DNS logs
index=widget_co sourcetype=dns
| lookup ioc_list.csv malicious_domain as query OUTPUT severity
| where isnotnull(severity)
| table _time, user, query, src_ip, severity
```

### 4. User Behavior Analytics (UBA)

```spl
# Build user profile
index=widget_co
| stats 
    count as total_events,
    dc(src_ip) as unique_ips,
    dc(action) as unique_actions,
    values(sourcetype) as systems_accessed
    by user
| eval risk_score = (unique_ips * 2) + (unique_actions * 1)
| where risk_score > 15
```

---

## Query Development

### Phase 1: Initial Discovery Queries

#### Query 1: Phishing Link Identification
```spl
index=widget_co sourcetype=dns
| rex field=query "(?<domain>[^.]+\.[^.]+)$"
| stats count by domain, user
| where domain="glasslu.com"
| table _time, user, query, src_ip
| sort _time
```

**Purpose**: Identify users who accessed the phishing domain  
**Evidence Found**: BDRVLS accessed glasslu.com on Oct 12, 2022

#### Query 2: MFA Bypass Detection
```spl
index=widget_co sourcetype=mfa action="bypass"
| stats count by user, src_ip, app
| where count > 1
| eval suspicious = if(count > 3, "HIGH", "MEDIUM")
| table _time, user, src_ip, app, count, suspicious
```

**Purpose**: Find repeated MFA bypass attempts  
**Evidence Found**: IP 180.76.54.93 bypassed MFA 5+ times for BDRVLS

#### Query 3: Brute Force Attack Detection
```spl
index=widget_co sourcetype=widgetapp action="failed_login"
| bucket _time span=5m
| stats count by _time, user, src_ip
| where count > 5
| table _time, user, src_ip, count
```

**Purpose**: Identify rapid failed login attempts  
**Evidence Found**: Multiple brute force attempts from 180.76.54.93

### Phase 2: Correlation Queries

#### Query 4: Multi-Source User Activity
```spl
index=widget_co user IN ("BDRVLS", "DDDXUB", "TIIYAW")
| eval source_category = case(
    sourcetype="dns", "Network",
    sourcetype="mfa", "Authentication",
    sourcetype="vpn", "Access",
    sourcetype IN ("cloud", "it_admin"), "Privileged Systems",
    1=1, "Other"
  )
| table _time, user, sourcetype, source_category, action, src_ip
| sort _time
```

#### Query 5: Lateral Movement Detection
```spl
# Track progression through systems
index=widget_co user="DDDXUB"
| eval system_tier = case(
    sourcetype="password_vault", "Tier 3 - Secrets",
    sourcetype="cloud", "Tier 2 - Infrastructure",
    sourcetype="it_admin", "Tier 1 - Admin",
    1=1, "Tier 4 - General"
  )
| stats earliest(_time) as first_access, latest(_time) as last_access by system_tier, user
| eval access_window = last_access - first_access
| table system_tier, first_access, last_access, access_window
```

### Phase 3: Evidence Collection Queries

#### Query 6: Timeline Reconstruction
```spl
index=widget_co (user="BDRVLS" OR user="DDDXUB" OR src_ip="180.76.54.93")
| eval event_description = case(
    sourcetype="dns" AND query="glasslu.com", "PHISHING: Malicious domain access",
    sourcetype="mfa" AND action="bypass", "MFA BYPASS: Authentication control evasion",
    action="failed_login", "BRUTE FORCE: Multiple failed attempts",
    sourcetype="password_vault" AND action="login", "VAULT ACCESS: Credential theft",
    sourcetype="cloud" OR sourcetype="it_admin", "PRIVILEGE ESCALATION: Admin access",
    1=1, "Other Activity"
  )
| table _time, user, src_ip, sourcetype, action, event_description
| sort _time
```

#### Query 7: Complete IOC Export
```spl
index=widget_co
| search (query="*.glasslu.com" OR src_ip="180.76.54.93" OR user IN ("BDRVLS", "DDDXUB"))
| stats 
    values(src_ip) as observed_ips,
    values(query) as dns_queries,
    values(action) as actions_taken,
    dc(sourcetype) as systems_accessed,
    earliest(_time) as first_seen,
    latest(_time) as last_seen
    by user
| convert ctime(first_seen) ctime(last_seen)
```

---

## Dashboard Creation

### Dashboard 1: Breach Correlation Dashboard

**Purpose**: Centralized view of all breach-related events

```xml
<dashboard>
  <label>Breach Correlation Dashboard</label>
  <row>
    <panel>
      <title>Attack Timeline</title>
      <chart>
        <search>
          <query>
            index=widget_co (user="BDRVLS" OR user="DDDXUB" OR src_ip="180.76.54.93")
            | timechart count by sourcetype
          </query>
        </search>
        <option name="charting.chart">column</option>
      </chart>
    </panel>
  </row>
  <row>
    <panel>
      <title>Affected User Activity</title>
      <table>
        <search>
          <query>
            index=widget_co user IN ("BDRVLS", "DDDXUB")
            | stats count by user, action, sourcetype, src_ip
          </query>
        </search>
      </table>
    </panel>
  </row>
</dashboard>
```

### Dashboard 2: Malicious Activity Detection

**Purpose**: Real-time threat monitoring

**Key Panels**:
- DNS Queries to Malicious Domains
- MFA Bypass Attempts by IP
- Geographic Login Distribution
- Failed Authentication Heatmap

### Dashboard 3: Executive Summary

**Purpose**: High-level metrics for leadership

**Key Metrics**:
- Total Events Analyzed: 92,700+
- Confirmed IOCs: 3 (domains/IPs)
- Affected Users: 3
- Attack Duration: 12 days
- Systems Compromised: 6

---

## Evidence Preservation

### Export Formats

#### CSV Export for Analysis
```spl
index=widget_co user="BDRVLS"
| table _time, user, src_ip, action, sourcetype
| outputcsv bdrvls_activity.csv
```

#### JSON Export for Integration
```spl
index=widget_co src_ip="180.76.54.93"
| table _time, user, src_ip, action, sourcetype
| outputlookup attacker_ip_activity.json
```

### Chain of Custody

1. **Raw Log Preservation**: Original CSV files stored with SHA256 hashes
2. **Splunk Exports**: All queries saved with timestamps
3. **Screenshots**: Dashboard views captured with metadata
4. **Report Generation**: PDF exports with digital signatures

### Forensic Best Practices

✅ Maintain unmodified original data  
✅ Document all queries and transformations  
✅ Timestamp all exports and screenshots  
✅ Create reproducible analysis workflows  
✅ Store evidence in write-once, read-many (WORM) storage  

---

## Appendix

### Useful Splunk Commands Reference

| Command | Purpose | Example |
|---------|---------|---------|
| `stats` | Aggregate data | `stats count by user` |
| `eval` | Create calculated fields | `eval hour=strftime(_time, "%H")` |
| `where` | Filter results | `where count > 10` |
| `timechart` | Time-based visualization | `timechart count by action` |
| `iplocation` | Geolocation lookup | `iplocation src_ip` |
| `rex` | Regular expression extraction | `rex field=query "(?<domain>.*)$"` |
| `lookup` | Enrich with external data | `lookup ioc_list.csv` |
| `transaction` | Group related events | `transaction user maxspan=10m` |

### Investigation Checklist

- [ ] All log sources ingested
- [ ] Field extractions configured
- [ ] Baseline behavior established
- [ ] IOC correlation completed
- [ ] Timeline documented
- [ ] Evidence exported
- [ ] Dashboards created
- [ ] Report generated
- [ ] Recommendations provided
- [ ] Artifacts preserved

---

**Document Version**: 1.0  
**Last Updated**: April 23, 2025  
**Maintained By**: Team 09
