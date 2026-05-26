# Markdown-to-Word Converter for Client Deliverables

**Status:** Spec only (not yet encoded as SKILL.md)
**Times used:** 2
**Graduate when:** Used 3+ times

## What It Does
Converts a markdown document into a professionally formatted Word document (.docx) suitable for enterprise stakeholder circulation.

## Inputs
- Markdown file (.md)
- Optional: Word template for branding, font preferences

## Outputs
- Formatted .docx with proper heading hierarchy, tables, code blocks, bullet lists, bold/italic

## Key Logic
1. Parse markdown by section (split on ## headers)
2. Convert elements: headers → Word heading styles, | tables → Word tables with Light Grid Accent 1, ``` code → Consolas monospace, **bold** and *italic* → Word runs, - bullets → Word list paragraphs
3. Apply base styling: Calibri 11pt, proper paragraph spacing
4. Handle title/subtitle with italic gray text for metadata lines

## Design Decisions
- Markdown is always the source of truth; Word is generated, never edited
- Re-run converter on each markdown update rather than maintaining Word separately
- Use python-docx library (no Word installation required)

## Source
Built twice in one session for two different analytical write-ups before being captured as a reusable converter.
