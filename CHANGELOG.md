# Changelog

All notable changes to this investigation and repository will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [1.0.0] - 2025-04-23

### Added
- Initial repository setup and structure
- Comprehensive README with project overview and IOCs
- Complete forensic investigation report (PDF)
- Executive presentation slides (PDF)
- Technical documentation covering:
  - Investigation architecture
  - Data sources and ingestion process
  - Splunk configuration details
  - Analysis techniques and methodology
  - Dashboard creation guidelines
- SPL query library:
  - Phishing detection queries
  - MFA bypass analysis queries
  - Brute force detection queries
  - Password vault access audit queries
  - Privilege escalation tracking queries
- Evidence documentation:
  - Detailed attack timeline
  - Complete IOC list with detection rules
  - Affected accounts analysis
- Project documentation:
  - .gitignore for sensitive data protection
  - LICENSE file
  - Contributing guidelines

### Investigation Findings
- Confirmed multi-stage breach spanning 12 days (Oct 12-24, 2022)
- Identified 3 IOCs (2 malicious domains, 1 attacker IP)
- Documented 9 affected accounts (2 compromised, 7 exposed)
- Mapped attack to MITRE ATT&CK framework (5 techniques)
- Created 3 Splunk dashboards for monitoring and visualization

### Security Recommendations
- Technical recommendations for IT/Security teams (5 immediate actions)
- Procedural recommendations for leadership (4 strategic initiatives)
- Long-term security posture improvements

---

## [Unreleased]

### Planned Additions
- Sample dashboard XML files
- Mock CSV data for testing (sanitized/anonymized)
- Jupyter notebook for data analysis
- Additional visualization diagrams
- Video walkthrough of investigation (planned)

### To Do
- [ ] Add dashboard screenshots to images directory
- [ ] Create attack flow diagram
- [ ] Add MITRE Navigator layer file
- [ ] Include sample SIEM alert configurations
- [ ] Create Docker environment for Splunk testing

---

## Repository Milestones

### Milestone 1: Initial Investigation (Oct 25 - Nov 15, 2022)
- Log data collection and ingestion
- Initial forensic analysis
- IOC identification
- Timeline construction

### Milestone 2: Detailed Analysis (Nov 16 - Dec 10, 2022)
- Advanced correlation analysis
- Dashboard development
- Query optimization
- Evidence preservation

### Milestone 3: Reporting & Remediation (Dec 11, 2022 - Jan 15, 2023)
- Comprehensive report generation
- Executive presentation development
- Remediation action planning
- Post-incident monitoring setup

### Milestone 4: Documentation & Publication (Apr 1 - Apr 23, 2025)
- GitHub repository creation
- Technical documentation writing
- Code and query organization
- Public release preparation

---

## Version History

| Version | Date | Description |
|---------|------|-------------|
| 1.0.0 | 2025-04-23 | Initial public release |
| 0.9.0 | 2025-04-15 | Internal review version |
| 0.5.0 | 2023-01-15 | Investigation completion |
| 0.1.0 | 2022-10-25 | Investigation kickoff |

---

## Contributors

- **Team 09**: Primary investigation team
  - Pramath Yaji
  - Faraz Ahmed
  - Phani Varun Munukuntla
  - Bhuvantej Ramachandra Reddy

---

## Notes

This is an academic/educational project based on a simulated cybersecurity incident. All company names, user accounts, and identifying information have been anonymized or fictionalized for privacy and security purposes.

---

**Maintained by**: Team 09  
**Last Updated**: 2025-04-23
