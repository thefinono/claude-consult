---
name: project-hygiene
description: Keep project folders clean, organized, and scalable. Use at project start, when the root gets cluttered, when adding new workstreams, before adding Git mid-project, or when secrets enter the picture. Say 'clean up', 'organize', or 'project hygiene'.
---

Base directory for this skill: ~/.claude/skills/project-hygiene

# Project Hygiene

Keep project folders clean, organized, and scalable as work evolves. Use this skill proactively — at project start, when the root gets cluttered, or when adding new workstreams (scripts, data, deliverables). Also covers mid-project Git init and secret management.

---

## When to Trigger

- Starting a new project (complements `/new-project-setup`)
- Root folder has more than 5 files at the top level
- Adding a new workstream (e.g. video, dashboard, scraper, analysis)
- User asks to "clean up" or "organize"
- Before adding Git to an existing project
- When secrets/API keys enter the picture mid-project

---

## Folder Structure Principles

### 1. Root should be folders only (or nearly)
The root directory should have almost no loose files — just directories and maybe a CLAUDE.md or README. If you see CSVs, scripts, or docs at the root, they belong in a subfolder.

### 2. Organize by purpose, not by date
```
# Good — by purpose
docs/
pilot_data/
scraper/
output/

# Bad — by date or sequence
week1/
week2/
march_files/
```

### 3. Standard folder names

| Folder | What goes here |
|--------|---------------|
| `docs/` | Context docs, specs, briefs, meeting notes |
| `docs/client/` | Client-facing documents |
| `docs/internal/` | Internal strategy, notes |
| `data/` or `{name}_data/` | Input data, source files. Name by source (e.g. `pilot_data/`, `survey_data/`) |
| `scripts/` or `scraper/` | Code, organized by function (`collect/`, `normalize/`, `validate/`) |
| `output/` | Generated artifacts — CSVs, JSONs, reports, screenshots |
| `output/{deliverable}/` | Sub-organize outputs when they grow (e.g. `output/phase2_analysis/`, `output/video_screenshots/`) |
| `schemas/` | Data schemas, type definitions |
| `assets/` | Images, logos, design files |
| `Video Edit/` or `video/` | Video production files |

### 4. Don't nest too deep
Three levels max. `output/phase2_analysis/results.json` is fine. `output/data/phase2/region/entities/individual/result.json` is not.

### 5. Naming conventions
- Folders: lowercase with hyphens or underscores (`pilot_data/`, `video-edit/`)
- Exception: folders synced to Google Drive can keep spaces if already named that way
- Files: descriptive, include date if versioned (`voiceover_script_v2.txt`, `dashboard_data.json`)
- No spaces in filenames when possible

---

## Mid-Project Cleanup Checklist

When the root gets cluttered, run through this:

1. **List root contents** — anything that isn't a folder?
2. **Group by purpose** — which files belong together?
3. **Create folders** — name by purpose, not chronology
4. **Move files** — update any hardcoded paths in scripts after moving
5. **Check scripts for broken imports** — `grep -r "from.*import\|open(" scraper/` to find path references
6. **Update CLAUDE.md path references** — grep CLAUDE.md for any moved paths and fix them. Also update the folder structure diagram and file inventory table if they exist.
7. **Verify nothing broke** — run a quick test if scripts depend on moved files

```bash
# Quick cleanup pattern
mkdir -p docs data output
mv *.md docs/
mv *.csv *.xlsx *.json data/
# Then review — some files may need different homes

# After moving, find stale path references
grep -n "docs/\|output/\|scripts/" CLAUDE.md | grep -v "^#"
```

---

## Adding Git Mid-Project

When a project starts on Google Drive without Git and later needs version control:

### When to add Git
- Scripts are getting complex (multiple files, imports)
- Multiple people editing code
- You want rollback safety
- Preparing for deployment or CI/CD

### How to add Git safely

