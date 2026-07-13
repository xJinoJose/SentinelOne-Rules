# Remote Access Tool Detection - Supremo

**Severity:** Medium\
**MITRE ATT&CK:** T1219 (Remote Access Software)\
**Owner:** Jino

## Description

Detects execution of Supremo Remote Desktop (main application, background
service, and helper component), a legitimate remote access tool by
Nanosystems S.r.l. also frequently observed in tech-support scam activity
due to its portable, no-install execution mode and low barrier to entry.
Matches on known process names, display name, and publisher.

## Tuning note

Supremo runs portably without a formal install in many cases (usable
directly from a downloaded exe or USB drive) — similar to RustDesk, its
absence from Programs and Features does not mean it isn't present or
running. If any BBB client uses Supremo as their sanctioned support tool,
scope this rule to exclude that client or add a path/context exclusion
rather than relying on process presence alone.