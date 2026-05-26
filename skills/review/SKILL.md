---
name: review
description: Run the evaluator team (Analyst, EM, Partner) on a completed artifact before it reaches the client. Produces a standardized decision log. Say 'review', 'critique this', or triggered automatically before presenting client-facing artifacts.
---

# review

## Purpose

Run the methodology self-critique and revision loop on a completed artifact. Produces a standardized decision log so the user reviews the reasoning, not the full output.

## When to run

- **On demand:** the user says "review", "run review", or "critique this"
- **Automatically:** Triggered by the standing instruction in CLAUDE.md before presenting any client-facing artifact or final pipeline output

## Procedure

### Step 1: Identify risk tier and phase

Assess the artifact:

| Risk tier | Artifact type | Loop depth |
|-----------|--------------|------------|
| Skip | Internal working doc, exploratory analysis, scratch notes | No review |
| Standard | Client-facing data export, pipeline output, formatted deliverable | One critique-revise pass |
| Full | Client-facing strategy, recommendation, anything a senior stakeholder reads, anything with numbers a client will cite | Two critique-revise passes |

Identify which phase(s) of the methodology apply. Most deliverables hit Phase 2 (build verification) or Phase 4 (final output). Some span multiple phases — evaluate against all relevant ones.

### Step 2: Critique pass 1

Read the artifact in full. For each principle in the relevant phase(s), evaluate:

```
Principle: [quote the principle from CLAUDE.md]
Verdict: PASS | FAIL | UNCLEAR
Evidence: [specific reference to what in the artifact satisfies or violates this]
```

Also check the universal principle: "Don't assert what you haven't verified."

Be specific. "PASS — all numbers sourced" is not useful. "PASS — revenue figure on p.2 traces to Q3 export row 147, denominator is explicitly stated as locations with valid websites (n=9,400)" is useful.

"UNCLEAR" means you can't confidently determine pass or fail. These get flagged for the user.

### Step 3: Revise (pass 1)

For every FAIL:
- Fix the violation directly in the artifact
- Log what was changed and why

For every UNCLEAR:
- Make best judgment and note the reasoning
- If genuinely unresolvable (requires the user's domain knowledge or client context), flag it — do not guess

### Step 4: Critique pass 2 (full tier only)

Re-read the revised artifact. Run the same evaluation against every principle. This catches:
- Issues introduced by the revision itself
- Violations the first pass missed
- UNCLEAR items that become clearer after revision

### Step 5: Revise (pass 2, full tier only)

Same as Step 3. Fix FAILs, flag UNCLEARs.

### Step 6: Produce the decision log

Format the decision log as follows. This is not optional — it is the primary artifact the user reviews.

```
## Decision Log — [artifact name]
Risk tier: [skip / standard / full]
Phase(s) evaluated: [list]
Passes: [count]

### Caught and fixed
- [What was wrong] → [What was changed] (Phase X, Principle: "[name]")
- [What was wrong] → [What was changed] (Phase X, Principle: "[name]")

### Flagged for the user
- [What's unclear and why] (Phase X, Principle: "[name]")

### Clean passes (notable)
- [Only list passes worth noting — e.g. "all 14 numbers traced to sources" — not every single PASS]
```

If nothing was caught and nothing is flagged, the decision log is:

```
## Decision Log — [artifact name]
Risk tier: [standard/full]
Phase(s) evaluated: [list]
All principles satisfied. No revisions made. No flags.
```

### Step 7: Present

Show the user:
1. The final revised artifact
2. The decision log immediately after it

Do not explain the review process. Do not narrate what you're about to do. Just run it and present the results.

## What this skill does NOT do

- It does not evaluate whether the review *system* is working over time — that's gap-check
- It does not add new principles — that's gap-check
- It does not replace the user's judgment on flagged items — it surfaces them for her review

## Relationship to other components

- **CLAUDE.md standing instruction** triggers this skill automatically for client-facing output
- **gap-check** evaluates whether this skill is catching what it should, after the user reviews
- The two form a loop: review catches errors → gap-check catches what review missed → new principles gap-check review
