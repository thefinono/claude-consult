# claude-consult

**A skills toolkit for trusting AI-assisted work on consequential decisions.**

If you use Claude (or another AI) for analysis, planning, writing, or research — and you've been burned by surface-good-actually-wrong output before — this gives you a structured way to make AI-assisted work trustworthy enough to ship.

It's a set of 13 skills for [Claude Code](https://claude.com/claude-code) (Anthropic's terminal-based Claude). No engineering background required to use them.

---

## What's in the box

Four layers, thirteen skills:

| Layer | When you'd use it | Skills |
|---|---|---|
| **Think** | Starting a new project, or scope just changed | `problem-solving` (with `intake` + `pressure-test` as helpers) |
| **Review** | About to ship something you'd be embarrassed to get wrong | `review` (with `analyst` + `em` + `partner` as evaluators) |
| **Reflect** | End of a session that produced consequential output | `gap-check` |
| **Utility** | Throughout the work | `make-slides`, `markdown-to-word`, `project-hygiene`, `session-capture`, `find-skills` |

Plus two patterns observed from practice: `dual-format-deliverables` and `shared-confirmation-log`.

---

## Install

There are two ways to use this. Pick based on whether you want the skills only inside this directory, or everywhere.

### Default: project-scoped (recommended for trying it out)

Clone, then work inside the cloned folder. Claude Code reads the project's `CLAUDE.md` only when your working directory is inside the clone. **Your global Claude config is not touched.**

```bash
cd ~/projects  # or wherever you keep work
git clone https://github.com/thefinono/claude-consult.git
cd claude-consult
claude
```

Once Claude Code opens, try:
> "What skills are available?"

You should see the 13 skills listed.

### Opt-in: global install (for everyday use)

If you want these skills available in any directory:

```bash
./setup.sh --global
```

This will:
1. Copy `skills/` into `~/.claude/skills/` (or symlink — your choice at prompt time)
2. **Print** (does not write) a snippet to add to your `~/.claude/CLAUDE.md` so Claude knows about the skills

It will not modify your existing global `CLAUDE.md`. You review the snippet and paste it yourself, where you want it.

To uninstall the global skills:
```bash
rm -rf ~/.claude/skills/{analyst,em,partner,intake,pressure-test,gap-check,review,problem-solving,make-slides,markdown-to-word,project-hygiene,session-capture,find-skills}
```
(then remove the snippet from your global `CLAUDE.md`)

---

## The four layers

### Think — `problem-solving`

Structured four-stage facilitation for a new project or significant scope change:

1. **Problem statement** — fill a one-page worksheet (basic question, stakeholders, success criteria, scope, constraints). The `intake` skill absorbs raw materials (transcripts, briefs, data samples) and drafts the worksheet for you to refine.
2. **Disaggregate** — decompose the problem into answerable sub-questions. The `pressure-test` skill stress-tests your decomposition — finds missing branches, redundancies, blind spots.
3. **Prioritize** — rank workstreams by impact and feasibility. Define quality gates per workstream.
4. **Plan** — produce workstream plans specific enough to execute without inferring intent.

**Trigger:** ask Claude *"let's scope this"* or *"new project"* or *"problem-solving"*.

### Review — `review`

Spawns up to three evaluator skills on a completed artifact, scaled to risk:

- **`analyst`** — checks numbers, sources, calculations, schemas. Blind to narrative.
- **`em`** — checks composition, narrative, alignment with the goal. Blind to individual numbers.
- **`partner`** — cold-read of how the artifact will land with its intended reader. Blind to data mechanics.

Each one critiques, fixes what it can, flags what it can't. You read the synthesized decision log, not the full artifact again.

**Risk tiering:**
- Internal working doc → skip
- Client-facing data → `analyst` only
- Senior stakeholder material → all three

**Trigger:** ask Claude *"review this"* or *"critique this"*.

### Reflect — `gap-check`

At session end (or on demand), one question: *"Did the review miss anything on today's deliverables?"*

If yes: drafts an evaluation principle that would have caught the class of error next time. Updates the rubric only after you approve.

The git history of this repo is the improvement record over time. Healthy signal: rate of new additions slows down.

**Trigger:** ask Claude *"gap-check"* or run it automatically at session end.

### Utility layer

| Skill | What it does |
|---|---|
| `make-slides` | McKinsey-style action-title slide construction |
| `markdown-to-word` | Convert markdown drafts to formatted Word documents (.docx) |
| `project-hygiene` | Keep project folders clean and scalable. Useful at project start or when the root gets cluttered. |
| `session-capture` | Capture session learnings into persistent memory before they compress away |
| `find-skills` | Help discover other skills you might want from the open agent skills ecosystem |

---

## Repo structure

```
claude-consult/
├── CLAUDE.md           # project-scoped operating manual (loads only when cwd is inside this dir)
├── README.md           # this file
├── LICENSE             # PolyForm Noncommercial 1.0.0
├── setup.sh            # optional global install (safe — never modifies your global CLAUDE.md)
├── framework.md        # the underlying methodology
├── skills/             # the 13 skills
└── patterns/           # observed patterns
```

---

## Why this exists

Most advice on "AI for knowledge work" stops at prompt-craft. That's necessary but not sufficient. The hard part is making AI-assisted output *trustworthy enough to ship* on work where being wrong has real consequences.

The system rests on four discipline beats:

1. **Decompose before you commit** — most AI failures are the AI solving the wrong problem really well. Forcing a structured decomposition before generating reduces this dramatically.
2. **Critique on multiple axes** — a single review pass with a single lens misses what other lenses would catch. Three evaluators reading in their lanes catches more than one reviewer trying to hold all the lenses at once.
3. **Improve the rubric, not the artifact** — when something slips through review, the lesson is "the review missed this class of error" — not "fix this one artifact." Updating the rubric makes the next review catch the next instance.
4. **Capture learnings before they compress** — what you learned in a session is the most valuable thing produced. Without a capture habit, it's lost when the context window resets.

---

## License

[PolyForm Noncommercial 1.0.0](LICENSE). Free for personal use, study, and noncommercial work. Commercial use requires explicit written permission.

Required Notice: Copyright (c) 2024-2026 Fiona Li.
