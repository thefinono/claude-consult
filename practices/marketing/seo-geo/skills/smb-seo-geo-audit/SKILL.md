---
name: smb-seo-geo-audit
description: Comprehensive SEO + GEO (AI-engine visibility) audit for a small business website. Inspects technical SEO health, AI-engine citation, off-site presence, measurement infrastructure, and competitive position. Produces a prioritized findings document with P0/P1/P2 severity, who-executes, and expected impact. Use when an SMB owner or fractional CMO wants to know what's wrong with their site, why no one's finding them, or whether the site is set up for AI search.
tags: [smb, seo, geo, audit, ai-engines, measurement]
status: draft
source: distilled from SMB SEO/GEO engagement work + 2026 industry-validation research
---

# Skill: smb-seo-geo-audit

The comprehensive audit skill. Inspects a small business website for technical SEO health, GEO (AI-engine) visibility, off-site presence (citations, reviews, backlinks), measurement infrastructure (GSC/GA4), and competitive position. Produces a prioritized findings doc with P0/P1/P2 severity levels and concrete fixes annotated to who-executes and expected impact.

**Why this skill exists.** A modern SMB audit is no longer "is the site healthy for Google" — it's also **"does the AI search ecosystem know this business exists, and can it be cited reliably?"** Most small businesses have decent enough on-page signals AND zero AI-engine visibility, and the owner has no way to see that gap. The live AI-engine citation check (the GEO baseline) is what makes the gap visible — and visceral. That visceral moment is what shifts an SMB owner from treating AI as a chat toy to seeing what's at stake for their business.

This skill compresses what would be a 1-2 week senior-marketer discovery engagement into a sub-15-minute self-serve run. It depends on `smb-schema-fix` (called as a sub-step for the schema portion) and recommends `smb-measurement-setup` when it detects no GA4 or Search Console.

---

## What it does in one paragraph

Given a small business website URL plus 2-3 named competitors and 3-5 target search queries, the skill: (0) **runs a preflight check** to confirm at least one AI-engine citation path is reachable and refuses to proceed if none is available; (1) fetches the homepage, sitemap.xml, robots.txt, and all sitemap-listed pages (or top N if large); (2) inspects each page via Chrome MCP for visual rendering, broken interactive elements, and JSON-LD schema; (3) calls `smb-schema-fix` for deep schema analysis; (4) audits robots.txt with explicit AI-crawler taxonomy (training-only vs retrieval bots — Claude-Web vs ClaudeBot, OAI-SearchBot vs GPTBot, PerplexityBot, plus non-compliant Bytespider); (5) checks Core Web Vitals via PageSpeed Insights; (6) analyzes internal linking (orphan pages, anchor patterns); (7) runs an indexing audit on sample pages via `site:` query; (8) detects measurement infrastructure (GA4 + Search Console) and reads GSC data when connected; (9) detects whether the business is local and, if so, audits Google Business Profile and runs a NAP-consistency check across top directories; (10) captures an off-site citation profile snapshot; (11) queries live AI engines for the target queries to establish a GEO baseline; (12) runs competitive SERP scans via web search; (13) performs a brand-entity disambiguation check; (14) optionally pulls Semrush or Ahrefs domain data; (15) outputs **ONE consolidated markdown audit document with eleven sections**: executive summary, confidence levels, P0/P1/P2 findings, GEO baseline, competitive landscape, what's working, what's still unverified, prioritized action plan (Quick Wins vs Strategic Investments), and flagged adjacent business observations.

---

## Trigger phrases

The skill should activate on natural-language requests like:

- "audit my site for SEO and GEO"
- "run an SEO audit on [my url]"
- "is my site set up right for AI search"
- "why am I not ranking" / "why isn't anyone finding me"
- "give me a site health check"
- "what's wrong with my SEO"
- consultant-led: "audit [client]'s site before our next session"

