# ClawdBot Fake Extension - Suspicious Code.exe Staging Path

**Severity:** High\
**MITRE ATT&CK:** T1036 (Masquerading), T1105 (Ingress Tool Transfer)\
**Owner:** Jino

## Description

Detects a process named Code.exe launching from a path containing
"Lightshot" — the staging folder observed in the fake ClawdBot extension
campaign. Legitimate VS Code's Code.exe does not run from this location,
making this a strong anomaly signal even independent of the specific C2
infrastructure or file hashes in the other two ClawdBot rules.

## Why this one's separate and slightly lower severity

Behavioral/path-based, not an exact IOC match like the hash rule — treat as
"strong indicator, verify" rather than "confirmed compromise" on its own.
More durable than the network/hash rules if the campaign's infrastructure
or binaries change, since the staging-path pattern may persist across
variants.

## Response action

Investigate before isolating if this is the only rule that fired (no
network or hash match) — confirm it's not a legitimate app with an
unrelated naming coincidence before treating as confirmed compromise.