# Remote Access Tool Detection - Splashtop

Severity: Medium
MITRE ATT&CK: T1219 (Remote Access Software)
Owner: Jino

## Description

Detects execution of Splashtop Streamer components (SRServer.exe, the
SplashtopRemoteService, and related management processes), a legitimate
remote access tool also seen abused for unauthorized remote control.
Matches on known process names, display name, and publisher (Splashtop
Inc.) to catch variants across Splashtop Streamer, Splashtop Business, and
Splashtop Personal installs.