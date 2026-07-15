# Browser Syncjacking - Unexpected Browser Cloud Management Enrollment

**Severity:** High\
**MITRE ATT&CK:** T1176.001 (Browser Extensions: Malicious Extensions),
T1112 (Modify Registry)\
**Owner:** Jino

## Description

Detects registry writes to CloudManagementEnrollmentToken (Chrome) or
EdgeManagementEnrollmentToken (Edge) — the keys that enroll a browser
into a cloud-based browser management platform. Adversaries can execute
arbitrary code to covertly enroll a victim's browser into an
attacker-controlled management console, then use that access to weaken
browser security policy or force-install additional malicious extensions,
without further local code execution required for persistence.

## Why this is High rather than Medium

Unlike native messaging registration (which has substantial legitimate
use), enrollment into a browser management platform outside of an
IT-administered deployment has very little legitimate reason to occur
unexpectedly. If BBB or a client's IT team manages this via GPO/Intune as
standard practice, expect and baseline those events specifically —
anything outside that expected enrollment path is a strong signal.

## Response action

Investigate immediately. Confirm whether the enrolling management console
is one BBB or the client administers. If not, treat as likely active
compromise — check the browser's installed extensions and policies for
unauthorized changes.