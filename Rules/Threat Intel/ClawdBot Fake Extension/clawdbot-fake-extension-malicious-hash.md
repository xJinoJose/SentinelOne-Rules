# ClawdBot Fake Extension - Known Malicious File Hashes

**Severity:** Critical\
**MITRE ATT&CK:** T1195.001 (Supply Chain Compromise), T1105 (Ingress Tool Transfer)\
**Owner:** Jino

## Description

Detects file creation matching known SHA256 hashes from the fake ClawdBot
extension campaign: the weaponized ScreenConnect installer (Code.exe) and
the Rust-based sideloaded loader (DWrite.dll).

## Note on shelf life

Hashes break the moment the attacker recompiles. Useful for confirming this
specific incident, not durable long-term protection against variants.

## Response action

Treat as confirmed compromise. Isolate endpoint immediately, rotate any API
keys entered into the extension.