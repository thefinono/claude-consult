---
name: gap-check
description: Evaluate whether the review protocol caught everything on today's deliverables. Captures clean passes and gaps, drafts new evaluation principles when gaps are found. Run at session end after any client-facing artifact or pipeline output, or say 'gap-check'.
---

# gap-check

## Purpose

Evaluate whether the CLAUDE.md review protocol is working. Captures both clean passes (review caught everything) and gaps (the user caught something review missed). When a gap is found, drafts a new evaluation principle and adds it to CLAUDE.md after approval.

## When to run

- **Automatically** at session end, after session-capture and praxis, if the session produced any client-facing artifact or pipeline output.
- **On demand** mid-session when the user says "gap-check" or "run gap-check" after reviewing a specific deliverable.

If the session was purely exploratory (thinking, research, planning) with no deliverables, skip this skill at session end. Say "No deliverables this session — skipping gap-check."

## Procedure

### Step 1: Ask

Ask the user one question:

> "Did the review miss anything on today's deliverables?"

Wait for the answer. Do not proceed without it.

### Step 2a: If no gaps (clean pass)

Log a clean pass entry:

```bash
echo "$(date '+%Y-%m-%d') | PASS | [deliverable name/type] | Review caught everything" >> ~/.claude/gap-check.log
```

Say what was delivered and that the review held. Done.

### Step 2b: If there was a gap

Ask the user to describe what she caught. Then:

1. **Identify the failure mode.** What category of error was it? Wrong number, silent incompleteness, framing mismatch, process artifact left visible, something new?

2. **Draft the principle.** Write a concise, testable evaluation criterion that would have caught this. Follow the style of existing principles in CLAUDE.md — specific enough to be actionable, not so specific that it only applies to one engagement.

3. **Propose placement.** Name the phase (0-4) or universal section where it belongs. Show the exact location in CLAUDE.md where it would be inserted — quote the line before and after.

4. **Get approval.** Show the user the principle and placement. Do not modify CLAUDE.md until she approves.

5. **Update CLAUDE.md.** After approval, add the principle directly to `~/.claude/CLAUDE.md` using str_replace or equivalent. Do not rewrite the file — insert only.

6. **Log the amendment:**

```bash
echo "$(date '+%Y-%m-%d') | GAP | [deliverable name/type] | [what was missed] | [principle added] | [phase]" >> ~/.claude/gap-check.log
```

7. **Commit the change:**

```bash
cd ~/.claude && git add CLAUDE.md && git commit -m "principle: add [brief description of principle]" && git push
```

If ~/.claude is not a git repo, tell the user and suggest initializing one. The git history IS the eval record over time. Always push after committing so the GitHub backup stays current.

### Step 3: Summary

End with a one-line summary:

- Clean pass: "Methodology held on [deliverable]. Logged."
- Gap found: "Added [principle name] to Phase [N]. [X] total amendments since deployment."

## How to review over time

After two weeks, or whenever the user wants to assess performance:

```bash
# See all entries
cat ~/.claude/gap-check.log

# Count passes vs gaps
grep -c "PASS" ~/.claude/gap-check.log
grep -c "GAP" ~/.claude/gap-check.log

# See amendment history
cd ~/.claude && git log --oneline CLAUDE.md
```

**Healthy signals:**
- PASS rate increasing over time
- GAP rate decreasing over time
- Rate of new amendments slowing down
- the user reviewing decision logs instead of full artifacts

**Unhealthy signals:**
- Flat or increasing GAP rate (principles aren't specific enough)
- Decision logs consistently marked "generic" or unhelpful
- Same category of error recurring despite added principles
- the user still reading every line of deliverables

## Relationship to other session-end skills

Run order at session end:
1. **session-capture** → project-level knowledge
2. **praxis** → methodology-level knowledge
3. **gap-check** → review quality check

Gap-check runs last because it depends on the user having reviewed the deliverables, which may happen during or after the session-capture conversation.
