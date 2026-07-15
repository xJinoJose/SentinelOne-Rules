# Hunt - RunMRU Registry Entries Referencing LOLBins

**MITRE ATT&CK:** T1204.001, T1204.004, T1112 (Modify Registry)\
**Owner:** Jino

## Purpose

HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU records
recent Run-dialog entries per user, and is specifically called out by
Microsoft's own ClickFix research as one of the strongest forensic sources
once a ClickFix incident is suspected. Legitimate Run-dialog use is
extremely common (opening folders, launching known apps), so this needs
human review rather than direct alerting — hence a hunt, not a rule.

## How to use

Run reactively (after any ClickFix-adjacent alert, help-desk report of a
weird "verification" page, or user report of a suspicious pop-up) rather
than continuously — check the flagged user/endpoint's RunMRU history for
entries containing LOLBin names, especially ones with encoded/obfuscated-
looking trailing content or a suspicious top-level domain reference.

## Tuning note

RunMRU values are often truncated or formatted differently than the
original command (Microsoft notes attackers now pad commands with
whitespace or a fake ticket-ID comment specifically so the visible portion
looks harmless) — treat any match as a starting point for full timeline
review, not a conclusive verdict on its own.