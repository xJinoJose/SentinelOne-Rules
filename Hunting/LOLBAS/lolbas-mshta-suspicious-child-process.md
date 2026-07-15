# Hunt - Mshta Spawning Shell or Scripting Engine

**MITRE ATT&CK:** T1218.005, T1059 (Command and Scripting Interpreter)\
**Owner:** Jino

## Purpose

Mshta.exe normally runs and exits without spawning a child process. A
child process of cmd, PowerShell, wscript/cscript, or another LOLBAS
binary means the HTA's embedded script is proxying execution further —
the expected next step in most mshta-based malware delivery chains.

## Known evasion to watch for

Some samples use WMI from within the HTA to spawn PowerShell instead of a
direct parent/child relationship, specifically to break the "expected"
mshta > PowerShell process chain and evade detections (and sandboxes) that
only look for a direct relationship. If this hunt comes back clean but you
have other reasons to suspect mshta abuse, also check for WMI process
creation (Win32_Process Create) occurring in the same timeframe as any
mshta execution, since that's the way this specific evasion shows up in
telemetry.

## Why this is a hunt, not a rule

A handful of legitimate admin scripts do chain mshta into a follow-up
command. Aggregate and review for unfamiliar combinations rather than
alerting on every instance.