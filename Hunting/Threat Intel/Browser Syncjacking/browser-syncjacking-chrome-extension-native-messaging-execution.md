# Browser Syncjacking - Browser Extension Spawning Native Messaging Host

**MITRE ATT&CK:** T1176.001 (Browser Extensions: Malicious Extensions),
T1059 (Command and Scripting Interpreter)\
**Owner:** Jino

## Description

Detects a Chromium-based browser process invoking a chrome-extension://
reference on its command line while spawning a non-browser child process
— the pattern of a browser extension instantiating its native messaging
host (the local backdoor binary). This is the core mechanism behind
browser syncjacking-style attacks: the browser, a trusted process, spawns
and talks to attacker code.

## Known false positives (from source hunt report)

This is the noisiest of the three rules by a wide margin. The underlying
research found this pattern across many entirely legitimate extensions
using native messaging as designed — password managers, Avast/McAfee
extensions, a 1Password beta build, and various speech-recognition and
translation tools. Filtering only by low global prevalence of the
extension ID did **not** meaningfully improve the true-positive rate in
that research.

## What actually worked in the source investigation

The one confirmed malicious hit in the source research was found through
this approach, but the giveaway wasn't the extension/native-messaging
pattern alone — it was the specific downstream chain: cmd.exe invoking a
batch script from ProgramData with a chrome-extension:// argument, which
then spawned PowerShell running encoded commands for discovery (e.g.
`ipconfig /all`). Consider this rule a starting filter to narrow the
haystack, then manually inspect hits for that kind of encoded-PowerShell/
discovery-command follow-on rather than expecting the base rule alone to
be high-confidence.

## Tuning note

If this proves too noisy in practice, aggregate by child process
name + browser extension ID and prioritize investigation on combinations
you haven't seen before in your environment, per the source research's
own approach — rather than trying to write a tighter filter condition.

## Response action

Investigate the child process's command line and further descendants
before escalating. Low individual confidence, high value as a pivot point
once you see a genuinely unfamiliar extension/child-process pairing.