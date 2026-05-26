# claude-consult — the framework

A short essay on the methodology behind claude-consult. If you've read the README and want to understand *why* the system is shaped the way it is, this is for you.

---

## The problem

You use AI to help with consequential work — analysis, planning, writing, research. The output looks polished. Sometimes you ship it and find out later it was confidently wrong about something specific that mattered. Now you don't trust the output by default, so you spend hours checking everything. Or you avoid the leverage AI gives you on the work that most needs leverage.

The problem isn't prompt quality. You can write a great prompt and still get back surface-good-actually-wrong output. The problem is that AI-assisted work doesn't fail in obvious ways. It fails by being plausible — well-structured, confidently stated, and wrong about a fact, a number, a framing, or a logical step.

What's missing isn't a better model. It's a *system around the model* that catches the predictable failure modes before they reach the reader.

claude-consult is that system, sized for one person.

---

## The four-layer model

Every consequential piece of AI-assisted work passes through four layers. Most people only think about two of them.

### 1. Think — decompose before you commit

The most common AI failure isn't bad execution. It's the AI solving the wrong problem really well.

You ask Claude to "analyze customer churn" and you get back a polished analysis of behavioral patterns — when the actual question your stakeholder was asking was "should we change our pricing model?" The analysis is impeccable. It just doesn't matter.

Decomposition forces the right question to surface before generation begins. The four stages of the `problem-solving` skill:

- **Define** the basic question. Not "analyze churn" but "what decision does the stakeholder need to make, and what would change for them if they had the answer?"
- **Disaggregate** into sub-questions. What needs to be true for the basic question to have a clean answer? Stress-test this decomposition before you trust it (this is what `pressure-test` is for).
- **Prioritize** by impact and feasibility. What's the cheapest first cut that proves or disproves the most expensive assumption?
- **Plan** specifically. "Execute without inferring intent" is the bar. If a stranger picked up your plan, would they know what to do at every step?

Most knowledge workers skip this because it feels slow. It is faster than the alternative — building the wrong thing and discovering it on Friday.

### 2. Build — execute with discipline

This layer is conventional. You do the work. The AI helps. There's no special skill for "build" — building is what you do all day. But there are five disciplines that make build phase output trustworthy:

1. **State the population.** Every number has a denominator. Make it explicit before generating.
2. **Audit at small scale before going to volume.** Run the pipeline on 10 records. Look at all 10. Fix what's wrong. Then run on 1000.
3. **Profile errors, don't just count them.** An aggregate error rate hides the structure. Three error clusters in different sub-populations means three different fixes.
4. **Verify, don't infer.** When Claude says "this column is the manufacturer," check that it's actually the manufacturer, not the warehouse with a similar prefix.
5. **Don't ship partial work as complete.** "COMPLETED" is not success. The output is verified against what was actually requested, in writing.

### 3. Review — critique on multiple axes

A single review pass with a single lens misses what other lenses would catch. The `review` skill spawns up to three evaluators, each blind to what the others check:

- **`analyst`** reads for data integrity. Are the numbers right? Do the denominators make sense? Are the sources cited? Are the schemas valid? The analyst is blind to narrative — it doesn't care if the story is well-told.
- **`em`** reads for composition. Do the pieces compose into an answer? Is the narrative coherent? Does the work address the original question, or did it drift? The EM is blind to individual numbers — it trusts those to the analyst.
- **`partner`** reads cold. If your reader opened this file with no context, what would they make of it? Is the framing right for the audience? Is there visible process scaffolding that should have been removed? The partner is blind to data mechanics.

The trick is that no human reviewer can hold all three lenses simultaneously. Sequential evaluators each in their lane catch more than one reviewer trying to do everything at once.

Risk-tier the spawn: internal-only doc → skip. Client-facing data → `analyst` only. Senior stakeholder material → all three.

### 4. Reflect — improve the rubric, not the artifact

When something slips through review, the wrong response is "fix this one artifact and move on." The right response is "the review missed this class of error — update the rubric so it doesn't miss the next instance."

`gap-check` runs at session end and asks one question: *did the review miss anything on today's deliverables?*

If yes:
1. Identify the failure mode. What category of error was it?
2. Draft an evaluation principle that would have caught it. Specific enough to be actionable, not so specific that it only applies to one case.
3. Get approval. Show the principle and where it would go in the rubric.
4. Update the rubric.

The git history of the rubric is the improvement record. Healthy signal: rate of new additions slows over time — the system has learned the common failure modes. Unhealthy signal: the same category of error recurs despite added principles — the principles aren't specific enough.

---

## Why this works

Three reasons.

**Most failures are predictable.** The classes of error that catch you on AI-assisted work are not infinite. They cluster into ~20 patterns. A reviewer who knows the patterns catches them; a reviewer who doesn't, doesn't. The evaluator rubrics encode the patterns, so the reviewer doesn't have to remember them.

**Lenses are cheaper than wisdom.** Asking "is this right?" is hard. Asking "is every number traceable to a source?" is easy. The first requires judgment; the second is a checklist. Decomposing review into lens-specific checks lowers the cognitive load of evaluation, which makes evaluation actually happen.

**The system compounds.** Every gap caught becomes a new check. The rubric gets sharper. The next session's review is better than today's. This is the only durable advantage in AI-assisted work — execution velocity that gets faster with every iteration, not a one-time prompt that you keep tuning.

---

## What's not in the system

This is a system for *trustworthy delivery* of AI-assisted work. It's not:

- A prompt library. The skills give you scaffolding around prompts, not the prompts themselves.
- A model-evaluation framework. If you're building AI products and need to measure model quality at scale, you need different tooling.
- A project management system. The skills assume you have somewhere to keep your work — they don't try to be your task tracker.

It also doesn't try to substitute for taste. The system tells you when something is wrong, not what would be right. The judgment about what to ship is still yours.

---

## How to adopt it

Three ways to start, in order of commitment:

1. **Try one skill on real work.** `problem-solving` is the highest leverage on its own — use it next time a piece of work feels vague. You don't need the other skills installed to benefit.
2. **Run `review` before sending one document.** Pick a piece of work you're nervous about. Run `review` on it. See what the three evaluators catch.
3. **Adopt the full loop.** Install the skills globally (`./setup.sh --global`). Use `problem-solving` at project start, `review` before shipping, `gap-check` at session end. Watch the gap rate drop over the first month.

---

## A note on origin

claude-consult is distilled from a practitioner's notes across many enterprise engagements, generalized for any knowledge worker doing consequential AI-assisted work. The specific examples that informed the patterns are not in this repo — they live in private. What's here is the methodology, the skills, and the patterns that transfer.
