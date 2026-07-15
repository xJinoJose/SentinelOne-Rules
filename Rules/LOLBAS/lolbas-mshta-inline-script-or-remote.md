# LOLBAS Abuse - Mshta Inline Script or Remote HTA Execution

**Severity:** High\
**MITRE ATT&CK:** T1218.005 (System Binary Proxy Execution: Mshta),
T1105 (Ingress Tool Transfer)\
**Owner:** Jino

## Description

Detects mshta.exe invoked with an inline `javascript:`/`vbscript:` URI
(executing script directly from the command line, no file touches disk)
or with an `http://`/`https://` argument (executing a remote .hta file
downloaded on the fly). Mshta is a signed Microsoft binary that runs
outside Internet Explorer's security context and outside browser
sandboxing, so both patterns let an attacker execute arbitrary
JScript/VBScript — and from there, typically PowerShell — under a
trusted process. As of mid-2026, mshta remains one of the most common
LOLBins seen in commodity stealer/loader delivery chains (LummaStealer,
Amatera, CountLoader, Emmenhtal Loader) as well as more persistent malware
(ClipBanker, PurpleFox).

## Why this pattern, not "any execution"

Some legitimate internal tooling and older admin utilities still use local
.hta files (double-clicked or launched by a script), so a broad
"any mshta.exe execution" rule would carry more noise than the LOLBAS
binaries you've marked presence-only (like finger.exe). Inline script URIs
and remote HTTP(S) arguments are specifically the abused surface, not
normal usage.

## Source

- https://lolbas-project.github.io/lolbas/Binaries/Mshta/
- https://www.bitdefender.com/en-us/blog/labs/microsofts-mshta-legacy-malware-windows

## Response action

Alert and investigate promptly. Pull the full command line and check for
a spawned child process (commonly PowerShell) — see the companion hunting
queries below for the process-tree angle on this same binary.