Also activates when an SMB owner expresses general frustration about visibility without naming a specific symptom — the audit is the right diagnostic entry point.

---

## Input

**Required:**
- Site URL (homepage)

**Strongly recommended (skill will ask if absent):**
- 3-5 target search queries (what the owner wants to rank for — informational AND commercial intent both useful)
- 2-3 named competitors (URLs or business names — used for competitive SERP analysis)
- Business type and target market (US/UK/global; English-only or multilingual)

**Optional (improves output quality):**
- CMS platform — auto-detected when possible
- Existing Google Search Console access (unlocks real ranking data)
- Semrush or Ahrefs subscription (auto-detected if connected)
- Business positioning context (price point, differentiator) — helps the skill interpret findings strategically

If strongly-recommended fields are absent, the skill asks for them conversationally. The audit is much weaker without target queries and competitors — the skill should refuse to proceed without them rather than producing a generic output.

---

## Preflight check (runs before any audit work)

**Purpose:** detect tooling constraints at skill boot, not at section time. Refuse or proceed before investing 10+ minutes of sitemap parsing and competitive SERP work that would only fail at the GEO step.

**Preflight runs the following checks before any other audit work:**

1. **Chrome MCP availability.** Is the Claude in Chrome extension connected? If yes, Path A (live navigation to Perplexity + Google AI Overview, plus optionally ChatGPT/Claude/Gemini if the user is already logged in) is available.

2. **AI-engine API key check.** Are any of the following present in the user's environment: Perplexity Sonar API key, OpenAI API key with web browsing entitlement, Anthropic API key with web search tool entitlement? If yes, Path B (programmatic AI-engine queries) is available.

3. **Manual paste availability.** Ask the user whether they're willing to run queries in 3-5 AI engines manually and paste responses back. If yes, Path C is available.

4. **Refusal gate.** If NONE of Path A, B, or C are available, **refuse to ship the audit.** Output:
   - Which tooling paths were checked
   - What specifically is missing
   - The minimum path to make the audit shippable (recommend Path A as easiest — "install Claude in Chrome extension and grant browser access")
   - Do NOT proceed to sitemap parsing, competitive SERP, or any other audit work.

5. **Path-confirmation logging.** When at least one path is available, record which path will be used for the GEO baseline section. This goes into the Confidence section (Section 2) as: "GEO baseline measured via [Path A: Chrome MCP / Path B: Perplexity Sonar API / Path C: user-pasted responses], live as of [timestamp]."

**Why preflight, not section-time check.** If the skill runs an 8-minute sitemap and competitive SERP audit and only fails at the GEO section, the user has already invested time and the audit has nothing useful to do with the gap (a "calibrated prediction" generated as a degraded substitute is exactly the wrong response). Failing at boot lets the user grant tooling or pick a different path before any work is wasted.

---

## Output

**Output discipline:** The audit produces **ONE consolidated markdown document**, not multiple files. Findings, methodology, evidence, and action plan all live in a single deliverable the SMB owner (or consultant delivering to the owner) can scan front-to-back in 10-15 minutes.

A structured markdown audit document with eleven sections:

### Section 1: Executive summary

Three to five sentences capturing the headline. Designed to be readable in 30 seconds by a non-technical owner. Should include the most surprising or important finding (e.g., "Your site is essentially invisible to Google — small number of ranking keywords, near-zero estimated traffic. But the path forward is unusually clear because two of your most strategic keywords have almost no competition.").

### Section 2: Confidence levels

Distinguishes what the skill observed directly (high confidence) vs. what's inferred from indirect signals (lower confidence) vs. what couldn't be verified (gaps). Records which preflight path the GEO baseline was measured via.

### Section 3: P0 findings — critical, fix this week

Ranked list. Each finding annotated with:
- **What** — concrete observation
- **Why this matters** — impact in plain language
- **Fix** — Squarespace/Wix/WordPress-feasible action steps
- **Who executes** — owner solo, paired session, or consultant
- **Expected impact** — qualitative + timeline

