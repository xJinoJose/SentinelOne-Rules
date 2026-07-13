# Remote Access Tool Detection - AnyDesk

**Severity:** Medium\
**MITRE ATT&CK:** T1219 (Remote Access Software)\
**Owner:** Jino

## Description

Detects execution of AnyDesk, a legitimate remote access tool frequently
abused by threat actors and social-engineering/tech-support scam campaigns
for unauthorized remote control. Matches on process name, executable display
name, and publisher to catch renamed binaries that keep AnyDesk's signing
metadata.