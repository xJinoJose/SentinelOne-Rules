# Hunt - Mshta Spawned by Office Application or Scripting Engine

**MITRE ATT&CK:** T1218.005, T1566 (Phishing)\
**Owner:** Jino

## Purpose

Office applications (Word, Excel, PowerPoint, Outlook) do not legitimately
launch mshta.exe as part of normal document viewing. This is the classic
"malicious macro drops/launches an HTA" pattern used in phishing-driven
initial access. Aggregated by parent process and endpoint so you can scan
for outliers rather than reviewing every hit individually.

## How to use

Run periodically (or ad hoc after a phishing report). Focus review on:
- Any hit at all from winword.exe/excel.exe/powerpnt.exe/outlook.exe —
  these have the least legitimate reason to spawn mshta.
- Endpoints appearing here for the first time relative to your baseline.

## Why this is a hunt, not a rule

Some environments have legitimate scripted workflows (deployment tooling,
older internal utilities) that launch mshta from cmd.exe or explorer.exe.
Rather than trying to write a condition narrow enough to exclude every
legitimate case up front, review the aggregated output and use judgment —
promote a narrower pattern to a rule once you've confirmed what's normal
in a given client environment.