### Section 4: P1 findings — high impact, weeks 1-4

Same structure as P0 but for structural improvements: schema (calls `smb-schema-fix` for the full schema diagnosis), content engine setup, About page rewrite, duplicate-content resolution, etc.

### Section 5: P2 findings — polish, weeks 3-6

Lower-impact items: typos, image alt text, social share image dimensions, sitemap quirks. Concrete and bounded.

### Section 6: GEO baseline — how AI engines see your business

Reports the live AI-engine query results for each target query, showing who got cited and who didn't. Includes brand-entity disambiguation findings (how many other businesses share the name). Predicts what would change after P0 + P1 fixes ship.

### Section 7: Competitive landscape

Names the actual competitors ranking for target queries (often different from who the owner thinks). Categorizes them by tier (aggregator platforms vs. multi-provider schools vs. content sites). Identifies which keywords the SMB can realistically win and which they can't.

### Section 8: What's working (don't break)

Things to preserve. Often missing from audits. Typical examples: canonicals present, meta descriptions written, alt text descriptive, AI crawlers allowed in robots.txt, HTTPS, mobile viewport correct. Naming what works protects against well-intentioned changes that break the foundation.

### Section 9: What's still unverified

Honest gaps. Items that need user input (Search Console access), tool access (paid SEO tool), or follow-up testing (Core Web Vitals). Distinguishes "we tried and failed" from "we didn't try" from "this needs your involvement."

### Section 10: Prioritized Action Plan

**Two clearly separated buckets:**

**Quick Wins (do this week)** — actions that take under 2 hours and have immediate impact. Examples: fix typos on buy buttons, delete placeholder posts, set up Google Search Console + submit sitemap, fix a wrong Site Title setting in the CMS. For each action: what to do, expected impact (high/medium/low), effort estimate, dependencies if any.

**Strategic Investments (plan for this quarter)** — actions that require more effort but drive long-term growth. Examples: build a topic cluster + pillar page, rewrite the About page with E-E-A-T signals, implement an off-site authority campaign, restructure CMS sections. Same fields as above.

### Section 11: Flagged adjacent observations

