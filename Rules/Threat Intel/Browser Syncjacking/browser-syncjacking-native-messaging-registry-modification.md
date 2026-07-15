# Browser Syncjacking - Suspicious NativeMessagingHosts Registry Modification

**Severity:** Medium\
**MITRE ATT&CK:** T1176.001 (Browser Extensions: Malicious Extensions),
T1112 (Modify Registry)\
**Owner:** Jino

## Description

Detects modification of the NativeMessagingHosts registry key (which
registers a native messaging host for a Chromium-based browser extension)
originating from a common LOLBin (cmd.exe, powershell.exe, reg.exe) or
from a user-writable directory (Users, ProgramData, Temp). Native messaging
is a legitimate Chromium mechanism for bidirectional communication between
a browser extension and a local application — but this is also the
mechanism used by malicious extensions to establish a persistent local
C2/backdoor channel, since it allows a browser process to spawn and talk
to an attacker-controlled binary.

## Known false positives (from source hunt report)

This is a genuinely noisy signal — the underlying research explicitly
found legitimate hits from svchost.exe enforcing GPSvcGroup policy
(managed-browser group policy) and from legitimate software installers
that configure native messaging as part of normal setup (e.g. SAP's front
end component installer). Expect to tune out both patterns early.

## Tuning note

Consider adding an explicit exclusion for known-legitimate installers in
your environment (SAP, and any other software your clients run that
legitimately registers native messaging hosts) once you've baselined a
site, rather than trying to get this perfectly tuned before first
deployment.

## Response action

Investigate — correlate with the extension ID/path being registered and
check its prevalence/reputation before escalating.