```bash
# 1. Create .gitignore FIRST (before git init)
cat > .gitignore << 'EOF'
# Secrets
.env
*.env
credentials.json
token.json

# Data — too large or sensitive for Git
data/
*_data/
output/
*.csv
*.xlsx

# Generated
__pycache__/
*.pyc
.venv/
venv/

# macOS
.DS_Store

# IDE
.claude/
EOF

# 2. Now init
git init

# 3. Review what will be tracked
git status

# 4. Stage selectively — never git add .
git add .gitignore
git add scripts/ scraper/ schemas/ docs/
# Review each: do NOT add data, output, or secrets

# 5. Verify nothing sensitive is staged
git diff --cached --name-only
# Check: no .env, no CSVs with client data, no credentials

# 6. First commit
git commit -m "Initial project setup"

# 7. Create private repo and push
gh repo create FionaTF/{repo-name} --private
git remote add origin https://github.com/FionaTF/{repo-name}.git
git push -u origin main
```

### What goes in Git vs stays on Drive

| In Git | On Drive only |
|--------|--------------|
| Scripts, scraper code | Raw data (CSVs, JSONs) |
| Schemas | Client documents |
| .gitignore | Output / generated files |
| CLAUDE.md | Video / media assets |
| Config templates (.env.example) | Real .env files |
| docs/ (if not sensitive) | Credentials |

---

## Secret Management Mid-Project

When API keys enter a project that started without them:

### Step 1: Never put secrets in project files
Even if the project isn't in Git yet. Shared Google Drive = shared access.

### Step 2: Use ~/.env.{project} for project-specific keys
```bash
# Create a project-specific env file outside the project directory
echo 'SERVICE_API_KEY=sk-...' >> ~/.env.{project}

# Or use a shared global env file if keys span projects
echo 'SHARED_API_KEY=sk-...' >> ~/.env.global
```

### Step 3: Add to shell profile for persistence
```bash
# In ~/.zshrc
export SERVICE_API_KEY="sk-..."
# Or source from a file at shell start:
export $(cat ~/.env.{project} | grep -v '^#' | xargs)
```

### Step 4: Reference in scripts via environment
```python
import os
api_key = os.environ["SERVICE_API_KEY"]  # never hardcode
```

### Step 5: If project gets Git later
The .gitignore template above already excludes .env files. But verify:
```bash
# Before any commit, check for leaked secrets
grep -r "sk-\|api_key\|password\|secret" scripts/ scraper/
```

### Step 6: Placeholder .env in project
Leave a `.env.example` or `.env` with empty values so collaborators know what's needed:
```
# Real keys stored outside the project (e.g. ~/.env.{project}) — do NOT put values here
SERVICE_API_KEY=
ANTHROPIC_API_KEY=
```

---

## Scaling Patterns

### When output/ gets big
Sub-organize by workstream or phase:
```
output/
├── phase1_discovery/
├── phase2_entityA/
├── phase2_entityB/
├── phase2_entityC/
├── dashboard_data.json
├── video_screenshots/
└── frontend_prompt_v2.md
```

### When a project spans multiple entities (regions, clients, segments)
Sub-organize by entity across all relevant folders — data, scripts results, output, and docs:
```
# Multi-entity project (e.g. multi-region)
data/sources/{regionA,regionB,regionC}/
scripts/scrape/scrape_results/{regionA,regionB,regionC}/
output/{regionA,regionB,regionC}/
docs/reference/regionA_Rules.md   # entity-specific docs

# docs/ organized by purpose, not entity — entity-specific files named with prefix
docs/
├── reference/          # Compliance rules, regulatory docs, matching principles
├── plans/              # Build plans, workstream plans
├── meetings/           # Comms log, session notes, meeting prep
├── deliverables/       # Client-facing decks, scope docs
├── internal/           # Internal-only docs
└── thinking/           # Decision rationale, design docs
```

Key principle: **data and output split by entity, docs split by purpose.** An entity-specific doc (like compliance rules for one airport) goes in the right purpose folder with a clear name prefix, not in an entity subfolder under docs.

### When adding a new workstream
Create its folder immediately — don't let files accumulate at root:
```bash
# Adding video production? Create the structure now
mkdir -p "Video Edit"/{raw,cuts,exports}
```

### When collaborators join
- Add a CLAUDE.md or README at root explaining the folder structure
- Document where secrets live (not the secrets themselves)
- Note which folders are Git-tracked vs Drive-only
