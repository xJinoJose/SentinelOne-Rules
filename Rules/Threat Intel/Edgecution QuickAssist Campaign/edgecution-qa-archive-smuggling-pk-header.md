# Edgecution Cluster - Archive Smuggling via Manual PK Header Reconstruction

**Severity:** High\
**MITRE ATT&CK:** T1027 (Obfuscated Files or Information), T1105
(Ingress Tool Transfer)\
**Owner:** Jino

## Description

Detects a command line manually writing the ZIP file magic bytes ("PK"
header) to disk — either via `set /p="PK" >` (cmd.exe redirection) or
PowerShell's `Set-Content -Value ... -Encoding Byte`. This is "archive
smuggling": reconstructing a ZIP archive byte-by-byte on the endpoint
rather than downloading a complete .zip file, specifically to evade
content-inspection/file-type detection that would otherwise flag an
incoming archive.

## Source

Internal hunt report, "Emerging Threat Cluster - Newly Observed TTPs"
(June 2026), part of the same cluster's Havoc C2 delivery chain alongside
DLL sideloading.

## Known false positives (from source hunt report)

The source hunt found a small number of matches for this pattern, and on
review determined they were tied to legitimate AI tooling rather than
malicious activity. Expect to encounter and tune out this specific
category of false positive early — the source report doesn't specify
which AI tool triggered it, so treat the first few hits as a baselining
exercise for your own environment.

## Response action

Investigate — this technique is uncommon enough overall (source report:
"similarly uncommon, yielding a small number of results") that most
non-AI-tooling hits are worth a closer look. Check for a subsequent DLL
sideloading pattern or unexpected process spawned from the
newly-reconstructed archive's contents.