Findings that surface during the audit but are NOT SEO findings — they're business-strategy issues with SEO implications. Common examples:
- **Pricing-positioning tension** (e.g., site charges premium price but doesn't earn it visually or textually)
- **Product-existence issues** (e.g., homepage markets offerings that don't exist as buyable products)
- **Target-market drift** (e.g., site copy targets one persona, testimonials suggest another is actually buying)
- **Brand-name ambiguity that's business-strategy not SEO** (e.g., shared name with multiple competitors but the right move is differentiation, not URL change)

These get FLAGGED here separately rather than embedded in the P0/P1/P2 fixes. They deserve their own business conversation, not silent inclusion in a technical action list. The audit's role is to surface them with evidence; the owner's role is to decide what to do.

This section may be empty in many audits. Don't pad. When empty, write: "No adjacent business observations surfaced in this audit." When non-empty, each item gets: what was observed, why it might matter, what category it falls in (pricing, product, positioning, brand), and an explicit "this is not in the audit's SEO scope — flagged for your business consideration" framing.

---

## Methodology encoded

Sixteen disciplines.

**Inherited from `smb-schema-fix`:**

1. **Live DOM, not markdown extraction.** All visual / interactive claims must come from Chrome MCP, not web fetch markdown.
2. **Verify before claim.** Actually CLICK a button before claiming what happens when clicked. A "trap CTA" finding can be wrong on first pass; correct only after a live click test.
3. **Schema.org / Google Search Central verification gate** for any structured-data recommendation.

**Established in v0.1:**

4. **Sitemap-driven page discovery.** The audit MUST read sitemap.xml, not just the homepage. Many critical findings live on pages the homepage doesn't link to — for example, CMS-placeholder blog posts that are hidden from navigation but fully indexed, dragging the whole domain's quality signals down.

5. **Live AI-engine citation check is the GEO baseline — HARD PRECONDITION.** The audit MUST successfully query at least one AI-engine source via a deterministic tooling path before any GEO findings ship. The acceptable paths are: (a) Chrome MCP against Perplexity + Google AI Overview (the two engines that don't require auth), (b) programmatic API calls (Perplexity Sonar / OpenAI Chat Completions with web browsing / Claude with web search), or (c) manual paste flow where the owner runs each query and submits responses for the skill to parse. **At least one of these paths must complete.** If none can complete, the skill refuses to ship the GEO baseline section and tells the user what to grant or install. **Calibrated prediction from SERP + entity signals is NOT a substitute** — it belongs in Recommendations, not Findings. The visceral "AI engines literally do not know your business exists" finding only lands when the data is measured, not predicted. **Preflight check at skill boot is required** — do not begin sitemap parsing or competitive SERP work before confirming at least one AI-engine path is reachable.

6. **Brand-entity disambiguation is part of the audit.** Search for the business name. Count the other entities using similar names. This is invisible to most owners and is often the structural root cause of poor AI citation.

7. **Competitive analysis names categories, not just sites.** Distinguishing aggregator platforms from multi-provider sites from content sites is more useful than listing 10 URLs. The owner needs to know which game they can play.

8. **Findings must be platform-feasible.** Every recommendation must be executable on the user's CMS. The skill auto-detects (or asks for) the CMS and constrains its advice. No "edit your server-side rendering" advice for a Squarespace user.

9. **Predict outcomes; admit uncertainty.** When making recommendations, the skill states expected impact AND timeline AND honesty about variance. "Removing placeholder posts could move quality signals within 2-4 weeks but may take longer if the site's authority score is very low" — calibrated, not confident.

**Added from 2026 industry-validation research:**

10. **Universal on-site baseline is non-negotiable.** Every audit MUST check the 2026 SEO baseline: HTTPS, mobile rendering, Core Web Vitals (LCP <2.5s, INP <200ms, CLS <0.1), title-tag and meta-description presence and uniqueness, internal-link structure (orphan pages), indexing health (sample pages return via `site:` query), XML sitemap submitted to GSC. These are table stakes across all business types. Source: Google Search Central + multiple 2026 industry checklists.

11. **AI crawler audit uses explicit 2026 taxonomy.** The robots.txt audit MUST distinguish between **training-only crawlers** (ClaudeBot, GPTBot, CCBot, Meta-ExternalAgent) and **live-retrieval crawlers** (Claude-Web, OAI-SearchBot, ChatGPT-User, PerplexityBot, anthropic-ai). Blocking a retrieval crawler removes the brand from AI answers without protecting anything sensitive — a common, costly misconfiguration. Audit must also flag **Bytespider** specifically (non-compliant with robots.txt per public industry data) and recommend server-level blocking if bandwidth is a concern.

12. **GBP is conditional and high-impact.** If the business is local (has a physical address customers visit OR meets customers in-person at their location), Google Business Profile audit is **P0 priority** (GBP signals account for roughly 25-32% of local ranking weight per recent industry studies, up materially since 2023). If the business is online-only-global, GBP is **N/A** and the audit must explicitly say so — and recommend REMOVING any auto-injected `LocalBusiness` schema. The audit must detect business type explicitly and not silently produce generic guidance.

13. **Measurement-infrastructure detection unlocks better downstream output.** The audit checks whether the owner has GA4 and Google Search Console set up. If yes (and connected via OAuth), the audit CONSUMES that data — pulling impressions, top queries, top pages, indexing coverage, mobile usability errors — and produces materially better findings than from blind crawl alone. If no, the audit FLAGS missing measurement as a P0 finding and explicitly recommends `smb-measurement-setup` as the next skill to run.

14. **Audit honestly distinguishes what each business type needs.** The audit branches its output based on detected business type (local service, online service, retail/restaurant, e-commerce, B2B) and names which findings apply, which don't, and which are deferred to a future skill. For example: "Local citations are not in scope of this skill — for your local plumbing business, this is a P1 gap that requires hiring or learning to do manually. A future `smb-local-presence` skill will cover this."

**Added from plugin-comparison testing:**

15. **Single consolidated output document.** The audit produces ONE markdown file, not multiple files. Findings, methodology, GEO baseline, action plan, and flagged business observations all in one deliverable. Substance spread across many files is harder for an SMB owner to act on than the same substance in one consolidated document.

16. **Action plan with explicit Quick Wins vs Strategic Investments split.** Audit output MUST close with Section 10 using these two buckets, not as buried action items in the P0/P1/P2 sections. Quick Wins = <2 hours, this week. Strategic = quarter-scale. Each item has: what to do, expected impact, effort estimate, dependencies.

---

## Dependencies

**Required:**
- **Chrome MCP** — for live DOM inspection on every page, including the homepage and all sitemap-listed pages
- **Web fetch** — for sitemap.xml, robots.txt, Schema.org docs verification, AI crawler vendor docs verification (built-in)
- **Web search** — for AI-engine citation queries, competitive SERP scans, NAP/citation profile checks (built-in)
- **`smb-schema-fix`** — called as a sub-step for the schema portion of the audit
- **PageSpeed Insights API** — for Core Web Vitals measurement (free, rate-limited)

**Strongly recommended (audit degrades gracefully without):**
- **Semrush OR Ahrefs connector** — when present, the audit pulls real domain authority, ranking keyword count, traffic estimate, backlink profile. When absent, the audit uses qualitative SERP analysis only and clearly labels output as "estimated, not measured."
- **Google Search Console connector** — when connected, audit pulls real impressions, top queries, top pages, indexing coverage, mobile usability. This is the single highest-leverage optional connector. When absent, audit flags missing measurement as a finding and recommends `smb-measurement-setup`.
- **Google Analytics 4 connector** — when connected, audit can correlate SEO/GEO findings with actual user behavior data. Less critical than GSC for SEO audit purposes but useful.

**Conditional (if local business):**
- **Google Business Profile API or public profile access** — for the GBP portion of the audit. Public-profile-only via web fetch in this version; full audit (insights, posts, messages) requires GBP API + owner OAuth and is deferred to a future `smb-local-presence` skill.

**Not required:**
- No CMS write access. Outputs are recommendations; the owner does the actual changes.

---

## CMS coverage (MVP)

Same coverage as `smb-schema-fix`: Squarespace, Wix, WordPress. Webflow, Shopify, custom-built deferred.

Audit findings include CMS-specific fix instructions: "In Squarespace, do X" / "In Wix, do Y" / "In WordPress with theme Z, you may need to..." When CMS is unknown, output generic guidance and flag.

---

## Audit scope

**In scope:**
- Single homepage + all sitemap-listed pages (capped at 50 pages for performance; user can override)
- Universal on-site baseline: HTTPS, mobile rendering, title-tag and meta-description audit, internal-link structure (orphan detection)
- Core Web Vitals via PageSpeed Insights API (mobile + desktop)
- Indexing audit on sample pages via `site:` query
- robots.txt analysis with **explicit 2026 AI crawler taxonomy**: separates training-only from retrieval bots; flags Bytespider non-compliance separately
- sitemap.xml analysis (placeholder content, hidden indexed pages, lastmod sanity); checks GSC for sitemap submission status
- Schema inspection (delegated to `smb-schema-fix`)
- Server-side rendering check for important content (flags JS-only critical content)
- **Measurement infrastructure detection**: checks for GA4 + GSC; consumes GSC data when connected; flags missing as P0 with cross-link to `smb-measurement-setup`
- **Business type detection** (local / online-service / retail / e-commerce / B2B); audit branches output accordingly
- **GBP audit (conditional, local businesses only)**: claim status, NAP, primary + secondary categories, hours, photos, posts cadence, reviews (count + recency + response rate), Q&A. Public-profile-only in this version; full owner-OAuth GBP audit deferred to a future `smb-local-presence` skill
- **NAP consistency check** (local businesses only): business name + address + phone across top vertical directories
- **Citation profile snapshot**: vertical authority sites + directories where the business is or isn't listed (named opportunities, not full execution)
- Live AI-engine citation check for 3-5 target queries (Perplexity automated; user runs ChatGPT / Claude / Gemini manually and pastes results if Path C is selected)
- Brand-entity disambiguation
- Competitive SERP for 3-5 target queries via web search
- Domain authority / ranking benchmark via Semrush/Ahrefs when connected
- US English market default; can override to UK/CA

**Deferred:**
- Multi-page deep crawl beyond 50 pages
- Historical comparison (re-audit at 30/60/90 days, show delta)
- Multi-language sites (hreflang analysis, country-specific competitive)
- Auto-competitor identification (find competitors the user didn't name)
- E-commerce specific (product schema, merchant feeds, conversion funnel)
- Restaurant-specific (`MenuSection` schema, HTML menu check, reservation integration)
- Full GBP audit with owner OAuth (deferred to a future `smb-local-presence` skill)
- Backlink profile deep dive — citation snapshot here is read-only; outreach + execution deferred to a future `smb-authority-citations` skill

**Deliberately excluded:**
- `llms.txt` recommendation — per 2026 research, an extremely small fraction of AI crawler requests touch `llms.txt` and no major AI company has publicly committed to acting on it. Don't push this on SMB owners until adoption rises. Differentiation through restraint.

---

## Failure modes the skill handles

| Situation | Skill behavior |
|---|---|
| Site has no sitemap.xml | Audit homepage only; flag missing sitemap as a P1 finding |
| Sitemap has 1000+ URLs | Cap at top 50 by priority/lastmod; flag truncation in output |
| All target AI engines refuse to give specific recommendations | Report this clearly — it's data ("the market is too fragmented for AI engines to recommend anyone, which is itself an opportunity") |
| Chrome MCP not connected | Refuse to proceed. Explain why (visual findings would be unreliable). Tell user how to install Claude in Chrome. |
| Sitemap claims pages exist but they 404 | List as P0 findings (broken links indexed in sitemap are a quality-signal disaster) |
| Schema-fix sub-call fails | Continue audit, mark schema section as "incomplete — schema-fix unavailable" |
| User refused to name target queries / competitors | Refuse to proceed for those sections. Don't fabricate queries. |
| AI engine query returns just the user's own site (rare but possible) | Note this as positive but unusual; verify the entity disambiguation isn't masking competition |
| **No AI-engine path completes (Chrome MCP not granted AND no API key AND owner unwilling to paste)** | **Refuse to ship audit.** Explain the gap. Tell owner which tooling to grant or which API key to provide. Do not produce a "calibrated prediction" GEO section as a substitute. |

---

## Edge cases worth thinking about

**The "audit reveals fundamental business model issues" case.** Sometimes the audit surfaces problems that aren't SEO problems — wrong pricing, wrong target audience, wrong category. The skill should surface these as flagged observations in Section 11, not silently include them in P0/P1/P2 fixes. They deserve their own conversation.

**The "small site, weak signals" case.** When a site has very few pages and very little content, most findings will be in the "you need a content engine" category. The skill should NOT pad with low-quality findings to look thorough. Better to say: "your site is small enough that the audit findings are limited — the biggest move is building content, not optimizing what exists."

**The "audit results are too discouraging" case.** A weak site produces a lot of negative findings (few ranking keywords, low authority, AI engines don't cite). The skill should frame this honestly but not catastrophically. "Near-zero is freedom, not failure" is the framing that lands — the output should include language that helps the owner read findings constructively without softening the facts.

**The "audit conflicts with what the owner has been told by another consultant" case.** Common. The skill output should NOT directly criticize prior advice the owner has received. State current findings; let the owner reconcile. Audit credibility comes from accuracy, not from undermining competitors.

**The "site uses heavy JavaScript / SPA framework" case.** Some small business sites are built on JS-heavy frameworks (less common but real). Markdown extraction will fail entirely on these. Chrome MCP is mandatory here. The skill should detect SPA patterns and adapt — possibly skip sitemap (often missing on SPAs) and rely on the rendered DOM.

---

## Open questions

1. **AI-engine query path specifications.** The contract is hardened (at least one of Path A/B/C must complete or refuse), but the implementation details remain: (a) exact Chrome MCP call sequences for Perplexity + Google AIO with current selector targets, (b) Perplexity Sonar / OpenAI / Anthropic API contracts for Path B, (c) paste-template generator for Path C (exact queries to run in each engine, format for the user to return responses).

2. **Audit runtime.** A full audit pushes realistic runtime to 15-20 min for a 30-page site. Need to decide acceptable runtime ceiling and how to gracefully degrade. Likely: parallel inspection where possible, cap on sitemap pages, configurable depth, "fast" vs "comprehensive" modes.

3. **Output length.** A complete audit doc could be 60+ pages of findings. Need a "headline findings only" mode for first-pass + "deep dive" mode for the owner who wants everything. Headline-only by default; deep-dive on request.

4. **Localization.** Non-English market versions of the audit? Mostly a translation problem but AI engine behavior varies by language. English-only at first; localize later if real demand.

5. **Re-audit detection.** When a user re-runs the audit on the same site after fixes, should the skill detect prior outputs and show delta? Probably yes for retention/motivation.

6. **Privacy / consent.** Audits involve checking the user's site against AI engines, which means a publicly recorded query that includes the business name. Most owners are fine with this but the skill should be explicit.

7. **PageSpeed Insights API rate limits.** Free tier of PSI API has rate limits. For plugin scale this is likely fine but should verify and have fallback behavior if exceeded (e.g., cache PSI results per site for 24 hours).

8. **GBP public-profile audit feasibility.** Public-profile-only scope assumes a certain amount of data is accessible via web fetch from a public GBP listing. Google has been tightening this. If the public profile is too thin, GBP audit may need to be deferred entirely to the future `smb-local-presence` skill with full OAuth.

9. **Business type detection.** The audit branches output based on detected business type. Detection signals: schema types present, GBP eligibility heuristic, CMS platform, owner-provided context. If detection is unreliable, fall back to asking the user explicitly.

10. **Bytespider response.** The audit flags Bytespider non-compliance but the recommended response (server-level block) is outside most SMB owners' technical capability. Provide host-specific instructions where possible; honest note that for most SMBs the answer is "live with the bandwidth cost."

---

## Why this skill orchestrates sub-skills

This is the first skill in the practice that orchestrates a sub-skill (calls `smb-schema-fix`). The pattern that emerges:

- **smb-seo-geo-audit** = comprehensive scan; calls `smb-schema-fix` for the schema portion
- A future first-session orchestrator = comprehensive first-session experience; calls `smb-seo-geo-audit` plus other sibling skills as live demos

This nesting is intentional. Each skill is self-contained AND composable. The audit can be run standalone; it can also be embedded in a larger flow.

**Design implication:** the sub-skill (`smb-schema-fix`) should not assume it's being called by a parent. It should produce output usable both directly and as input to a larger flow. The audit parses the schema-fix output and integrates it into the P1 findings section.

---

## Related

- `smb-schema-fix` — sub-skill called by this audit
- `smb-measurement-setup` — sibling skill; audit flags missing GSC/GA4 with cross-link here
- External: Google Search Central, Schema.org, Whitespark Local Search Ranking Factors, vendor docs for ClaudeBot / GPTBot / PerplexityBot
