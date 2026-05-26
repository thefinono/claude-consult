# Practice — Marketing / SEO + GEO for SMBs

The first claude-consult practice. A set of skills for delivering marketing-manager-level SEO and GEO (Generative Engine Optimization) work to small businesses — usable by SMB owners directly, or by marketers/fractional CMOs delivering to SMB clients.

If `claude-consult/skills/` is the general methodology (think, review, reflect), `practices/` is where the methodology is applied to a specific functional domain. The structure is `practices/<function>/<task-or-expertise>/` — this practice lives at `practices/marketing/seo-geo/`. Future practices will follow the same shape (other marketing sub-disciplines like content or paid, plus other functions: sales, finance, etc.).

---

## Who this is for

Two audiences, one set of skills:

- **SMB owners doing their own marketing** — coaches, course creators, local service businesses, small e-commerce, anyone running their own site without a dedicated marketing function.
- **Practitioners delivering to SMBs** — fractional CMOs, marketing consultants, agencies running SEO/GEO audits for SMB clients.

Same skills, both modes. The skills don't care which one is invoking them.

---

## What's here

| File | What it is |
|---|---|
| `architecture.md` | The architecture for the SEO/GEO skill plugin — v1 scope, v1.5 deferrals, connectors, shared context model, principles. |
| `skills/smb-schema-fix/SKILL.md` | Inspect JSON-LD on a site, diagnose what's wrong, output corrected JSON-LD ready to paste into CMS code injection. |
| `skills/smb-seo-geo-audit/SKILL.md` | Comprehensive site audit — technical SEO, GEO baseline, off-site citations, measurement, GBP (if local) — with P0/P1/P2 prioritized findings. |
| `skills/smb-measurement-setup/SKILL.md` | Walk owner through GA4 + Search Console setup, sitemap submission, baseline metrics snapshot, monthly review prompt library. |

Four more skills (`smb-keyword-clusters`, `smb-content-engine`, `smb-ai-onboarding`, `smb-first-session`) are in the architecture roadmap but not yet written. See `architecture.md` for what they'll cover.

---

## Why GEO matters now (the signature insight)

A modern SMB audit is no longer "is the site healthy for Google" — it's **"does the AI search ecosystem know this business exists, and can it be cited reliably."** Most SMB-SEO advice still optimizes for Google's blue links. That's necessary but insufficient. AI engines (ChatGPT, Perplexity, Claude, Gemini, Google AI Overviews) are an increasing share of how people discover services, and they cite sources differently than traditional search ranks them.

The audit skill makes this concrete: a site can have decent on-page SEO signals and zero AI-engine visibility at the same time. The GEO baseline (live AI-engine citation check) is what makes that gap visible to the owner — and visceral. It's the moment that closes the SMB belief gap: owners stop thinking of AI as a chat toy and start seeing what's at stake for their business.

---

## How to use these skills

### Path 1 — start with the audit

If you don't know where to begin, run `smb-seo-geo-audit` on your site (or your client's site). It will surface what's broken, what's missing, what's working, and where the competitive ceiling actually sits — and route to the other skills for specific fixes.

### Path 2 — start with schema (fastest visible win)

If you already suspect your structured data is wrong (common for Squarespace/Wix sites where the CMS auto-injects schema), run `smb-schema-fix` first. It's the cheapest demoable win and unlocks better AI citation downstream.

### Path 3 — set up measurement first

If your site doesn't have Google Analytics 4 or Search Console connected yet, run `smb-measurement-setup` first. The audit and keyword skills produce materially stronger output when there's 30 days of GSC data to read.

---

## Methodology principles (encoded across all skills)

Every skill in this practice holds to these. See `claude-consult/patterns/fail-fast-at-boot.md` for the full version of #6.

1. **Dual-use by default** — practitioner and self-serve, same artifact.
2. **Propose-and-paste, not direct write** — skill outputs go to the user, who applies them; no CMS write access.
3. **Live DOM, not markdown extraction** — for any live site inspection, use browser automation. Markdown extraction misses what the CMS injects via JavaScript.
4. **Verification gates against current docs** — before recommending anything that depends on a standard (Schema.org, Google Search Central, AI vendor crawler docs), fetch current source-of-truth. Standards change.
5. **Settings-vs-code distinction** — when CMS settings drive output, code injection can't fix it. Tell the user where each fix actually lives.
6. **Fail-fast at boot, never silently degrade** — when a skill depends on tooling that may be missing, preflight at boot and refuse cleanly. Never present an inferred finding as a measured one.
7. **Honest confidence labeling** — distinguish measured from inferred in every output.
8. **Single consolidated output per skill run** — one markdown doc, not a folder of sub-files.

---

## What's deliberately NOT in v1

| Excluded | Why |
|---|---|
| Paid ads / PPC, social media, email marketing | Different functional disciplines; future practices may cover them. |
| E-commerce product schema, merchant feeds | v2 — modal v1 SMB isn't e-commerce-first. |
| Restaurant menu / hotel room schema | v2 or its own variant. |
| Direct CMS writes | v2 — security and trust trade-offs that propose-and-paste avoids. |
| **`llms.txt` recommendation** | **Deliberate exclusion** — per 2026 industry research, <0.1% of AI crawler requests touch llms.txt; no major AI company has publicly committed to acting on it. Most SMB-SEO checklists push it; this one explicitly skips it. |
| Multi-site / agency dashboards | v2. |
| Reporting beyond per-skill output | v2. |

---

## License

Same as the parent repo — PolyForm Noncommercial 1.0.0. Free for personal use, study, and noncommercial work. Commercial use requires explicit written permission.
