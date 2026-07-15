# NetSupport RAT - C2 Network Pattern

**Severity:** Critical\
**MITRE ATT&CK:** T1219 (Remote Access Software), T1071 (Application
Layer Protocol)\
**Owner:** Jino

## Description

Detects client32.exe making an outbound request matching NetSupport's
distinctive C2 protocol fingerprint — a URL path containing "fakeurl.htm"
and/or a User-Agent string of "NetSupport Manager/<version>". This pattern
has been independently confirmed by eSentire and multiple other sources
across numerous 2025-2026 NetSupport RAT campaigns and does not depend on
knowing any single campaign's specific C2 IP/domain, which rotates
frequently.

## Tuning note

If NetSupport Manager is a legitimate, sanctioned tool at a given client,
this will also fire on that legitimate traffic — the protocol fingerprint
doesn't distinguish authorized use from malicious use, only the presence
of NetSupport's C2 protocol itself. Pair with Rule 1 (path-based) for
higher-confidence triage: a hit on both rules for the same host is a much
stronger signal than either alone.

## Response action

Treat as likely active compromise, especially if paired with a hit from
persistence-nonstandard-path.pq. Capture the destination IP/domain for
IOC tracking — campaign infrastructure rotates, but this protocol pattern
has remained consistent across campaigns since at least 2023.