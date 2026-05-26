#!/bin/bash
# setup.sh — optional global install for claude-consult
#
# DEFAULT (no flag): does nothing — tells you to just `cd` into this directory
#                    and run `claude`. The project's CLAUDE.md will load
#                    automatically and your global config is not touched.
#
# --global: copies (or symlinks) skills/ into ~/.claude/skills/ so the skills
#           are available from any directory. Then PRINTS a snippet for your
#           global ~/.claude/CLAUDE.md — never writes it. You paste it yourself.
#
# This script will not silently modify your global CLAUDE.md.

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL_SKILLS_DIR="$HOME/.claude/skills"
GLOBAL_CLAUDE_MD="$HOME/.claude/CLAUDE.md"

# Skills to install globally (just the 13 in this repo)
SKILLS=(
  analyst em partner intake pressure-test
  problem-solving review gap-check
  make-slides markdown-to-word
  project-hygiene session-capture find-skills
)

usage() {
  cat <<EOF
Usage:
  ./setup.sh              Show install options (default — does nothing)
  ./setup.sh --global     Install skills into ~/.claude/skills/ and print the
                          CLAUDE.md snippet to add to your global config.
  ./setup.sh --uninstall  Remove the skills from ~/.claude/skills/.
  ./setup.sh --help       Show this message.

Project-scoped use (no install needed):
  cd $(basename "$REPO_DIR") && claude
EOF
}

print_snippet() {
  cat <<'EOF'

# ─────────────────────────────────────────────────────────────────
# Add THIS to your ~/.claude/CLAUDE.md (anywhere; bottom is fine):
# ─────────────────────────────────────────────────────────────────

## claude-consult skills

If the user asks for problem-solving, review, or session-end retrospective:

- `problem-solving` — four-stage facilitation for a new project or scope change (helpers: `intake`, `pressure-test`)
- `review` — runs evaluators (`analyst`, `em`, `partner`) on a completed artifact, scaled to risk
- `gap-check` — session-end retrospective: did the review protocol catch everything?

Utility skills:
- `make-slides`, `markdown-to-word`, `project-hygiene`, `session-capture`, `find-skills`

Self-evaluation protocol: before presenting any artifact the user would ship,
run `review` first. Tier the evaluator team by risk: internal → skip;
client-facing data → `analyst` only; senior stakeholder material → all three.

Full framework: github.com/thefinono/claude-consult

# ─────────────────────────────────────────────────────────────────
EOF
}

case "${1:-}" in
  --global)
    echo "Installing claude-consult skills globally..."
    echo ""

    if [ ! -d "$HOME/.claude" ]; then
      mkdir -p "$HOME/.claude"
      echo "Created $HOME/.claude/"
    fi

    if [ ! -d "$GLOBAL_SKILLS_DIR" ]; then
      mkdir -p "$GLOBAL_SKILLS_DIR"
      echo "Created $GLOBAL_SKILLS_DIR/"
    fi

    echo ""
    echo "Symlink (recommended — auto-updates when you pull) or copy?"
    echo "  1) symlink  (recommended)"
    echo "  2) copy"
    read -r -p "Choice [1]: " choice
    choice="${choice:-1}"

    for skill in "${SKILLS[@]}"; do
      src="$REPO_DIR/skills/$skill"
      dst="$GLOBAL_SKILLS_DIR/$skill"
      if [ ! -d "$src" ]; then
        echo "  skip: $skill (not in repo)"
        continue
      fi
      if [ -e "$dst" ] || [ -L "$dst" ]; then
        echo "  exists: $dst (skipping — remove it first if you want to reinstall)"
        continue
      fi
      if [ "$choice" = "1" ]; then
        ln -s "$src" "$dst"
        echo "  symlinked: $dst"
      else
        cp -R "$src" "$dst"
        echo "  copied:    $dst"
      fi
    done

    echo ""
    echo "Skills installed. The following snippet is what to add to your global"
    echo "CLAUDE.md. This script will NOT write it for you — you paste it."
    print_snippet

    if [ -f "$GLOBAL_CLAUDE_MD" ]; then
      echo "Your existing global CLAUDE.md: $GLOBAL_CLAUDE_MD"
      echo "(left untouched)"
    else
      echo "You don't have a global CLAUDE.md yet — create one at: $GLOBAL_CLAUDE_MD"
    fi
    ;;

  --uninstall)
    echo "Removing claude-consult skills from $GLOBAL_SKILLS_DIR/..."
    for skill in "${SKILLS[@]}"; do
      dst="$GLOBAL_SKILLS_DIR/$skill"
      if [ -L "$dst" ] || [ -d "$dst" ]; then
        rm -rf "$dst"
        echo "  removed: $skill"
      fi
    done
    echo ""
    echo "Done. The snippet you added to ~/.claude/CLAUDE.md is still there —"
    echo "remove it manually if you want it gone."
    ;;

  --help|-h)
    usage
    ;;

  "")
    usage
    echo ""
    echo "No flag passed — nothing changed on your system."
    ;;

  *)
    echo "Unknown option: $1"
    echo ""
    usage
    exit 1
    ;;
esac
