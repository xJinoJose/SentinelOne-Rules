# LOLBAS Abuse - Regsvr32 Spawning Suspicious Child Process

**Severity:** Critical\
**MITRE ATT&CK:** T1218.010 (System Binary Proxy Execution: Regsvr32)\
**Owner:** Jino

## Description

Detects regsvr32.exe (as parent/src process) spawning a shell, scripting
engine, or another LOLBAS binary as a child process. Legitimate DLL
registration via DllRegisterServer/DllUnRegisterServer does not launch
child processes — regsvr32 registers the component and exits. A child
process of this shape means the "DLL" being registered contains arbitrary
malicious code that is using the registration entry point as its execution
vector, which is the whole point of the Squiblydoo-family techniques.

## Why this is Critical, not just High

Unlike the command-line pattern or path-based rules, this one observes an
actual downstream consequence (code execution via a child process) rather
than an indicator that something *might* happen. Confidence here is very
high — near-zero legitimate reason for this parent/child relationship to
exist.

## Response action

Treat as likely active compromise. Isolate endpoint, capture the child
process's full command line and any further descendants for the incident
timeline.