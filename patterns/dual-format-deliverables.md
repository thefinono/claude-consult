# Dual-Format Deliverables: Markdown Source + Word Export

## Context
Enterprise client engagements where stakeholders expect Word documents for circulation, review, and commenting, but you need version-controllable source files.

## Approach
Maintain markdown as the single source of truth. Auto-generate Word documents using python-docx. The conversion handles headers, tables, code blocks, bold/italic, and bullet lists with professional styling (Calibri 11pt, Light Grid Accent 1 tables, Consolas for code).

## Why It Works
Markdown is editable, diffable, and version-controllable. Word is what enterprise stakeholders expect and what they'll share in email, Teams, and Slack. Maintaining both manually creates drift. Generating Word from markdown gives you both without the drift risk.

## Variations
- **Recurring deliverables:** Build the converter once, re-run on each document update.
- **One-off reports:** Inline python-docx script, run and discard.
- **Multi-audience docs:** Same markdown source, different Word templates per audience (client-facing vs internal).

## Source
Recurrent need across multiple engagements — a markdown-to-Word converter was rebuilt twice in one session for analytical write-ups and planning documents before being captured as a reusable skill.
