# Edgecution Cluster - Scheduled Task Persistence via Single-Letter XML

**Severity:** High\
**MITRE ATT&CK:** T1053.005 (Scheduled Task/Job: Scheduled Task)\
**Owner:** Jino

## Description

Detects schtasks.exe creating a scheduled task from an XML definition file
(`/create /tn ... /xml ...`). Sourced from an internal MDR hunt into a
resurfaced adversary cluster (first observed transitioning TTPs June 18,
2026), associated with the "Edgecution" technique (see Zscaler's public
research). The specific pattern this cluster used named the XML file with
a single lowercase letter (e.g. `a.xml`, `b.xml`) — this rule matches the
broader schtasks-from-XML shape since exact single-character filename
matching may need a regex/match function verified against your console's
PowerQuery capabilities (see tuning note).

## Source

Internal hunt report, "Emerging Threat Cluster - Newly Observed TTPs"
(June 2026); cross-referenced against Zscaler's Edgecution research.

## Why this is a rule, not a hunt

The source hunt explicitly found **zero results** for this pattern across
all customer environments during the hunt period — this is a rare
technique with a clean signal when it does appear, unlike the noisy
Edge/extension approach (see the companion hunt). Low volume + high
specificity is exactly the shape that belongs as an alerting rule rather
than something requiring human aggregation.

## Tuning note

If your S1 PowerQuery dialect supports a regex/match operator, tighten
this further to match the single-lowercase-letter filename pattern
specifically (`/xml [a-z]\.xml` in the original Sigma-style query) —
this would reduce any noise from legitimate scheduled-task XML exports
that happen to also pass through schtasks.exe with a longer, descriptive
filename. Verify regex support in your console before assuming this
narrower form works as written.

## Response action

Investigate promptly given the rarity of legitimate matches. Pull the XML
file content and the parent process — the source report's confirmed
intrusion involved a Teams-delivered AutoHotkey script establishing this
persistence after QuickAssist-based initial access.