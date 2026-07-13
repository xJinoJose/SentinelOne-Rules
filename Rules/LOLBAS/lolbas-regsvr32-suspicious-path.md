# LOLBAS Abuse - Regsvr32 Executing DLL from Suspicious Path

**Severity:** High\
**MITRE ATT&CK:** T1218.010 (System Binary Proxy Execution: Regsvr32)\
**Owner:** Jino

## Description

Detects regsvr32.exe registering/executing a DLL located in a path
commonly used for staging malware (Temp, AppData, Downloads, Public,
ProgramData) rather than a proper installed-application directory.
Legitimate DLL registration (drivers, COM components, third-party
software install routines) typically occurs from Program Files or
System32-adjacent paths — a DLL loaded from a user-writable staging
location is a strong anomaly independent of any specific technique
(scrobj.dll or otherwise).

## Tuning note

Some legitimate installers do register DLLs from a temp extraction folder
mid-installation, so expect occasional false positives around software
install/update events. Cross-reference against known install activity
(e.g. recent MSI/EXE execution from the same parent process) before
escalating.

## Response action

Investigate — pull the full command line and the DLL's hash/signature.
Unsigned or unknown-publisher DLLs from these paths warrant isolation.