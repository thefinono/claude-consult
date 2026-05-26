---
name: make-slides
description: Generate a PowerPoint deck from content using McKinsey-style slide design. Use when asked to make a deck, presentation, or pptx from existing content.
---

# Make Slides

You build PowerPoint decks using python-pptx. Every slide follows consulting-grade design principles.

## Slide Architecture

Every slide has three zones:

1. **Action title** (top) — A complete declarative sentence stating the slide's takeaway. Not a topic label. "ND Series enrichment filled 6,186 empty attributes from two manufacturer PDFs" — not "ND Series Results." The reader skimming only titles should get the full argument of the deck.

2. **Body** (middle) — One exhibit (table, chart, or bullet group) that proves the action title. One message per slide. If you need two points, use two slides.

3. **Source line** (bottom, small, gray) — Where the data came from. Always present on data slides. Format: `Source: [origin], [date]`

## The "So What" Test

Applied to every slide before writing it: "If the reader sees only this slide, do they know what matters?" If the answer is no, the action title is wrong or the slide shouldn't exist.

## Deck Structure: Situation → Complication → Resolution

1. **Situation** (1–2 slides): Shared context. What was received, what was agreed.
2. **Complication** (1–3 slides): What we found — the tension, the data, the gaps.
3. **Resolution** (remaining slides): What to do next. Specific, actionable.

Use a section divider slide (single centered phrase, no body) between major sections if the deck exceeds 8 slides.

## Typography and Formatting Rules

- **One font family.** Calibri or Arial. No mixing.
- **Three sizes only:** Slide title (24pt), body text (16pt), source/footnote (10pt).
- Action titles: bold, dark color (black or near-black).
- Body text: regular weight, dark gray.
- Source lines: regular weight, medium gray, 10pt.
- **No decorative elements.** No gradients, shadows, clip art, logos, or colored backgrounds.
- **White background only.**
- **White space is structural.** Don't fill every inch. Let the content breathe.
- **No orphan words.** If a line wraps and leaves a single word dangling on the next line, reword the sentence to eliminate it. Tighten the phrasing or redistribute words so every line carries its weight.

## Tables

- Used when the reader needs exact values, not trends.
- Header row: bold, light gray background (#F2F2F2).
- Highlight the row or column that matters most (bold or subtle background).
- Round aggressively — no false precision.
- Left-align text columns, right-align number columns, center short categorical columns.
- No heavy borders. Light gray gridlines (#D9D9D9) or none.

## Bullet Slides

- Max 3–5 bullets per slide.
- Each bullet is a complete thought.
- **Bold the lead phrase** of each bullet; supporting detail follows unbolded on the same line.
- No sub-bullets. If you need hierarchy, use two slides.

## Implementation

Use python-pptx. Build every slide programmatically:

```python
from pptx import Presentation
from pptx.util import Inches, Pt, Emu
from pptx.dml.color import RGBColor
from pptx.enum.text import PP_ALIGN, MSO_ANCHOR
```

### Slide layout constants

```python
SLIDE_WIDTH = Inches(13.333)  # Widescreen 16:9
SLIDE_HEIGHT = Inches(7.5)

# Zones (left margin, top, width, height)
TITLE_BOX = (Inches(0.75), Inches(0.4), Inches(11.8), Inches(1.0))
BODY_BOX = (Inches(0.75), Inches(1.5), Inches(11.8), Inches(5.0))
SOURCE_BOX = (Inches(0.75), Inches(6.8), Inches(11.8), Inches(0.5))

# Colors
BLACK = RGBColor(0x1A, 0x1A, 0x1A)
DARK_GRAY = RGBColor(0x4A, 0x4A, 0x4A)
MED_GRAY = RGBColor(0x8C, 0x8C, 0x8C)
LIGHT_GRAY = RGBColor(0xF2, 0xF2, 0xF2)
GRID_GRAY = RGBColor(0xD9, 0xD9, 0xD9)
WHITE = RGBColor(0xFF, 0xFF, 0xFF)

# Fonts
FONT_FAMILY = "Calibri"
TITLE_SIZE = Pt(24)
BODY_SIZE = Pt(16)
SOURCE_SIZE = Pt(10)
```

### Helper functions to build

Create these helpers and reuse across all slides:

- `add_action_title(slide, text)` — Adds title textbox at TITLE_BOX position, bold, BLACK, 24pt.
- `add_source_line(slide, text)` — Adds source textbox at SOURCE_BOX position, MED_GRAY, 10pt.
- `add_body_text(slide, text)` — Adds body textbox at BODY_BOX position, DARK_GRAY, 16pt.
- `add_bullets(slide, items)` — Each item is `(bold_phrase, detail)`. Bold phrase in bold DARK_GRAY, detail in regular DARK_GRAY, same paragraph.
- `add_table(slide, headers, rows, highlight_rows=None)` — Table at BODY_BOX position. Header row with LIGHT_GRAY fill. Highlight rows get subtle fill. Light grid lines.
- `add_section_divider(slide, text)` — Centered text, 28pt, DARK_GRAY, vertically and horizontally centered.

### Process

1. Read the source content (markdown, doc, or conversation context).
2. Decompose into slide-level messages. Each slide = one assertion.
3. Write action titles first — read them in sequence to check if the deck's argument holds.
4. Build exhibits that prove each title.
5. Add source lines.
6. Save to the requested path.

### Quality check before saving

- Read all action titles in sequence. Does the argument flow?
- Does every exhibit prove its title and nothing else?
- Is any slide trying to say two things? Split it.
- Are tables/numbers rounded appropriately?
- Is every slide legible at a glance — no text walls, no tiny fonts?

## What NOT to do

- No topic-label titles ("Overview", "Results", "Next Steps").
- No sub-bullets or nested lists.
- No multiple font sizes within a single text block.
- No color for decoration — only for emphasis on one data point.
- No slides with more than one exhibit.
- No slides that require the previous slide to make sense.
- No logos, footers, or slide numbers unless explicitly requested.
