# Setup Guide - Widget Co. Breach Investigation

This guide will help you set up and use this repository for learning, demonstration, or further analysis.

---

## Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/widget-co-breach-investigation.git
cd widget-co-breach-investigation
```

### 2. Repository Structure

```
widget-co-breach-investigation/
├── README.md                          # Project overview
├── CONTRIBUTING.md                    # Contribution guidelines
├── CHANGELOG.md                       # Version history
├── docs/
│   ├── Full_Investigation_Report.pdf  # Complete findings report
│   ├── Executive_Presentation.pdf     # Leadership presentation  
│   └── Technical_Documentation.md     # Detailed methodology
├── queries/
│   ├── phishing_detection.spl
│   ├── mfa_bypass_analysis.spl
│   ├── brute_force_detection.spl
│   ├── vault_access_audit.spl
│   └── privilege_escalation.spl
├── evidence/
│   ├── timeline.md                    # Attack chronology
│   ├── iocs.md                        # Indicators of Compromise
│   └── affected_accounts.md           # Account analysis
└── images/                            # Screenshots and diagrams
```

---

## Prerequisites

### Required Tools

1. **Splunk** (for running queries)
   - Splunk Enterprise 9.0+ OR
   - Splunk Cloud OR
   - Splunk Free (limited features)

2. **Git** (for version control)
   ```bash
   # Install on Ubuntu/Debian
   sudo apt-get install git
   
   # Install on macOS
   brew install git
   ```

3. **Text Editor** (for viewing/editing)
   - VS Code (recommended)
   - Sublime Text
   - Atom
   - Or any IDE

### Recommended Knowledge

- Basic understanding of SIEM concepts
- Familiarity with Splunk Search Processing Language (SPL)
- Cybersecurity fundamentals
- Log analysis experience (helpful)

---

## Installation & Setup

### Option 1: Splunk Enterprise (Recommended for Full Experience)

#### Step 1: Install Splunk Enterprise

**Download Splunk**:
```bash
# Visit: https://www.splunk.com/en_us/download/splunk-enterprise.html
# Download the appropriate installer for your OS
```

**Install on Linux**:
```bash
wget -O splunk.tgz "https://download.splunk.com/products/splunk/releases/[version]/linux/splunk-[version]-Linux-x86_64.tgz"
tar xvzf splunk.tgz -C /opt
/opt/splunk/bin/splunk start --accept-license
```

**Install on macOS/Windows**:
- Run the downloaded installer
- Follow the installation wizard
- Start Splunk and access via http://localhost:8000

#### Step 2: Configure Splunk

```bash
# Create index for Widget Co. data
# In Splunk Web: Settings → Indexes → New Index
# Index Name: widget_co

