# SentinelOne-Rules

SentinelOne STAR detection rules and threat hunting queries — S1QL and
PowerQuery versions maintained side-by-side per rule.

## Structure

rules/
  <client-or-global>/
    <rule-name>/
      query.s1ql     - Deep Visibility / STAR rule syntax
      query.pq       - Singularity Data Lake PowerQuery syntax
      notes.md       - description, severity, MITRE ID, scope, status, rule ID

Use rules/global/ for org-wide rules; rules/<client-name>/ for client-scoped ones.

## Workflow

1. Create a folder under rules/ for the new rule.
2. Add query.s1ql and/or query.pq.
3. Fill in notes.md with severity, MITRE mapping, and why the rule exists.
4. Open a PR, get it reviewed, merge.
5. Manually create/update the rule in the SentinelOne console. Paste the
   assigned rule ID back into notes.md and commit that update.