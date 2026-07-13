# Remote Access Tool Detection - TeamViewer

**Severity:** Medium\
**MITRE ATT&CK:** T1219 (Remote Access Software)\
**Owner:** Jino

## Description

Detects execution of TeamViewer (application and background service),
a legitimate remote access tool also frequently abused in tech-support
scams and by threat actors for unauthorized remote control. Matches on
process name, display name, and publisher (TeamViewer GmbH / TeamViewer
Germany GmbH — publisher name varies by version) to catch renamed binaries.