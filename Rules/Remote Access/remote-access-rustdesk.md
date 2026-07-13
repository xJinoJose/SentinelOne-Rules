# Remote Access Tool Detection - RustDesk

**Severity:** High\
**MITRE ATT&CK:** T1219 (Remote Access Software)\
**Owner:** Jino

## Description

Detects execution of RustDesk, an open-source remote access tool
(by Purslane Ltd / Purslane Tech Pte. Ltd.) disproportionately observed in
tech-support scam and social-engineering campaigns due to its low barrier
to entry and portable, no-install execution mode. Matches on process name,
display name, and publisher where present.

## Caveat: publisher signature is unreliable for this tool

RustDesk's code-signing certificate was revoked by Sectigo (Dec 2025).
Some current legitimate RustDesk builds are unsigned, or signed under an
individual developer's name rather than the Purslane company name. Do not
rely on the publisher clause alone to decide legitimacy — an unsigned or
oddly-signed RustDesk binary is not automatically malicious, and a properly
"Purslane"-signed one is not automatically authorized. Process name/path
and context (was it pushed by RMM, or does it appear via a browser download
followed immediately by an unattended-access configuration?) matter more
here than for the other tools in this folder.

## Tuning note

RustDesk commonly runs portably from `%LOCALAPPDATA%\rustdesk\` without a
formal install or registered service — unlike TeamViewer/Splashtop, absence
from Programs and Features doesn't mean absence from the endpoint. Consider
a companion rule on command-line arguments (`--server`, `--key`, `--password`)
if you want to specifically catch pre-configured "custom client" builds used
for silent unattended access, which is the more concerning abuse pattern
versus a technician using the vanilla client interactively.