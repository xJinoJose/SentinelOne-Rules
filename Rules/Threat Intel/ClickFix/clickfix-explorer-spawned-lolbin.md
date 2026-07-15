# ClickFix - Explorer-Spawned LOLBin with Obfuscation Flags

**Severity:** Critical\
**MITRE ATT&CK:** T1204.001 (User Execution: Malicious Link),
T1204.004 (User Execution: Malicious Copy and Paste), T1027 (Obfuscated
Files or Information), T1105 (Ingress Tool Transfer)\
**Owner:** Jino

## Description

Detects PowerShell, mshta, wscript, cscript, cmd, curl, or bitsadmin
spawned directly by explorer.exe (parent process), combined with common
obfuscation/download flags (-EncodedCommand, hidden window style, iex/
Invoke-Expression, IWR/Invoke-WebRequest). This is the signature process
lineage of ClickFix: a fake CAPTCHA/verification/meeting-join page injects
a malicious command into the clipboard via JavaScript, then instructs the
victim to press Win+R, Ctrl+V, Enter. Because the Run dialog is a direct
child of Explorer, the resulting process tree has explorer.exe as the
immediate parent — a pattern that essentially never occurs from normal
interactive shell use (which would show cmd.exe or powershell.exe as the
parent of further children, not explorer.exe directly launching an
obfuscated one-liner).

This is currently one of the dominant initial-access techniques in the
wild: ESET recorded a 517% increase in ClickFix/FakeCAPTCHA campaigns in
H1 2025, and Microsoft's August 2025 analysis confirmed it reaches
thousands of devices daily, delivering payloads including Lumma Stealer,
StealC, and various RATs.

## Connection to existing rules in this repo

FileFix (a ClickFix variant using the File Explorer address bar instead of
Win+R, specifically to route around Group-Policy blocks on the Run
dialog) has been documented using the finger protocol as its execution
vector in at least one campaign — meaning finger-command-abuse.pq in the
LOLBAS folder may already provide partial coverage against this technique
family. Worth treating these two rules as a pair when reviewing hits from
either.

## Tuning note

Legitimate help-desk-guided troubleshooting occasionally has a user paste
a command a technician provided into Run — if BBB or a client's IT team
does this as a supported workflow, expect occasional false positives and
consider an exclusion based on time-of-day/ticket correlation rather than
disabling the rule.

## Response action

Treat as likely active compromise. Pull the full command line immediately
(the visible portion in the Run dialog is often padded with whitespace or
a fake "ticket ID" comment to hide the real payload off-screen) and check
for a spawned network connection to a freshly registered domain or paste
service, which is the near-universal next step in this chain.