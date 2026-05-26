# SEO/GEO practice — architecture

A skill plugin under claude-consult that delivers marketing-manager-level functional knowledge for SEO and GEO (Generative Engine Optimization) to small business owners who can't afford to hire one — and serves as practitioner tooling for marketers and fractional CMOs working with SMB clients.

Status: v1 architecture (revised from v0.1 based on 2026 industry-validation research — Whitespark Local Search Ranking Factors, Google Search Central, Search Engine Land GEO guide, First Page Sage B2B SEO, Shopify SEO, Chowly Restaurant SEO, BrightLocal Consumer Survey).

---

## What this practice covers

Seven skills (v1), addressing the SMB SEO/GEO discipline end to end. The premise: **workflow automation does not pencil for SMBs** (volumes are too low to displace an FTE). What does pencil is giving SMB owners the corporate-best-practice functional knowledge they cannot get from hiring. This practice delivers that for SEO/GEO specifically. Future practices (sales, finance, content marketing, etc.) will follow the same pattern.

### Dual-use by design

The same skills serve two audiences with the same artifacts:

| Mode | Who | How they use |
|---|---|---|
| **Practitioner-led** | Fractional CMO, marketing consultant, agency | Triggers skills during a client engagement; outputs become client deliverables. |
| **Self-serve** | SMB owner directly | Installs the plugin, triggers skills on own site, gets outputs directly. |

Both modes consume the same skill spec. The skill doesn't need to know which mode is invoking it.

---

## Audience and v1 business-type targeting

Modal target: SMB owner who needs marketing-manager-level knowledge but cannot afford a fractional CMO (the fractional-CXO market is a tech-sector artifact that does not exist at SMB scale).

| Type | Examples | v1 plugin priority |
|---|---|---|
| **Local Service** | Plumber, dentist, hair salon, accountant, in-person tutor, gym | YES — modal SMB; ~75% of SMB population |
| **Online Service / Coaching / Education** | Online tutor, coach, consultant, course creator | YES — growing segment |
| **Brick-and-Mortar Retail / Hospitality** | Restaurant, café, boutique, B&B | LIGHT — covered by core skills but no menu/room schema until v2 |
| **E-commerce DTC** | Small Shopify store | DEFER to v2 (product schema, merchant feeds) |
| **B2B Professional Services** | Boutique law firm, B2B consultancy | DEFER to v2 (buyer-journey content mapping) |

---

## The 7 skills (v1)

Each skill's full spec lives in `practices/marketing/seo-geo/skills/<name>/SKILL.md`.

| # | Skill | What it does (one line) |
|---|---|---|
| 1 | `smb-schema-fix` | Inspects JSON-LD on a site, diagnoses what's wrong, outputs corrected JSON-LD ready to paste into CMS code injection |
| 2 | `smb-seo-geo-audit` | Comprehensive site audit — technical SEO, GEO baseline, off-site citations, measurement infrastructure, GBP (if local) — with P0/P1/P2 prioritized findings |
| 3 | `smb-measurement-setup` | Walks owner through GA4 + Search Console setup, sitemap submission, baseline metrics snapshot, monthly review prompt library |
| 4 | `smb-keyword-clusters` | Pillar + cluster keyword strategy with local-vs-global branching, intent classification, GSC integration when available *(to be written)* |
| 5 | `smb-content-engine` | Blog drafts in owner's voice with explicit GEO-friendly structure: answer-first, atomic/numbered/comparison-table elements, primary-research prompts, internal linking *(to be written)* |
| 6 | `smb-ai-onboarding` | 30-day starter plan for an SMB owner new to AI-augmented marketing; picks one workflow to own first, builds initial prompt library *(to be written)* |
| 7 | `smb-first-session` | Orchestrates the other 6 in a 60-90 min strategy session — practitioner-led or self-led *(to be written, last)* |

### Skill order rationale

`smb-schema-fix` and `smb-seo-geo-audit` are the headline skills — most demoable, most differentiated. `smb-measurement-setup` ships third because GSC + GA4 data materially improves the audit and keyword-clusters skills on subsequent runs. The orchestrator skill ships last.

---

## v1.5 candidate skills (designed, not committed)

These address real structural gaps in v1 but are deferred for honest scope reasons.

### `smb-local-presence` (highest-impact deferred item)

GBP audit (NAP, categories, photos, posts, reviews, Q&A), GBP setup for unclaimed profiles, NAP consistency check across top 20 directories, local citation finder + outreach drafts, review-velocity playbook.

**Why this matters:** Per Whitespark 2026, GBP signals are 25-32% of local ranking weight (up 15% from 2023). Reviews are 16-20%. Citations roughly 10%. Collectively, the majority of local ranking influence. The modal SMB needs this. The reason for deferral is scope discipline, not lack of importance — v1 must ship before we add it. Plugin output explicitly flags GBP and local citations as things the owner needs to address even before this skill ships, and points them to resources.

### `smb-authority-citations` (off-site axis)

Vertical authority site identification, podcast guest-spot outreach drafts, third-party review aggregator listings (Trustpilot, vertical aggregators), guest-post placement, brand mention monitoring setup.

**Why this matters:** 2026 GEO research shows AI engines lean heavily on aggregator reviews and authority-site citations when answering "is X legit / who should I hire for Y." This is the most concrete off-site lever. Off-site axis is currently zero in v1.

---

## Out of scope (v2 or never)

