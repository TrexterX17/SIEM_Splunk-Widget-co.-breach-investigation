# Images Directory

This directory contains screenshots, diagrams, and visual assets for the Widget Co. breach investigation.

## Contents

### Dashboard Screenshots
- `dashboard_1_overview.png` - Breach Correlation Dashboard
- `dashboard_2_detection.png` - Malicious Activity Detection
- `dashboard_3_executive.png` - Executive Summary

### Evidence Screenshots
- `dns_phishing.png` - DNS query to glasslu.com
- `mfa_bypass.png` - MFA bypass events
- `brute_force.png` - Failed login attempts
- `vault_access.png` - Password vault breach
- `privilege_escalation.png` - Admin portal access

### Diagrams
- `attack_timeline.png` - Visual attack progression
- `architecture_diagram.png` - Investigation architecture
- `kill_chain.png` - Cyber kill chain visualization

## How to Add Images

1. Take screenshots from Splunk dashboards
2. Name files descriptively (lowercase, hyphens)
3. Save as PNG format (preferred) or JPG
4. Add to appropriate subdirectory
5. Reference in documentation using:

```markdown
![Description](../images/filename.png)
```

## Guidelines

- **Resolution**: Minimum 1920x1080 for screenshots
- **Format**: PNG for diagrams/UI, JPG for photos
- **Size**: Optimize images to keep under 2MB each
- **Naming**: Use descriptive, lowercase names with hyphens
- **Privacy**: Redact any sensitive information (PII, real IPs, etc.)

## Tools for Creating Diagrams

- [Draw.io](https://app.diagrams.net/) - Free diagramming tool
- [Lucidchart](https://www.lucidchart.com/) - Professional diagrams
- [Mermaid](https://mermaid-js.github.io/) - Markdown-based diagrams
- [Excalidraw](https://excalidraw.com/) - Hand-drawn style diagrams

---

**Note**: Screenshots from the original investigation are referenced in the report PDFs. Add your own screenshots when recreating this investigation in Splunk.
