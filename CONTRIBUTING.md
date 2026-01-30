# Contributing to Widget Co. Breach Investigation

Thank you for your interest in this cybersecurity investigation project! While this is a completed academic project, we welcome feedback, suggestions, and improvements.

---

## How to Contribute

### 🐛 Reporting Issues

If you find any issues with the documentation, queries, or analysis:

1. Check if the issue already exists in the [Issues](../../issues) section
2. If not, create a new issue with:
   - Clear title describing the problem
   - Detailed description of what's wrong
   - Steps to reproduce (if applicable)
   - Expected vs actual behavior
   - Any relevant screenshots or logs

### 💡 Suggesting Enhancements

We welcome suggestions for:
- Additional SPL queries
- Improved detection logic
- Better visualization ideas
- Documentation improvements
- Security analysis enhancements

To suggest an enhancement:
1. Open an issue with the `enhancement` label
2. Describe your idea clearly
3. Explain why it would be beneficial
4. Provide examples if possible

### 📝 Submitting Changes

If you'd like to contribute code or documentation:

1. **Fork the repository**
   ```bash
   git clone https://github.com/yourusername/widget-co-breach-investigation.git
   cd widget-co-breach-investigation
   ```

2. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```

3. **Make your changes**
   - Follow the existing code/documentation style
   - Add comments where necessary
   - Test your SPL queries in Splunk (if applicable)

4. **Commit your changes**
   ```bash
   git add .
   git commit -m "Brief description of changes"
   ```
   
   **Commit Message Guidelines**:
   - Use present tense ("Add feature" not "Added feature")
   - Be descriptive but concise
   - Reference issue numbers if applicable

5. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request**
   - Go to the original repository
   - Click "New Pull Request"
   - Select your branch
   - Fill out the PR template (see below)

---

## Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Query improvement
- [ ] Dashboard enhancement

## Testing
Describe how you tested your changes

## Checklist
- [ ] Code follows project style guidelines
- [ ] Documentation updated (if applicable)
- [ ] Queries tested in Splunk (if applicable)
- [ ] No sensitive data included
- [ ] All tests pass
```

---

## Code Style Guidelines

### SPL Queries
```spl
# Good: Clear, commented, well-formatted
# Purpose: Detect brute force attacks
index=widget_co sourcetype=auth action="failed_login"
| bucket _time span=5m
| stats count by _time, user, src_ip
| where count > 5
| sort -count

# Bad: No context, unclear
index=* | stats count by user | where count>5
```

### Documentation
- Use Markdown for all documentation
- Include code examples where relevant
- Add screenshots for visual elements
- Keep language clear and professional
- Use headers to organize content

### File Naming
- Use lowercase with hyphens: `my-new-query.spl`
- Be descriptive: `mfa-bypass-detection.spl` not `query1.spl`
- Use appropriate extensions: `.md`, `.spl`, `.xml`, `.csv`

---

## Project Structure

Please maintain the existing structure:

```
widget-co-breach-investigation/
├── README.md
├── docs/
│   └── Technical_Documentation.md
├── queries/
│   └── *.spl files
├── dashboards/
│   └── *.xml files
├── evidence/
│   └── *.md files
└── images/
    └── *.png files
```

---

## What We're Looking For

### High Priority
- ✅ Improved detection queries
- ✅ Additional MITRE ATT&CK mappings
- ✅ Better documentation clarity
- ✅ Dashboard enhancements
- ✅ Typo fixes and corrections

### Welcome Contributions
- Sample data generators (anonymized)
- Additional analysis techniques
- Automation scripts
- Jupyter notebooks for analysis
- Video tutorials or walkthroughs

### Not Accepting
- ❌ Actual sensitive data or logs
- ❌ Unrelated security projects
- ❌ Commercial tools or paid products
- ❌ Major restructuring (without discussion first)

---

## Code of Conduct

### Our Standards

**Positive Behaviors**:
- Using welcoming and inclusive language
- Being respectful of differing viewpoints
- Gracefully accepting constructive criticism
- Focusing on what's best for the community
- Showing empathy towards others

**Unacceptable Behaviors**:
- Harassment or discriminatory language
- Trolling or insulting comments
- Personal or political attacks
- Publishing others' private information
- Unprofessional conduct

### Enforcement

Instances of unacceptable behavior may be reported by contacting the project team. All complaints will be reviewed and investigated promptly and fairly.

---

## Getting Help

### Questions?
- Check the [README](README.md) first
- Review existing [Issues](../../issues)
- Look at [Discussions](../../discussions) (if enabled)
- Email: [your.email@example.com]

### Resources
- [Splunk Documentation](https://docs.splunk.com/)
- [MITRE ATT&CK](https://attack.mitre.org/)
- [Markdown Guide](https://www.markdownguide.org/)

---

## Recognition

Contributors will be acknowledged in:
- README.md (Contributors section)
- CHANGELOG.md (for significant contributions)
- Release notes (if applicable)

---

## License

By contributing, you agree that your contributions will be licensed under the same license as this project (see LICENSE file).

---

## Thank You! 🙏

Your contributions help make this project better for everyone learning cybersecurity and SIEM analysis.

**Happy Contributing!**

---

**Last Updated**: 2025-04-23  
**Maintained by**: Team 09
