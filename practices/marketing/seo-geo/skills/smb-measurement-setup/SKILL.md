---
name: smb-measurement-setup
description: Walk a small business owner through setting up Google Analytics 4 and Google Search Console for their site, submit the sitemap, capture a baseline metrics snapshot, and equip the owner with a monthly review prompt library so they can read their own data. Use when an SMB owner needs to set up SEO measurement, doesn't know if they have analytics, or asks how to know if their SEO is working.
tags: [smb, seo, measurement, gsc, ga4, foundation]
status: draft
source: distilled from SMB SEO/GEO engagement work + 2026 industry-validation research
---

# Skill: smb-measurement-setup

The measurement-foundation skill — the one that unlocks the quality of everything that follows. Walks an SMB owner through setting up Google Analytics 4 and Google Search Console for their site, submits the sitemap, captures a baseline metrics snapshot, and equips the owner with a monthly review prompt library so they can read the data themselves. Universal across business types: every SMB needs this, regardless of local vs online, service vs retail vs B2B.

**Why this skill exists.** Every 2026 SEO source reviewed — Google Search Central, Whitespark, Search Engine Land, First Page Sage, Shopify's SEO docs, Chowly, BrightLocal — treats Google Search Console + Google Analytics 4 setup as universal table stakes. Without measurement, an SEO audit is working blind, keyword strategy can't compare planned keywords against what the site already gets impressions for, and the owner has no way to know whether anything they do is working.

**The signature insight this skill encodes:** "You can't optimize what you can't see." The most common reason SMB SEO/GEO efforts fail to compound is that the owner has no idea what queries Google already associates with their site, what pages already get impressions, or whether their sitemap is even submitted. Setting up Search Console + GA4 is the single move that converts the next 6 months of work from "guessing whether anything is working" to "knowing what changed and why." The first 30 days of Search Console data is often more informative than any number of SEO audits.

---

## What it does in one paragraph