# Or via CLI:
/opt/splunk/bin/splunk add index widget_co
```

#### Step 3: Import Sample Data (If Available)

```bash
# If you have sample CSV files:
# Settings → Add Data → Upload
# Select your CSV files
# Set Source Type: csv
# Set Index: widget_co
```

#### Step 4: Install Dashboards

```bash
# Copy dashboard XML files to Splunk
cp dashboards/*.xml /opt/splunk/etc/apps/search/local/data/ui/views/

# Restart Splunk
/opt/splunk/bin/splunk restart
```

---

### Option 2: Splunk Cloud (Alternative)

1. Sign up for Splunk Cloud trial: https://www.splunk.com/en_us/download/splunk-cloud.html
2. Follow cloud-specific data upload instructions
3. Import queries and dashboards via web interface

---

### Option 3: Read-Only Mode (No Splunk Required)

If you just want to learn from the documentation:

```bash
# Clone the repo
git clone https://github.com/yourusername/widget-co-breach-investigation.git
cd widget-co-breach-investigation

# Read documentation
cat README.md
cat docs/Technical_Documentation.md
cat evidence/timeline.md
cat evidence/iocs.md

# View queries
ls -la queries/
cat queries/phishing_detection.spl
```

---

## Using the Repository

### Running Splunk Queries

#### Method 1: Splunk Web Interface

1. Open Splunk Web (http://localhost:8000)
2. Navigate to Search & Reporting
3. Copy a query from `/queries` directory
4. Paste into search bar
5. Adjust time range (October 2022)
6. Click Search

**Example**:
```spl
# Copy from queries/phishing_detection.spl
index=widget_co sourcetype=dns
| search query IN ("glasslu.com", "*.glasslu.com")
| stats count by user, query, src_ip
```

#### Method 2: Splunk CLI

```bash
/opt/splunk/bin/splunk search "index=widget_co sourcetype=dns | stats count by user"
```

---

### Viewing Dashboards

1. Navigate to Dashboards in Splunk Web
2. Find installed Widget Co. dashboards:
   - Breach Correlation Dashboard
   - Malicious Activity Detection
   - Executive Summary
3. Click to open and interact

---

### Analyzing Evidence

```bash
# Read the attack timeline
cat evidence/timeline.md

# Review IOCs
cat evidence/iocs.md

# Check affected accounts
cat evidence/affected_accounts.md
```

---

## Learning Paths

### Path 1: Security Analyst

**Focus**: Understanding the investigation process

1. Read `README.md` for overview
2. Study `docs/Technical_Documentation.md`
3. Review `evidence/timeline.md` to understand attack progression
4. Examine queries in `/queries` directory
5. Try to recreate the analysis in Splunk

**Skills Gained**:
- Forensic investigation methodology
- Log correlation techniques
- IOC identification
- Timeline reconstruction

---

### Path 2: SOC Analyst

**Focus**: Detection and monitoring

1. Study IOCs in `evidence/iocs.md`
2. Learn detection queries in `/queries`
3. Understand alert logic
4. Practice creating custom alerts
5. Build your own dashboards

**Skills Gained**:
- SIEM query writing
- Alert configuration
- Dashboard creation
- Threat hunting

---

### Path 3: Incident Responder

**Focus**: Response and remediation

1. Read full report in `docs/Full_Investigation_Report.pdf`
2. Study remediation actions
3. Review recommendations
4. Practice writing incident reports
5. Learn communication to technical/non-technical audiences

**Skills Gained**:
- Incident response procedures
- Remediation planning
- Report writing
- Stakeholder communication

---

## Customization

### Adapting Queries for Your Environment

```spl
# Original query
index=widget_co sourcetype=dns
| search query="glasslu.com"

# Adapt for your environment
index=YOUR_INDEX sourcetype=YOUR_DNS_SOURCETYPE
| search query="YOUR_MALICIOUS_DOMAIN"
```

### Creating Your Own Dashboards

1. Start with our dashboard XML templates
2. Modify panels to fit your data
3. Add your own visualizations
4. Save as new dashboard

---

## Troubleshooting

### Common Issues

#### Issue 1: "No results found"
**Cause**: Index or source type mismatch  
**Solution**: Update query to match your Splunk configuration
```spl
# Check available indexes
| eventcount summarize=false index=* | dedup index | fields index

# Check available sourcetypes
| metadata type=sourcetypes index=widget_co
```

#### Issue 2: Dashboard not loading
**Cause**: XML file not in correct location  
**Solution**: Verify dashboard XML location
```bash
ls -la /opt/splunk/etc/apps/search/local/data/ui/views/
```

#### Issue 3: Permission denied
**Cause**: Insufficient user permissions  
**Solution**: Grant appropriate roles in Splunk
```bash
# Run as Splunk admin
Settings → Access Controls → Roles
```

---

## Best Practices

### Security
- ✅ Never commit sensitive data to Git
- ✅ Use `.gitignore` for logs and credentials
- ✅ Anonymize any real data before sharing
- ✅ Review code before committing

### Documentation
- ✅ Comment complex queries
- ✅ Keep README updated
- ✅ Document any changes in CHANGELOG
- ✅ Add examples for new features

### Version Control
- ✅ Use meaningful commit messages
- ✅ Create branches for new features
- ✅ Test before merging to main
- ✅ Keep commits atomic and focused

---

## Additional Resources

### Official Documentation
- [Splunk Docs](https://docs.splunk.com/)
- [SPL Reference](https://docs.splunk.com/Documentation/Splunk/latest/SearchReference)
- [Dashboard Examples](https://docs.splunk.com/Documentation/Splunk/latest/Viz/Dashboards)

### Learning Resources
- [Splunk Fundamentals](https://www.splunk.com/en_us/training.html)
- [MITRE ATT&CK](https://attack.mitre.org/)
- [SANS Reading Room](https://www.sans.org/reading-room/)

### Community
- [Splunk Answers](https://community.splunk.com/)
- [r/Splunk](https://www.reddit.com/r/Splunk/)
- [Splunk Slack](https://splunk-usergroups.slack.com/)

---

## FAQ

**Q: Do I need a Splunk license?**  
A: You can use Splunk Free (500MB/day limit) or a 60-day Enterprise trial.

**Q: Can I use this for my own projects?**  
A: Yes! This is educational/open-source. Just give credit.

**Q: The data doesn't match my environment**  
A: That's expected. Adapt queries to your specific logs and IOCs.

**Q: How do I contribute improvements?**  
A: See CONTRIBUTING.md for guidelines.

**Q: Can I share this repository?**  
A: Yes! Share freely for educational purposes.

---

## Support

### Getting Help
1. Check documentation first
2. Search existing GitHub Issues
3. Create new issue if needed
4. Join community discussions

### Reporting Bugs
- Use GitHub Issues
- Provide detailed description
- Include error messages
- Share relevant configuration

---

## Next Steps

Ready to start? Here's what to do:

1. ✅ Clone the repository
2. ✅ Set up Splunk (if using)
3. ✅ Read the main README
4. ✅ Review technical documentation
5. ✅ Try running some queries
6. ✅ Build your own dashboards
7. ✅ Share your learnings!

---

**Good luck with your cybersecurity journey!** 🔐

---

**Maintained by**: Team 09  
**Last Updated**: 2025-04-23  
**Version**: 1.0
