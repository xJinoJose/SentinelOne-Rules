# LOLBAS Abuse - Regsvr32 Making Outbound Network Connection

**Severity:** High\
**MITRE ATT&CK:** T1218.010 (System Binary Proxy Execution: Regsvr32),
T1105 (Ingress Tool Transfer)\
**Owner:** Jino

## Description

Detects regsvr32.exe itself initiating a network connection. Regsvr32
registering a locally-present DLL has no reason to touch the network —
any outbound connection from this process is consistent with the
Squiblydoo pattern of fetching a remote .sct scriptlet (or a DLL fetching
a second-stage payload once loaded).

## Why this rule exists alongside the /i:http command-line rule

The earlier regsvr32-squiblydoo.pq rule matches on command-line content
containing "http" alongside /i: and scrobj.dll. This rule is a backstop:
if an attacker obfuscates or splits the command line to dodge that
string match (e.g. via environment variable expansion, or a local .sct
that itself fetches remotely), the network behavior itself is still
observable and still anomalous, independent of how the command line reads.

## Tuning note

Very rare source of false positives given regsvr32's expected behavior,
but confirm your S1 event schema exposes network connections keyed to the
initiating process (src.process.name) correctly before relying on this —
verify against console autocomplete like the other PowerQuery rules.

## Response action

Investigate immediately — capture the destination IP/domain and cross-
reference against the other regsvr32 rules and any known threat intel.