Given a site URL and confirmation that the owner has (or is willing to create) a Google account, the skill walks through: (1) Search Console account setup; (2) site verification using the method appropriate to the owner's CMS (meta tag for Squarespace, DNS for advanced, HTML file upload for WordPress, Wix-specific integration if applicable); (3) XML sitemap submission to Search Console; (4) GA4 property setup and tracking-tag installation (CMS-specific); (5) GA4 ↔ Search Console linking so search queries appear in GA4 reports; (6) baseline metrics snapshot (current impressions, clicks, top queries, top pages, indexing coverage, any mobile-usability errors); (7) a "monthly review" prompt library the owner can re-run via Claude to read their own data; (8) honest framing of what Search Console + GA4 do and don't show (they don't show AI-engine citations — that's the audit skill's job; they don't show conversion attribution beyond on-site behavior; they don't show whether content quality is good). The skill produces a written setup walkthrough doc, a baseline snapshot doc, and the monthly prompt library — all three readable by a non-technical owner.

---

## Trigger phrases

The skill should activate on natural-language requests like:

- "set up my analytics"
- "help me track my SEO"
- "do I have Search Console" / "do I have Google Analytics"
- "how do I know if my SEO is working"
- "what should I be measuring"
- "I don't think I have any tracking set up"
- consultant-led: "set up measurement for [client] before our next session"

Also activates **automatically** when `smb-seo-geo-audit` detects that the owner has neither GA4 nor Search Console connected — the audit cross-links here as the recommended next skill.

---

## Input

**Required:**
- Site URL (homepage)
- CMS platform (auto-detected by the audit if available; otherwise asks)
- Whether the owner has a Google account (if no, walks them through creating one — though account creation must be done by the owner directly, never by the skill)

**Strongly recommended:**
- Owner's role: "owner-operator" vs "owner with web person who handles tech" — affects how the skill walks through verification steps (more or less hand-holding)

**Optional:**
- Existing analytics (if owner says "I have Google Analytics but it's old" — likely Universal Analytics, fully sunsetted by Google in July 2023; skill needs to migrate them to GA4)
- Existing Search Console ownership (if owner says "someone set this up years ago but I don't have access" — skill walks through ownership recovery)
- Whether the owner uses Bing or wants Microsoft tooling too (Bing Webmaster Tools is an optional bonus add)

---

## Output

Three artifacts:

### Artifact 1: Setup walkthrough doc

Step-by-step instructions tailored to the owner's CMS. Six sections:

1. **Create or sign into Google account** — owner does this directly, skill provides instructions
2. **Set up Google Search Console** — add property, verify ownership using CMS-appropriate method
3. **Submit XML sitemap to Search Console** — where to find sitemap URL per CMS, how to submit
4. **Set up Google Analytics 4** — create property, install tracking tag (CMS-specific)
5. **Link GA4 ↔ Search Console** — so search-query data appears in GA4
6. **Verify everything is working** — sanity checks: data appearing within 48-72 hours

Each step includes:
- What to click / type
- Screenshot references (the skill describes what the owner should see; doesn't generate screenshots)
- Common failure modes ("if verification fails because you don't have admin access to your CMS, here's the workaround")
- Time estimate per step (usually 5-15 min each)

### Artifact 2: Baseline metrics snapshot

Captured after setup completes and Search Console has been collecting data for at least 7 days (skill flags this — initial setup doesn't have data yet). Includes:

- **Current impressions** (last 7 days / 28 days)
- **Current clicks** (same windows)
- **Top 10 queries** the site is appearing for (often surprises owners — these are rarely what they hoped to rank for)
- **Top 10 pages** by impressions
- **Indexing coverage status** (how many pages indexed vs submitted in sitemap; flags errors)
- **Mobile usability errors** if any
- **Core Web Vitals** if Search Console has enough data
- **AI Overview appearances** if Search Console reports them (Google added this in 2025 for sites that appear in AIO)

This snapshot becomes the "before" picture against which future audits and content work are measured.

### Artifact 3: Monthly review prompt library

Five prompts the owner can paste into Claude (or any LLM) once a month to read their own Search Console + GA4 data without needing to learn how to use the Search Console interface. Each prompt asks the owner to paste a specific Search Console report and produces a plain-language reading:

1. **"What changed this month"** — comparing impressions, clicks, top queries between current and prior month
2. **"What new queries am I appearing for"** — what Search Console discovered that the owner didn't target
3. **"Where am I losing visibility"** — queries with declining impressions
4. **"What pages are working / not working"** — top + bottom pages by impressions and click-through rate
5. **"What's broken"** — indexing errors, mobile usability, security issues

Each prompt is designed for an owner who is NOT willing to learn the Search Console interface — a pure paste-data-and-read-summary workflow.

---

## Methodology encoded

Eight disciplines.

1. **Measurement before optimization.** Baseline data must exist before any audit or content work, so changes can be measured. Setting up Search Console AFTER making changes loses the ability to attribute results. The skill's existence as the foundation layer encodes this. Source: universal across all 2026 SEO sources; specifically called out by Google Search Central and First Page Sage.

2. **CMS-specific verification, not generic instructions.** Each major CMS has different verification options and trade-offs. Squarespace meta-tag verification is simplest but ties the Search Console property to the site (move CMS = re-verify). DNS verification is more portable but requires DNS access. WordPress plugins (Yoast, Rank Math) automate verification but add a plugin dependency. The skill picks the right method for the owner's situation and explains the trade-off in one sentence.

3. **Honesty about what measurement does NOT show.** Search Console + GA4 are essential but incomplete. They don't show AI-engine citations (mention rate / citation rate / position — those are the audit skill's domain), don't show competitor performance, don't show why content quality is good or bad, don't show off-site authority or backlinks. The skill explicitly names these gaps so the owner doesn't develop false confidence from measurement alone.

4. **Owner does account creation; the skill never creates accounts on the owner's behalf.** Account creation is owner action only. The skill produces clear instructions; the owner clicks the buttons. This is non-negotiable.

5. **Sitemap submission is part of "measurement setup," not a separate step.** Without sitemap submission, Search Console's indexing coverage report shows wrong data and Google may take longer to discover new pages. Bundling sitemap submission into measurement setup ensures owners don't accidentally skip it.

6. **Universal Analytics migration handled explicitly.** Some owners still have UA accounts from before the July 2023 sunset. The skill detects this (asks: "do you have an older Google Analytics account?") and provides the GA4 migration path. UA data is no longer accessible as of mid-2024; only the historical export remains.

7. **Microsoft / Bing tooling is bonus, not core.** Bing's share of US search is roughly 9% and varies by industry (higher in B2B, lower in younger consumer). Bing Webmaster Tools is free and easy to add, but isn't worth holding up Search Console / GA4 setup over. The skill offers Bing setup as an optional add at the end.

8. **Monthly review prompts assume the owner won't learn the Search Console interface.** Many SMB owners would rather paste data into Claude than learn to navigate Search Console. The monthly review prompts are deliberately scoped for a paste-and-summarize workflow, not "go look at this graph in Search Console." This respects the actual SMB-owner constraint: they don't have time to become amateur SEO analysts, but they DO have 10 minutes a month to read a Claude summary of their data.

---

## Dependencies

**Required:**
- **Web fetch** — for accessing Search Console and GA4 help docs for CMS-specific verification steps (built-in)
- **Web search** — for confirming the current Google account creation flow and current CMS verification methods (built-in)

**Owner provides (not skill-side):**
- Google account
- Admin access to CMS (for verification)
- DNS access (only if the owner picks DNS verification)

**Not required:**
- No connectors needed for the setup walkthrough itself
- Once setup completes, Search Console and GA4 connectors (when available) enable downstream skills (`smb-seo-geo-audit`) to consume the data

---

## CMS coverage (MVP)

Same coverage as `smb-schema-fix` and `smb-seo-geo-audit`: **Squarespace, Wix, WordPress**. Webflow, Shopify, custom-built deferred.

### CMS-specific verification quirks

| CMS | Search Console verification | GA4 install method | Sitemap location |
|---|---|---|---|
| **Squarespace** | Meta tag via Settings → Advanced → Code Injection (header) | Use Squarespace's built-in GA4 integration (Settings → Advanced → External Services) — preferred. Manual `gtag.js` fallback if integration unavailable. | `[domain]/sitemap.xml` (auto-generated) |
| **Wix** | Meta tag via Wix dashboard → Settings → Marketing & SEO → Google Verification | Wix dashboard → Settings → Marketing & SEO → Google Analytics | `[domain]/sitemap.xml` (auto-generated) |
| **WordPress** | Recommended: Yoast or Rank Math plugin (automated). Alternative: HTML file upload via FTP / cPanel. | Yoast / Rank Math integration OR Site Kit by Google plugin (most comprehensive). Manual `gtag.js` as fallback. | `[domain]/sitemap.xml` if SEO plugin enabled; `[domain]/wp-sitemap.xml` if using WP core sitemap (default since WP 5.5) |

Where CMS detection fails, output generic Google-verification instructions and flag that the owner may need help from their web person.

---

## Scope

**In scope:**
- Google Search Console setup walkthrough (Squarespace, Wix, WordPress)
- XML sitemap submission to Search Console
- Google Analytics 4 setup walkthrough (Squarespace, Wix, WordPress)
- GA4 ↔ Search Console linking
- Baseline metrics snapshot (after 7-day data collection window)
- 5-prompt monthly review library
- Universal Analytics migration path (for owners with pre-July-2023 accounts)
- Bing Webmaster Tools as optional bonus add at end

**Deferred:**
- Microsoft Clarity (free behavior recording) — optional add; not in MVP
- Google Tag Manager (more powerful than `gtag.js` alone but adds complexity) — recommend Site Kit / Yoast / Rank Math for WordPress owners instead in MVP
- Search Console API for automated baseline snapshots (would replace manual paste workflow) — requires owner OAuth; nice-to-have, not essential
- Custom GA4 events / conversion tracking — most SMBs don't need this in their first 6 months; skill suggests a separate engagement when they're ready
- Multi-property setups (subdomains, multiple sites) — owner with 5 sites is not the modal MVP user

**Deliberately excluded:**
- Adobe Analytics / Mixpanel / Heap / other paid analytics platforms — not relevant to SMB scale
- Server-side analytics (Plausible, Fathom) — these are valid alternatives but the skill picks the Google stack for free + ubiquity. Owners can substitute Plausible for GA4 if they prefer privacy-first tooling; the skill notes this as an option without walking through it.

---

## Failure modes the skill handles

| Situation | Skill behavior |
|---|---|
| Owner doesn't have a Google account | Walks through account-creation instructions; owner clicks through; skill never creates the account |
| Owner doesn't have admin access to their CMS | Identifies the problem, suggests asking their web person OR provides DNS verification fallback (which requires domain registrar access instead) |
| Sitemap URL returns 404 | CMS-specific troubleshooting (e.g., "in Squarespace, sitemap.xml is auto-generated — if you're seeing 404, your domain isn't connected correctly") |
| Owner already has Search Console but lost access | Walks through Google's ownership recovery process or recommends creating a new property and asking the old owner to transfer |
| Owner has Universal Analytics, not GA4 | Detects this (asks: "is the account from before 2023?"), explains UA is sunsetted, walks through GA4 setup as new property; historical UA data is no longer accessible |
| Search Console reports indexing errors during baseline snapshot | Flags errors; provides per-error-type guidance; if errors are severe, recommends running `smb-seo-geo-audit` for deeper diagnosis |
| Owner says "I don't want to use Google for tracking" | Acknowledges privacy preference; offers Plausible / Fathom as paid alternative; explains the skill is Google-focused; owner can still use just Search Console (free + Google-only) for SEO measurement even if they pick a non-Google analytics tool |
| Owner asks "what's the difference between Search Console and Analytics" | Clear explanation: Search Console = how Google sees your site (queries, impressions, indexing); GA4 = how users behave on your site (sessions, page views, conversions). Both needed; they show different things. |
| Owner installed everything but no data appears after 72 hours | Verification troubleshooting checklist; common issue is a missing tracking tag on key pages or a domain mismatch |

---

## Edge cases worth thinking about

**The "owner thinks Search Console = SEO tool that will rank them" case.** Common misconception. The skill must clarify upfront that Search Console is a **diagnostic** tool, not a ranking tool. It shows what Google sees; it doesn't change what Google does. Setting up Search Console won't improve rankings — but reading Search Console data will inform decisions that improve rankings. This framing prevents disappointment 30 days in.

**The "owner gets overwhelmed by GA4's interface" case.** GA4's UI is notoriously confusing compared to Universal Analytics. The monthly review prompt library exists specifically to insulate owners from this. The skill explicitly tells owners: "you do not need to learn GA4's interface. Use the monthly prompts. If you want to learn GA4 later, fine — but it's not required."

**The "owner's existing site already has tracking but they don't know what or where" case.** Common. View-source via Chrome MCP can quickly identify what's installed. The skill detects pre-existing GA4 or GTM tags and offers to either build on them or replace them depending on circumstances. Should NOT silently install duplicate tracking — duplicate tracking double-counts and breaks data.

**The "owner has an agency or consultant who set up tracking and they were never told the credentials" case.** Genuinely common — agencies sometimes hold Search Console ownership and don't transfer it. The skill provides Google's ownership transfer request flow and the harder "ownership claim via DNS verification" workaround. May require the owner to contact the agency or do a domain-level verification to wrest control.

**The "owner is on a CMS the skill doesn't formally support" case.** Webflow, Shopify, Ghost, custom-built. The skill should detect this (or ask) and provide generic Google-verification instructions ("here's what Search Console needs; your specific CMS will have a way to add a meta tag to the homepage — Google your CMS name + 'Search Console meta tag verification'"). Better honest than padding with wrong CMS-specific advice.

---

## Open questions

1. **Search Console Insights vs Performance report focus.** Google added a simpler "Insights" panel in 2024 that's friendlier for non-technical users. The monthly review prompts could anchor on Insights data (simpler) or Performance data (more detailed). Current default: prompts use Performance data because it's more flexible; skill mentions Insights for owners who want a lighter touch.

2. **Bing Webmaster Tools placement.** Offer at the end as bonus (current plan) vs include in main flow (would add 15 min to setup). Likely answer: bonus add at end. Roughly 9% of US searches are Bing but the marginal value to most SMBs is low; adding it inflates setup time and risks scaring owners off mid-flow.

3. **Microsoft Clarity inclusion.** Free behavior-recording tool (session replays, heatmaps). Highly useful, but adds another setup step + privacy considerations. Likely answer: not in MVP; mention as an optional add at end.

4. **Privacy-first alternative coverage.** Plausible, Fathom, Simple Analytics are credible privacy-first GA4 alternatives. The skill currently mentions them as a substitution option without walking through setup. Worth a separate sub-flow if user demand emerges.

5. **GA4 conversion / event setup depth.** Modal SMB doesn't need custom events in their first 6 months; default GA4 enhanced measurement is enough. But some owners ask "how do I track when someone fills out my contact form" — this is a real question. Lean defer: too platform-specific. Mention as an upgrade path the owner can request when ready.

6. **Owner-data baseline snapshot privacy.** The baseline snapshot includes the owner's own Search Console data, which is not sensitive in the usual sense but does contain query strings users typed to find the site, some of which may reveal sensitive context (e.g., medical practice queries). Worth a brief privacy note in the snapshot output: "this data is yours; treat it confidentially as you would any business data."

7. **Re-verification when owner changes CMS.** Search Console verification is method-specific; if the owner migrates from Squarespace to Wix, the meta-tag verification breaks. DNS verification is more portable. Worth recommending DNS verification when CMS portability is foreseeable, even if it's slightly more technical to set up.

---

## Why this skill is the unlock for downstream skills

The audit and keyword-strategy skills are materially weaker without Search Console data. Specifically:

- **`smb-seo-geo-audit` without Search Console**: relies on blind crawl + qualitative SERP analysis. Cannot read impressions, queries, indexing coverage from Google's own perspective. Audit produces roughly 70% of the value it could with Search Console connected.
- **`smb-seo-geo-audit` with Search Console connected** (post-setup): can compare what the site IS appearing for vs what the owner wants. Surfaces "queries you didn't target that you're already ranking for" — often the highest-leverage SEO opportunities.
- **Keyword-strategy skills without Search Console**: build keyword strategy from research data only. Cannot validate against current site performance.
- **Keyword-strategy skills with Search Console connected**: cross-check planned keywords against existing impression data. Catches both "obvious keywords you're already winning, don't double-write" and "keywords you're getting impressions for but ranked 11-30, push these to page 1 with light optimization."

This is why measurement-setup should run before keyword-strategy work and provide the data input that makes both audit re-visits and keyword-strategy materially better. The first run of the audit skill won't have Search Console data; subsequent runs will.

---

## Related

- `smb-seo-geo-audit` — sibling skill; cross-links here when it detects no Search Console / GA4; consumes Search Console data once the owner runs this skill
- `smb-schema-fix` — sibling skill; not directly affected by measurement setup, but the audit that calls schema-fix benefits from Search Console data
- External: Google Search Central, Google Analytics 4 docs, Yoast / Rank Math / Site Kit documentation
