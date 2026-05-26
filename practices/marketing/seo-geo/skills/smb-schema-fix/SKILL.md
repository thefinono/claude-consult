---
name: smb-schema-fix
description: Inspect the JSON-LD structured data on a small business website, diagnose what's wrong (with explicit reasons), and output corrected JSON-LD ready to paste into the site's CMS code-injection field. Use when a small business owner asks to fix their schema, check their structured data, or wants to know how AI engines and Google see their site.
tags: [smb, seo, geo, schema, json-ld]
status: stable
source: distilled from SMB SEO/GEO engagement work + 2026 industry-validation research
---

# Skill: smb-schema-fix

Inspects the JSON-LD structured data on any small business website, diagnoses what's wrong with explicit reasons, and outputs corrected JSON-LD ready to paste into the site's CMS code-injection field.

**Why this skill exists.** Most schema-generator tools write JSON-LD from scratch and assume there's nothing on the page already. In practice, hosted CMS platforms (Squarespace, Wix, and others) auto-inject schema for every site whether the owner asked for it or not — and they frequently inject the *wrong type* (e.g. `LocalBusiness` for an online-only business) with empty or corrupt fields. The owner has no idea this is happening. This skill inspects what's actually live on the page, names what's wrong and why, and produces a corrected block the owner can paste in.

---

## What it does in one paragraph

Given a small business website URL, the skill loads the page in a real browser (via Chrome MCP), inspects all JSON-LD `<script type="application/ld+json">` blocks in the live DOM, classifies what's present, identifies what's wrong (wrong types, empty required fields, deprecated patterns, mismatched names), verifies the correct schema spec against current Schema.org and Google Search Central docs, and outputs a diagnosis plus a complete corrected JSON-LD block ready for the user to paste into their CMS's code-injection area. CMS-specific paste instructions are provided when the CMS is detected or supplied.

---

## Trigger phrases

The skill should activate on natural-language requests like:

- "fix my schema"
- "check my structured data"
- "is my site labeled right for AI"
- "what does Google see when it looks at my site"
- "diagnose the schema on [my url]"
- "why am I not getting cited by ChatGPT" (when the user is a small business owner)
- consultant-led: "audit [client]'s schema"

Also activates when the user is mid-conversation about SEO/GEO and surfaces a schema-related question.

---

## Input

**Required:**
- Site URL (single URL — single-page inspection in v0.1; multi-page later)

**Optional (improves output quality):**
- Business type (e.g., "online language school," "consulting firm," "local bakery")
- Founder or principal name (for Person schema)
- Services offered (for Service schema)
- CMS platform (Squarespace, Wix, WordPress, Webflow, Shopify) — auto-detected when possible

If optional fields are missing, the skill asks for them conversationally rather than producing weak output.

---

## Output

A structured markdown report with three sections:

### Section 1: What schema your site currently has

Lists every JSON-LD block found, with type, key fields, and an inline assessment per block: correct, partial/imperfect, or wrong type / corrupt data. Example:

```
WRONG: LocalBusiness (auto-injected by your CMS)
   - name: ""  ← EMPTY
   - address: ""  ← EMPTY (and you're an online-only business — wrong type entirely)
   - openingHours: ", , , , , , "  ← CORRUPT (formatting artifact)
   - Why this is wrong: LocalBusiness signals to AI engines that you have a physical
     storefront with hours. You're an online service. AI engines and Google penalize
     structured data with empty required fields.
```

### Section 2: What's missing

Lists schema types the business SHOULD have but doesn't: `Organization` (or `EducationalOrganization`, `ProfessionalService`, etc. depending on type), `Person` (founder), `Service` (offerings). Each missing type comes with a one-sentence "why this matters."

### Section 3: Your corrected schema — ready to paste

A complete JSON-LD block with the right types, the right names, and the right fields, generated from the inputs supplied. Includes:

- The schema block itself, formatted and indented for readability
- Inline `<!-- comments -->` explaining what each non-obvious field does
- A "where to paste this" line specific to the CMS (e.g., "Squarespace: Settings → Advanced → Code Injection → Header")
- A "before you publish" caveat with a link to Google's Rich Results Test for verification

### Optional Section 4: CMS settings you should also fix

When the skill finds that wrong schema is being auto-injected from CMS settings, it produces a separate list of settings-level fixes. The user must do these in the CMS dashboard, not in code injection. Example: "Squarespace → Settings → Business Information → Site Title: change from your domain string to your actual business name." The skill is explicit that these are SETTINGS changes, not code changes — code-injection fixes alone won't work if the settings keep overriding.

---

## Methodology encoded

Five disciplines this skill enforces:

**1. Live DOM, not markdown extraction.** The skill MUST use Chrome MCP to inspect the rendered page. Markdown extraction (web fetch) misses JSON-LD that hosted CMSes inject via JavaScript. An audit that uses markdown extraction can entirely miss auto-injected schema and produce a confidently wrong diagnosis.

**2. Schema.org verification gate.** Before generating any corrected JSON-LD, the skill MUST fetch the current Schema.org docs (and Google Search Central docs for rich-result-eligible types) for each type being written. Schema standards change. Deprecations happen — `FAQPage` rich results, for example, were narrowed by Google in 2023 and again in 2026. Verifying against live docs before writing is a hard rule, not a "should."