- Paid ads / PPC management
- Social media management
- Email marketing automation
- E-commerce-specific schema (product, merchant feeds) — v2
- Restaurant menu schema (MenuSection) — v2 or its own variant
- B2B buyer-journey content mapping — v2
- Direct CMS integration (writing to Squarespace, Wix, etc.) — v2 (security + maintenance trade-off)
- **`llms.txt` recommendation — deliberate exclusion.** Per 2026 industry research, <0.1% of AI crawler requests touch llms.txt, and no major AI company has publicly committed to acting on it. Most SMB-SEO checklists push it; this one explicitly skips it. Differentiation through restraint.
- Multi-site / agency dashboard features
- Reporting/dashboards beyond per-skill output

**Why v1 stays focused on owner-led action, not automation:** Direct CMS writes are a trust and security risk for SMB owners installing a plugin. Ready-to-paste outputs are safer, easier to ship, and respect the owner's editorial control. v2 may revisit selectively.

---

## Connectors required

**Built-in / no auth:**
- Web fetch
- Web search

**OAuth — user provides their own subscription:**
- Semrush OR Ahrefs (one or the other; user choice)
- Browser automation (e.g. Claude in Chrome extension)
- Google Search Console (significantly improves audit + keyword-clusters when connected)
- Google Analytics 4
- PageSpeed Insights API (free; for Core Web Vitals)

**Optional / future:**
- Google Business Profile API (v1.5 with `smb-local-presence`)
- Microsoft Bing Webmaster Tools (mentioned in `smb-measurement-setup` as bonus)
- CMS-specific writers (Squarespace, Wix, WordPress) — deferred to v2

**No connectors required to start using the plugin.** Skills should degrade gracefully when optional connectors are absent — e.g., `smb-keyword-clusters` works without Semrush but produces qualitative estimates rather than hard numbers, with a clear "connect Semrush for real volumes" prompt. The audit skill works without GSC but is materially stronger with it connected.

**Important:** the `fail-fast-at-boot` pattern (in claude-consult/patterns/) governs how every skill in this practice handles missing connectors. No silent degradation; refuse at boot if a load-bearing path is unavailable.

---

## Shared context across skills

Skills should share context where it's expensive to recompute:

- An `smb-seo-geo-audit` run should produce structured data that `smb-schema-fix` and `smb-keyword-clusters` can consume without re-fetching the site.
- The "business context" inputs (name, audience, voice, differentiators) should be capturable ONCE per site and reused by all skills.
- The audit's output should reference which other skills can fix each finding.

**Implementation pattern:** Each skill writes its output to a known location (e.g., `~/smb-kit/<site-domain>/`). Subsequent skills check for prior outputs and use them as context. The first skill a user runs becomes their "business profile" anchor.

**MVP can skip this:** v1 can have each skill self-contained (user provides inputs each time). v1.5 adds shared context.

---

## Maintenance model

A plugin is not a blog post — methodology depends on moving targets:

- Schema standards (FAQPage was deprecated by Google in May 2026 — caught via verification gate; spec change between sessions is rare but possible)
- AI crawler taxonomy (vendors regularly add/split bots — Anthropic split ClaudeBot in 2025, OpenAI similarly)
- Connector APIs (Semrush, Ahrefs, GSC, GA4 version their APIs)
- AI engine behavior (ChatGPT, Perplexity, Gemini change citation patterns)
- CMS specifics (Squarespace, Wix occasionally change their dashboards)

**Proposed maintenance cadence:**
- **Quarterly:** Verify schema recommendations against current Schema.org + Google docs. Verify AI crawler taxonomy against current vendor docs. Re-test connector calls. Spot-check audit on 3 known sites.
- **As-needed:** When a major AI engine launches or changes (e.g., new Gemini version), re-test the GEO baseline methodology.
- **Annually:** Methodology review — what holds, what doesn't, what to add.

---

## Architectural principles

The patterns established in this practice are intended to generalize to future claude-consult practices (other Marketing sub-disciplines, then Sales, Finance, HR, Ops).

1. **Dual-use by default.** Each skill must work for both the practitioner and the self-serve owner without code branches. The owner's experience should not feel like "the agency version with features missing."
2. **Propose-and-paste, not direct write.** Skills produce ready-to-paste outputs the user applies in their CMS dashboard. No CMS write access. Lower security risk, higher trust, easier maintenance.
3. **Skill orchestration via outputs, not RPCs.** A skill that needs another skill's output reads it from disk. No tight coupling. Each skill is independently testable.
4. **Live DOM, not markdown extraction.** For any skill that inspects a live site, use browser automation to read the rendered DOM. Markdown extraction misses JavaScript-injected content (e.g., CMS-auto-injected JSON-LD).
5. **Verification gates against current docs.** Before generating any recommendation that depends on a standard (Schema.org, Google Search Central, AI vendor crawler docs), fetch the current source-of-truth. Standards change.
6. **Fail-fast at boot, never silently degrade.** See `claude-consult/patterns/fail-fast-at-boot.md`. Skills that depend on tooling that may not be available must check at boot and refuse cleanly if missing — not degrade quietly to lower-fidelity output.
7. **Honest confidence labeling.** Distinguish *measured* findings from *inferred* findings in every output. Don't present inferences as measurements.
8. **Single consolidated output per skill run.** Skills produce one markdown doc, not a folder of sub-files. Easier to read, share, and re-run.
