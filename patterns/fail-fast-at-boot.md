# Fail fast at boot, never silently degrade

A design principle for skills (or any AI workflow) that depend on external tooling.

## The principle in one line

**Specify exact tooling and fail-fast at boot; never silently degrade to lower-fidelity output without a refusal opportunity.**

## What goes wrong without this principle

A skill written with implicit "best-effort" tooling, with manual fallback as a soft escape, can silently produce lower-fidelity output when the assumed tooling isn't available. The user never gets the refusal opportunity — they get a degraded result that looks like the real thing.

A canonical example: a website audit skill is supposed to ship a *measured* baseline by querying live AI search engines. In practice during a dry-run:

- One API path was blocked by provenance restrictions.
- Browser automation wasn't granted in the session.
- Search results didn't surface the expected content for the target queries.
- No manual paste was solicited because no preflight check existed.

Result: a "calibrated prediction" section shipped as a finding — labeled honestly in the confidence section, but still presented as the deliverable. The reader has no way to distinguish "we measured this" from "we guessed." For someone deciding where to spend limited time and money, that distinction matters.

## The three sub-rules

### Rule 1: Specify exact tooling paths, not soft preferences

For any methodology step that depends on external tooling, the spec must enumerate the acceptable paths concretely. Not *"use live AI engines"* but *"use one of: (a) browser automation against [specific URLs], (b) [specific API calls], or (c) [specific manual paste flow]."* Each path has reliability trade-offs the skill should weight in order.

### Rule 2: Preflight at boot, not at section time

Tooling availability checks run **before** any substantive work. If the required tooling isn't available, the skill refuses to start. The failure case must be: *"Cannot proceed because X is missing. Here's how to fix it."* Not: *"[8 minutes of work] ... oh, I couldn't measure Y so here's a prediction instead."*

This protects the user's time (no wasted long waits) and the skill's epistemic integrity (no degraded output masquerading as measured findings).

### Rule 3: Refusal is a feature, not a failure

The skill that refuses cleanly is better than the skill that degrades quietly. Refusing tells the user what's missing and how to fix it. Degrading produces an output the user might act on, with no clear signal that something's wrong with the data underneath.

Refusal language should be specific:
- Which tooling paths were checked
- What specifically was missing
- The minimum action to make the skill shippable
- The reason quiet degradation would be worse than refusal

## Where the principle applies

Anywhere a skill depends on external tooling that may not be available in a given session — connectors, APIs, browser automation, third-party services, OAuth-gated data sources, file-system access patterns. The bigger the gap between "with the tooling" and "without the tooling" output quality, the more important the preflight.

## A coupled principle

This pairs tightly with: **distinguish measured findings from inferred findings in every output.** Silent degradation usually produces inferred findings labeled as measurements. The two principles together: refuse to ship when measurement isn't possible *and* never present an inference as a measurement when both are visible to the reader.

## Why this matters

If a skill claims to do work at the level of a senior practitioner (an analyst, a marketing director, a strategist), it has to hold to that standard. A real senior practitioner would never deliver a report with predictions presented as measurements. The skill must hold to the same standard — or refuse the work and say why.

The corollary: when the skill cannot operate at the claimed level (because tooling isn't available), the right move is to say so plainly and refuse — not to produce something that looks like the right thing but is actually inferior. **Better to send the user away with "I can't do this yet, here's why" than to send them away with a degraded artifact they might act on.**

---

*Originating context: surfaced during the design of a site-audit skill that ships a measured AI-engine visibility baseline. The principle generalized cleanly to other skills in the same plugin and to any workflow that depends on tooling that may not be present at runtime.*