**3. Identify wrong types, not just empty fields.** The most common SMB schema error isn't missing schema — it's the wrong type entirely. Online-only businesses with `LocalBusiness` schema. Service businesses with `Product` schema. The skill names these explicitly and explains why they're wrong, not just "switch from X to Y."

**4. Settings vs. code distinction.** When the CMS's own settings drive the schema (the auto-injection pattern), code-injection fixes don't work — the settings keep overriding. The skill MUST distinguish these and tell the user where each fix lives. A code-injection fix layered on top of a wrong settings value produces conflicting schema blocks and an even worse outcome.

**5. Conservative recommendations.** When uncertain whether something is wrong, the skill flags it as a question rather than auto-fixing. ("I see X. This could be intentional or could be wrong. Tell me Y so I can be sure.") This protects against the failure mode where the skill confidently produces wrong corrections.

---

## Dependencies

**Required:**
- **Chrome MCP** — for live DOM inspection. The skill should check this is connected at start and ask the user to install Claude in Chrome if not.
- **Web fetch** — for fetching current Schema.org and Google Search Central docs during the verification gate. Built-in.

**Not required:**
- No paid SEO tool (Semrush, Ahrefs) needed. This is a pure structured-data skill.
- No CMS write access. Outputs are pasteable; the user does the actual paste.

---

## CMS coverage (MVP)

**Supported:**
- **Squarespace** — code injection via Settings → Advanced → Code Injection → Header (Business plan or above required)
- **Wix** — Settings → Custom Code (Premium plan required)
- **WordPress** — multiple paths depending on theme; skill outputs the JSON-LD and lets the user pick a paste location

**Deferred:**
- Webflow (different code-injection model)
- Shopify (theme-edit complexity, and most needs are e-commerce schema)
- Custom-built sites (the user can paste anywhere; generic guidance only)

For unsupported CMSes the skill outputs the schema with generic "paste this into your site's `<head>` section" instructions and notes that CMS-specific guidance isn't yet available.

---

## Schema types covered (MVP)

**Supported:**
- `Organization` and its subtypes (`EducationalOrganization`, `ProfessionalService`, etc.)
- `Person` (founder, principal practitioner)
- `Service` (offerings, with optional `Offer` for pricing)

**Deferred:**
- `Course` and `CourseInstance` (requires structural decisions about how the business packages its services)
- `Review` and `AggregateRating` (requires verifiable review attribution)
- `Article` (for blog posts)
- `BreadcrumbList`, `WebSite` SearchAction (sitelinks-search)
- `LocalBusiness` and subtypes (deliberately deprioritized — most SMBs misuse it)

---

## Failure modes the skill handles

| Situation | Skill behavior |
|---|---|
| No JSON-LD on the page at all | Report "no schema present" and proceed to generate from scratch with explicit "starting fresh" framing |
| Schema present, valid, and correct | Report "your schema is in good shape" and stop. Don't generate redundant additions. |
| Schema present but malformed JSON | Report exactly what's broken (syntax error, unescaped quotes, etc.). Don't silently rewrite. |
| Wrong schema type with reason ambiguous | Ask the user about their business model before recommending the change. |
| CMS detected but version unknown | Output generic instructions; flag that CMS-version-specific guidance may differ. |
| Page failed to load / Chrome MCP not connected | Report the failure clearly. Don't fall back to markdown extraction — that would defeat the methodology. |
| User is on a CMS the skill doesn't have specific guidance for | Output schema with generic paste instructions; flag the CMS as not yet specifically supported. |

---

## Edge cases worth thinking about

**The "good-faith schema injected by CMS" case.** Hosted CMSes routinely auto-inject `WebSite` and `LocalBusiness` blocks. The site owner didn't write either one. The skill must explain this so the owner understands WHY there's wrong schema present — they didn't put it there, the CMS did, but they're the only one who can fix it.

**The "owner doesn't know what business type they are" case.** Common for solo consultants. The skill should help them think through: are you a `Person` operating alone, or an `Organization` with one employee? Both are valid; the choice affects positioning. The skill provides a short decision aid rather than picking for them.

**The "multiple businesses, one site" case.** Some sites cover multiple offerings (e.g., consulting + courses + speaking). v0.1 generates schema for the primary business and flags the others for separate per-page schema in a future content-engine pass.

**The "wrong schema is generating real Google rich results" case.** Rare but possible: bad schema sometimes still triggers some rich features. The skill warns when removing or correcting schema may temporarily reduce visible Google features, and recommends checking Search Console after the change.

---

## Open questions

1. **Output format.** Markdown report (current default) vs. interactive walkthrough where the skill asks questions and makes one recommendation at a time. Both have merits; markdown report is the v0.1 default.
2. **Coexistence with auto-injected schema.** If a custom `Organization` block coexists with the CMS's auto-injected `LocalBusiness`, which does Google honor? Empirically uncertain — verify in the Rich Results Test for each engagement.
3. **Liability and disclaimer.** When the skill recommends a schema change, what's the standing disclaimer? "We can't guarantee Google will pick this up, and incorrect schema can trigger a manual action." This should appear in the output where the owner sees it.

---

## Related

- `smb-seo-geo-audit` — comprehensive audit skill; calls this skill as a sub-step for the schema portion
- `smb-measurement-setup` — measurement-foundation sibling skill (GSC + GA4 setup)
- External: Google Search Central structured data docs (https://developers.google.com/search/docs/appearance/structured-data), Schema.org (https://schema.org)
