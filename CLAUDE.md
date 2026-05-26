# Operating manual — claude-consult

This file is project-scoped. Claude Code loads it **only when the working directory is inside the `claude-consult` repo**. It does not affect your global `~/.claude/CLAUDE.md`.

If you want these skills available globally, see `setup.sh --global` — but it never modifies your global CLAUDE.md; it prints a snippet for you to paste yourself.

---

## Available skills

| Skill | What it does |
|---|---|
| `problem-solving` | Four-stage facilitation for a new project or scope change (Stages 1-4: define → disaggregate → prioritize → plan) |
| `intake` | Absorbs raw materials (transcripts, briefs, data samples) into a draft Problem Statement Worksheet |
| `pressure-test` | Stress-tests a proposed logic tree or decomposition — finds missing branches, redundancies, blind spots |
| `review` | Runs evaluators (analyst / em / partner) on a completed artifact, scaled to risk tier |
| `analyst` | Evaluator: data integrity, numerical accuracy, schema validation |
| `em` | Evaluator: integration, narrative coherence, alignment with the goal |
| `partner` | Evaluator: cold-read of how the artifact will land with its intended reader |
| `gap-check` | Session-end retrospective: did the review protocol catch everything? |
| `make-slides` | McKinsey-style action-title slide construction |
| `markdown-to-word` | Convert markdown drafts to formatted Word documents |
| `project-hygiene` | Keep project folders clean and scalable |
| `session-capture` | Capture session learnings into persistent memory |
| `find-skills` | Help discover other skills from the open agent skills ecosystem |

---

## Modes (when to invoke which skill)

### Starting work or scoping a change → `problem-solving`

The user might say *"let's scope this"*, *"new project"*, *"problem-solving"*, or bring in raw client materials for a project that has no plan yet. Run the problem-solving skill — it facilitates the four stages. It will spawn `intake` and `pressure-test` automatically when needed.

### Building / executing → no specific skill

Most of the work — drafting documents, analyzing data, writing code, sketching strategy — happens through normal conversation. The skills are scaffolding around the work, not a replacement for it.

### Before shipping anything you'd be embarrassed to get wrong → `review`

Run review on the artifact. It will pick the evaluator team scaled to risk:
- Internal-only working doc → skip review entirely
- Client-facing data or analysis → run `analyst` only
- Strategy, recommendations, or anything a senior stakeholder reads → run all three (`analyst` → `em` → `partner`)

Present the artifact + the synthesized decision log. The decision log is not optional.

### End of session → `gap-check`

If the session produced any output worth evaluating: run `gap-check`. One question: did the review miss anything? If yes, draft a new principle that would have caught it. Get approval before adding to the rubric.

If the session was purely exploratory (thinking, research, planning) with no deliverables: skip gap-check. Say "no deliverables this session — skipping gap-check."

### Other moments

- **Project folder getting messy** → `project-hygiene`
- **Mid-session natural breakpoint, valuable insights to preserve** → `session-capture`
- **User wishes there were a skill for X** → `find-skills`

---

## Self-evaluation protocol

Before presenting any artifact the user would ship (client-facing, sent to a senior stakeholder, going to a system of record):

1. **Assess risk tier:** internal → skip. Client-facing data → standard (analyst only). Strategy or senior stakeholder material → full (analyst → em → partner).
2. **Run review.** It spawns the evaluator team, collects the decision logs, fixes what the evaluators catch, surfaces what they can't resolve.
3. **Present the final artifact plus the synthesized decision log.** Both. Always.

---

## Methodology — five phases

The full framework is in [framework.md](framework.md). The phase-level summary:

### Phase 0 — Problem definition and scoping

*Are we solving the right problem for the right person?*

- Business value is stated explicitly and measurably.
- The problem decomposes into questions that compose end-to-end.
- Quality gates are specific thresholds, not aspirations.
- Data is profiled before any work begins (Phase 0 deliverable, not a precursor).
- Every denominator is explicit and agreed before generating a single number.

### Phase 1 — Workstream planning

*Does each piece of work have a clear plan that could be executed without inferring intent?*

- Every workstream specifies: start point, actions, output schema, success criteria, failure criteria, ambiguity handling.
- Taxonomies and expected categorical values are enumerated before generation.
- The insight layer is designed from the start — what decision does each stakeholder need to make?

### Phase 2 — Build and initial verification

*Does what we built actually do what we intended — not just run without errors?*

- "COMPLETED" is not success. Every output is verified against what was requested.
- At early scale (100 records, 10 drafts, 5 cases): audit for systemic issues before scaling.
- Errors are profiled into typed clusters. Aggregate error rate hides the structure.
- Don't infer intent. The gap between what you meant and what you wrote is where errors live.

### Phase 3 — Evaluation and stress-testing

*Would I stake my reputation on this output?*

- Random sample 3-5% of any volume work for human review.
- Lock evaluation baselines after first passing run. Compare every subsequent run for regression.
- Test the output against the north star. Does it answer the actual question?

### Phase 4 — Final output and delivery

*When the reader opens this, does it respect their time, answer their question, and build trust?*

- Every number is defensible — traceable to source, denominator, methodology.
- Completeness is visible — population, exclusions, confidence levels are explicit.
- The promise matches the capability — current reality, not best-case projections.
- The work is reader-ready, not process-ready — structured around their decision, not your workflow.

---

## Behavioral notes

- **Match the user's pace.** Move fast when they move fast. Dwell when they dwell.
- **Challenge, don't just capture.** If the user says the problem is X but the materials suggest Y, say so before building on the wrong frame.
- **Surface what you don't know.** "I don't have enough information to assess this — what would help?" beats filling in a guess.
- **Cite your sources.** Every quantitative claim traces to a source the user could verify in seconds.
