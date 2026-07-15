# Remote Access Tool Detection - Ammyy Admin

**Severity:** High\
**MITRE ATT&CK:** T1219 (Remote Access Software)\
**Owner:** Jino

## Description

Detects execution of Ammyy Admin (AA_v3.exe / "Ammyy Admin.exe"), a
portable remote access tool by Ammyy LLC. Rated higher severity than the
other tools in this folder due to a well-documented history of serious
abuse: it is the tool most classically associated with tech-support scam
calls ("read me your Ammyy Admin ID"), and the official installer from
ammyy.com has been compromised at the source on multiple occasions to
distribute malware (including the Lurk banking trojan and use by the
Anunak/Carbanak APT group against financial institutions).

## Tuning note

Fully portable — runs directly from a downloaded exe with no install step,
commonly observed executing from Downloads, Desktop, or Temp rather than a
proper Program Files location. Unlike TeamViewer/Splashtop, absence from
Programs and Features does not mean absence from the endpoint. If any BBB
client uses Ammyy Admin as a sanctioned support tool, scope this rule to
exclude that client rather than relying on process presence alone — though
given its abuse history, this is a good candidate to flag as unauthorized
by default for most clients rather than assumed benign.

## Response action

Given the tool's disproportionate association with scam and APT activity
compared to the other remote-access tools tracked here, treat a match as
higher priority by default — verify legitimate business use before
dismissing, rather than the reverse.