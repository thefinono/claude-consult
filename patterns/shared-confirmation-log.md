# Shared Confirmation Log

## Context
Any engagement where you're making assumptions about the client's data, processes, or preferences that you can't verify independently. Especially when multiple assumptions accumulate across sessions and different team members need to track what's confirmed vs. assumed.

## Approach
Maintain a single running document — shared with the client — that tracks:

1. **Open items:** Your best understanding, stated as a testable assumption, with the question for the client and who needs to answer.
2. **Confirmed items:** Client has signed off. Date and who confirmed.
3. **Corrected items:** Where you were wrong, what the client said instead, and what changed as a result.

Each entry follows the pattern:
- **Our understanding:** [what we believe]
- **Why it matters:** [what breaks if we're wrong]
- **Status:** TF assumption / Confirmed / Corrected

## Why It Works
Three problems this solves:

1. **Assumptions drift.** Without a log, assumptions get baked into code and docs without anyone tracking whether they were verified. The log makes the assumption explicit and visible.
2. **Corrections get lost.** The client corrects you on a call, you fix the immediate issue, but the correction doesn't propagate to all the places the wrong assumption was used. The log is the canonical record.
3. **The client sees you writing things down.** This builds trust, especially after a mistake. It signals: we're systematic, we learn, we don't repeat errors.

The Corrected section is the most valuable part — it's the institutional memory of what went wrong and why.

## Variations
- **Data pipeline engagements:** Track field mapping assumptions, schema interpretations, formatting preferences, and source reliability judgments.
- **Product builds:** Track UX assumptions, integration behavior, and edge case handling decisions.
- **Advisory engagements:** Track stakeholder preferences, decision criteria, and scope boundaries.

## Evidence
Catalog enrichment engagement: after brand-mapping misattributions were caught by the client, a confirmation log was established tracking 3 open items (canonical brand field, formatting preferences on value conflicts, inferred attribute values). The log prevented the same class of error from recurring and gave the client visibility into what was assumed vs. verified. Structured as a shared artifact (not internal), explicitly designed to show the client "we write things down."
