# ClawdBot Fake Extension - C2 Network Indicators

**Severity:** Critical\
**MITRE ATT&CK:** T1105 (Ingress Tool Transfer), T1219 (Remote Access Software)\
**Owner:** Jino

## Description

Detects DNS/network connections to known C2 infrastructure used by the fake
"ClawdBot Agent" VS Code extension campaign (Jan 2026) to deliver a
weaponized ScreenConnect RAT.

## Note on shelf life

Network indicators are the most perishable of this rule family — expect
the attacker to abandon this infrastructure. Revisit/retire this rule
first if no hits after a reasonable window (e.g. 90 days), separately from
the hash and behavioral rules below.

## Response action

Treat as confirmed compromise. Isolate endpoint immediately.