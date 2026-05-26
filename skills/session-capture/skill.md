---
name: session-capture
description: Capture learnings, insights, and judgment calls from the current session into persistent memory. Run at session end, at natural breakpoints, or when asked to save or remember what we've learned.
---

Base directory for this skill: ~/.claude/skills/session-capture

# Session Capture

Capture learnings, insights, and judgment calls from the current session into persistent memory. Run this proactively at natural breakpoints or when the user asks to save what we've learned.

---

## When to Trigger

- End of a significant work session
- User says "save this", "remember this", "capture learnings"
- After completing a major milestone (e.g. pipeline built, data delivered, app launched)
- After a hard-won technical breakthrough (multiple failed attempts before success)
- After user corrections or validated approaches
- Proactively when context window is getting long and valuable insights might compress away

---

## What to Capture (Lean Toward More, Not Less)

### Always Capture

**1. Technical Breakthroughs**
When something took multiple attempts to solve. Save the winning approach AND what failed and why.
- Prompt patterns that finally got the AI to produce usable output
- Workflow sequencing that turned out to matter (e.g. doing X before Y)
- Tool-specific quirks and undocumented behavior
- What parallelizes well across sessions vs what needs sequential focus

**2. User Corrections & Validated Approaches**
- Anything the user pushed back on → save as feedback memory
- Anything the user explicitly approved or praised → save as validated approach
- Preferences about workflow, tooling, communication style

**3. Business & Strategic Insights**
These are high-value and often lost between sessions:
- What the client actually cares about (not what the spec says)
- Stakeholder dynamics and decision-making patterns
- Pricing discussions, budget constraints, negotiation anchors
- Go/no-go criteria and success thresholds
- Competitive landscape observations
- What "done" looks like for this client

**4. AI Value Creation Patterns**
How AI created value in this specific work context:
- What was previously too time-consuming to do at all
- What manual process got faster, and the scale of the speed-up
- Where the AI approach beat the traditional one (templates, hiring, vendor tools)
- Time comparisons (e.g. "drafted 20 personalized stakeholder updates in 30 min vs 4 hours by hand")
- Coverage/quality metrics that prove the approach works
- Integration patterns that organizations actually adopt (recurring docs, scheduled briefings, structured handoffs)

**5. Data Quality Patterns**
What went wrong with data and how it was fixed:
- Common junk patterns per data source
- Normalization maps that will be reused
- Validation approaches that caught real problems
- Schema evolution decisions and why

**6. Tool & Platform Learnings**
- What works and doesn't work with specific tools (the AI assistants, document generators, transcription tools, browser automation, etc. that you actually use)
- Configuration that matters (model choice, context handling, prompt patterns)
- Gotchas that aren't in the docs

### Capture If Present

**7. Relationship & Communication Context**
- How the client prefers to receive information
- Internal politics that affect delivery
- Who are allies, who are blockers
- What language/framing resonates

**8. Reusable Artifacts**
- Prompt templates that worked well (briefing structures, summary formats, review checklists)
- Document structures worth reusing
- Workflow architectures

---

## How to Capture

### Step 1: Scan the Session
Review the conversation for:
- Moments where multiple approaches were tried (technical breakthroughs)
- User corrections or explicit approval
- Business context shared by the user
- Data problems discovered and solved
- Tool-specific learnings
- Strategic insights about the client/project

### Step 2: Categorize Each Learning
Map each to a memory type:
- `feedback` — user corrections, validated approaches, workflow preferences
- `reference` — technical techniques, tool configurations, API patterns
- `project` — business context, stakeholder dynamics, timelines, decisions
- `user` — user profile updates, skills, preferences

### Step 3: Write Memories
For each learning, write a memory file with:
- Clear, searchable `name` and `description` in frontmatter
- For feedback: rule → **Why:** → **How to apply:**
- For reference: technique → context → exact steps to reproduce
- For project: fact/decision → **Why:** → **How to apply:**

### Step 4: Check for Updates
Before writing new memories, check existing ones:
- Would this update an existing memory? → Edit it instead
- Does this contradict an existing memory? → Update or replace
- Is this already captured? → Skip

### Step 5: Update MEMORY.md Index
Add new entries, organized by type. Keep it scannable.

---

## Business Insight Prompts

When scanning for business insights, ask yourself:

- **What did we learn about what the client values?** Not features — outcomes. "The client cares about quarterly close timing because that's when board materials get reviewed, not because of accounting cycles."

- **What pricing/commercial signal emerged?** "Buyer anchored at $50K initial, signaled room to $80K if scope expanded" or "Stakeholder said 60% coverage is the viability threshold below which they won't roll it out."

- **What would help sell this to another client?** The pattern, not the specific — "Front-loading the executive summary with three quantified findings raised reply rates substantially in this and similar reviews."

- **What surprised us about the data?** Concrete, repeatable observations like "Most exception cases came from one specific source system" or "The breakdown that mattered was by region, not by team."

- **What's the before/after story?** The transformation narrative is the most valuable business memory. "Before: monthly status update took two days and was rarely read. After: 30-minute synthesis from auto-pulled metrics, with three specific decisions requested."

---

## AI Value Creation Prompts

When scanning for AI value patterns:

- **What was impossible before AI?** "Synthesizing 60 customer interview transcripts into themes across a single weekend — the prior process required hiring an analyst for two weeks."

- **What's the scale advantage?** "Reviewed 400 contracts in one day for the three clauses the deal team cared about. Manual review would have taken a month."

- **What's the accuracy story?** "AI surfaced the correct candidate clause in 95% of contracts. The 5% miss rate was a known edge case (scanned PDFs)."

- **What's the time/cost story?** "Drafting + iterating one stakeholder brief: 30 minutes with AI vs 4 hours by hand. Quality was comparable after one revision."

- **What was unlocked?** "Cross-referencing data the team already had against an external knowledge base — previously not done because the lookup cost was too high."

---

## Example Output

After running this skill on a session, you might produce:

```
New memories saved:
  reference_briefing_structure.md — opener-finding-decision pattern works for exec audiences
  reference_interview_summarization.md — quote-then-theme prompt beats theme-only summary
  feedback_review_cadence.md — user prefers weekly digests over real-time pings
  project_q3_planning_context.md — three constraints driving the scoping decisions

Updated memories:
  project_current_engagement.md — updated stakeholder map and timeline

MEMORY.md index updated.
```

---

## Anti-Patterns (What NOT to Capture)

- File paths or folder structures (read the filesystem instead)
- Exact counts or stats that will change (read the source data)
- Code snippets (they're in the scripts)
- Conversation flow or "what we discussed" summaries
- Anything already in CLAUDE.md
- Temporary task state ("need to follow up with three vendors")
