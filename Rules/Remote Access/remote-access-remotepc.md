# Remote Access Tool Detection - RemotePC

Severity: Medium
MITRE ATT&CK: T1219 (Remote Access Software)
Owner: Jino

## Description

Detects execution of RemotePC (application, background service RPCService,
and UI components), a legitimate remote access tool by IDrive Inc.
(formerly Pro Softnet Corporation) also observed used for unauthorized
remote access. Matches on known process names, display name, and publisher
to catch renamed binaries. Publisher may show as either "IDrive" or
"Pro Softnet" depending on binary version/vintage.