---
name: problem-solving
description: Structured problem-solving for new engagements or scope changes. Facilitates Stages 1-4 (define, disaggregate, prioritize, plan) using McKinsey seven-step framework. Say 'new engagement', 'let's scope this', or 'problem-solving' to invoke.
---

# problem-solving

## Purpose

Facilitate structured problem-solving at the start of a new project or when scope changes significantly. This is the Think layer of claude-consult — producing the plan that the work executes against and that review evaluates.

Inspired by the McKinsey seven-step problem-solving process. Steps 1-4 (define, disaggregate, prioritize, plan) are done here. Steps 5-7 (analyze, synthesize, communicate) happen during the work itself and at review time.

## When to run

- **New engagement kickoff.** the user says "new engagement," "let's scope this," "problem-solving," or brings in raw client materials (transcripts, scope docs) for a project that doesn't have a plan yet.
- **Significant scope change.** The client's question has shifted, a major assumption was invalidated, or the north star changed.
- **Mid-engagement reset.** Something isn't working and we need to rethink the approach.

Do NOT run this for: routine build work, deliverable review, session-end captures, or tasks that already have a workstream plan.

## How this works

This is a facilitated conversation, not an automated pipeline. Claude follows the stage protocol but adapts to what the user needs. Some stages take 30 seconds ("the problem is obvious, let's skip to decomposition"). Some take an hour ("we need to rethink what success means here"). Claude reads the room.

Subagents handle heavy lifting. Evaluator agents check stage artifacts. But the core loop is dialogue between the user and Claude.

## Stage protocol

### Stage 1: Problem statement

**Goal:** Fill the Problem Statement Worksheet completely and correctly.

**If raw materials are available** (transcripts, scope docs, data samples):
1. Spawn the **intake** subagent with the materials
2. Receive the draft worksheet
3. Walk through it with the user field by field, starting with:
   - "Before we fill this in — is the basic question the right question, or is there a better version of this problem?"
   - Then each field: perspective, stakeholders, success criteria, scope, constraints, sources

**If no raw materials** (conversation-based kickoff):
1. Start with: "What's the basic question this engagement needs to answer?"
2. Probe each field through dialogue
3. Build the worksheet as you go

**Probing questions per field:**
- Basic question: "What decision does the client need to make? What changes for them if they have the answer?"
- Perspective: "What prompted this? What have they already tried?"
- Stakeholders: "Who's the decision-maker? Who else cares? Are any stakeholders misaligned?"
- Success criteria: "What would make this a win? What would they show their boss?"
- Scope: "What approaches are on the table? What kind of output do they expect?"
- Constraints: "What's off limits? Time, budget, data, political constraints?"
- Sources: "What data exists? What systems? What people should we talk to?"

**When the user answers quickly**, move on. Don't belabor fields that are obvious. When she pauses or pushes back, dig deeper.

**Artifact:** Completed Problem Statement Worksheet (all seven fields).

**Evaluator check:**
- Spawn **EM agent** on the completed worksheet: Does the basic question decompose? Are success criteria testable? Contradictions between fields?
- Spawn **Partner agent** on the completed worksheet: Is this the right question? Reframe opportunity? Would the client's boss care?

**Gate:** Every field filled. EM and Partner pass. the user confirms. Move to Stage 2.

---

### Stage 2: Disaggregate

**Goal:** Build a logic tree that decomposes the basic question into answerable sub-questions.

1. Propose an initial decomposition: "Here's how I'd break this down — [branches]. Does this cover it?"
2. Try multiple cuts if the first doesn't land. Common decomposition patterns:
   - By value chain stage (source → process → deliver → measure)
   - By stakeholder (what does stakeholder A need vs. B vs. C?)
   - By hypothesis ("if X is true, we need to check Y and Z")
   - By data availability (what can we answer now vs. what requires new data?)
3. Iterate with the user until the branches feel right

**Then stress-test:**
- Spawn the **pressure-test** subagent with the logic tree + worksheet
- Review the pressure-test skill's findings with the user
- Revise the tree if the pressure-test skill found real gaps

**Artifact:** Logic tree. Each branch is a question with a clear scope.

**Evaluator check:**
- Spawn **EM agent**: Composition test — do branches compose to answer the basic question?
- Spawn **Partner agent**: Ambition check — solving a big enough version of the problem?

**Gate:** Composition test passes. Pressure-test found no fatal gaps. the user confirms. Move to Stage 3.

---

### Stage 3: Prioritize

**Goal:** Rank the branches by impact and feasibility. Identify where to start.

1. Assess each branch on two axes:
   - Impact on the decision: if we only answered this one branch, how much of the basic question does it address?
   - Feasibility: can we do this with what we have?

