# Hunt - Microsoft Edge Headless Mode Loading Local Extension

**MITRE ATT&CK:** T1176.001 (Browser Extensions: Malicious Extensions),
T1059.001 (PowerShell), T1059.003 (Windows Command Shell)\
**Owner:** Jino

## Purpose

Detects Microsoft Edge launched in headless mode (`headless=new`) with a
`--load-extension=` argument pointing to a local file path — the
mechanism behind the "Edgecution" C2 technique, where a malicious Edge
extension paired with a Python backdoor facilitates command-and-control
communication without a normal visible browser window. Aggregated by
endpoint and user since this pattern is noisy on its own.

## Why this is a hunt, not a rule

The source report is explicit that this was by far the noisiest of their
three approaches and "required significant filtering to triage
effectively" — but it's also the only one of the three that actually
surfaced confirmed malicious activity: two events where users were
socially engineered via Microsoft Teams messages into downloading a
payload, in one case a malicious AutoHotkey script that dropped a further
payload and established the scheduled-task persistence covered by the
companion rule above. The technique-only condition isn't precise enough
to alert on directly; it needs human review of what's actually loading
and why.

## Full attack chain context (for triage reference)

Per the source hunt: email bombing → Microsoft Teams phishing → download
of QuickAssist (RMM) → QuickAssist-based initial access → Havoc C2 via
archive smuggling + DLL sideloading, with a June 2026 shift toward
scripted (.bat/.ps1/AutoHotKey) payload automation and toward this
Edgecution-style browser-extension C2 instead of Havoc. When triaging a
hit, check for QuickAssist activity and Teams-delivered files in the same
timeframe on the same endpoint — that combination is the strongest
context clue this source report identified.

## How to use

Run periodically or after any Teams-based phishing report. Review the
aggregated list for unfamiliar user/endpoint pairs; cross-reference
against the archive-smuggling and scheduled-task rules above for the same
host, since a hit across multiple of these three signals is much stronger
than any one alone — exactly the correlation the source hunt team used to
confirm their two real findings.

## Recommended companion control

The source report recommends restricting unpacked/non-standard-path
extension loading via policy, and auditing NativeMessagingHosts registry
changes — the latter overlaps directly with the Browser Syncjacking rules
already in this repo (Threat Intel\Browser Syncjacking\), worth reviewing
together.