**If data is available:**
- Spawn the **data-scout** subagent to do quick feasibility per branch
- Use the scout report to inform prioritization

**If no data yet:**
- Prioritize based on dialogue: "Which of these is most critical to answer first? Which is a prerequisite for others?"

2. Identify dependencies: "Branch B can't start until Branch A delivers X"
3. Define quality gates per workstream: "What number would make us stop and rethink?"
4. Explicitly park deprioritized branches with reasons — they're not forgotten, they're sequenced

**Artifact:** Prioritized workstream list with rationale, dependencies, and quality gates.

**Evaluator check:**
- Spawn **EM agent**: Priorities justified by success criteria? Prerequisites acknowledged? Quality gates specific?
- Spawn **Partner agent**: Priority order defensible to client? Starting with something that builds early trust?

**Gate:** Priority order agreed. Quality gates are specific numbers. the user confirms. Move to Stage 4.

---

### Stage 4: Plan

**Goal:** Produce a workstream plan for each prioritized workstream that's specific enough to execute without inferring intent.

**Auto-load methodology-reference skill** — the detailed execution instructions become relevant here.

For each prioritized workstream:
1. Define the approach: "Here's how I'd tackle this — [method]"
2. Specify the output schema: what fields, what types, what the final artifact looks like
3. Set success/failure criteria: what number means this worked, what means it didn't
4. Define ambiguity handling: when the data is unclear, what do we do?
5. Design the insight layer: "If the stakeholder had 30 minutes with this output, what decision would they make?"

**If data is available:**
- Spawn the **data-archaeologist** subagent for deep profiling
- Incorporate findings: population sizes, fill rates, grouping units, quality issues
- Surface decisions the team didn't know they needed to make

6. **Define the QA rubric:** This is non-negotiable. For each workstream, force this conversation:
   - "What does a correct output look like? Write the rubric a reviewer would use." If you can't write the rubric, you don't understand the problem yet.
   - "Who builds ground truth? Human annotators (domain expert) or LLM-as-judge?" The answer depends on stakes and domain complexity. Human for anything going to a system of record or client-facing. LLM-as-judge for internal iteration.
   - "What are the eval layers?" Unit eval per LLM component (deterministic checks, input/output contracts). Integration eval for end-to-end output (golden dataset, regression baselines).
   - "What's the first golden dataset?" Even 10-20 expert-validated examples. Identify who validates and when.

**The "execute without inferring intent" test:** Read each workstream plan and ask — if someone who wasn't in this conversation tried to execute this, would they know what to do at every step? If not, add specificity.

**Artifact:** Workstream plans. One per prioritized workstream. Each must include the QA rubric and ground truth strategy — not as an afterthought, as a required section.

**Evaluator check:**
- Spawn **EM agent**: Plans compose to answer the basic question? Insight layer designed?
- Spawn **Analyst agent**: Denominators defined? Schemas typed? Quality gates measurable? Data issues acknowledged?
- Spawn **Partner agent**: Overengineering? Should we prototype one vertical slice first?

**Gate:** All plans pass the "execute without inferring intent" test. All evaluators pass. the user confirms.

---

## After Stage 4

The problem-solving skill is done. Hand off to Build mode:
- Workstream plans guide execution
- The methodology reference provides detailed build instructions
- review runs the evaluator team on build output and deliverables
- gap-check captures gaps at session end

Save the Problem Statement Worksheet and workstream plans to the project directory. These are the engagement's reference documents — everything traces back to them.

## Behavioral notes

- **Match the user's pace.** If she's moving fast, move fast. If she wants to dwell on a field, dwell.
- **Don't be precious about the template.** The worksheet is a tool, not a form. If a field doesn't apply, skip it. If a field needs to be split into three sub-fields, split it.
- **Challenge, don't just capture.** If the user says the problem is X but the materials suggest Y, say so. This is the Partner lens applied in real time.
- **Surface what you don't know.** "I don't have enough information to assess this — what would help?" is always better than filling in a guess.
- **The reframe question is not optional.** Always ask whether the basic question is the right question before building on it. This is the highest-leverage moment in the entire engagement.

## Relationship to other components

```
problem-solving skill (this)  →  produces plans
  ├── intake subagent          →  absorbs raw materials
  ├── pressure-test skill       →  stress-tests decomposition
  ├── data-scout subagent      →  quick feasibility
  ├── data-archaeologist       →  deep data profiling
  ├── EM evaluator             →  checks composition at every stage
  ├── Partner evaluator        →  checks ambition + framing at every stage
  └── Analyst evaluator        →  checks data foundation at Stage 4

methodology-reference skill   →  guides Build mode execution
self-eval skill               →  runs Review mode on deliverables
gap-check skill       →  captures gaps across all modes
```
