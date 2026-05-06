#!/usr/bin/env bash
set -euo pipefail

# Recreates the bare+worktree structure for this fork.
# Run from the PARENT directory where you want open-codesign/ created.
#
# Usage:
#   cd /Volumes/External/Workspace/PERSONALES-GIT
#   bash open-codesign/custom-app/scripts/bootstrap-worktrees.sh
#
# Or from scratch (after cloning just to get this script):
#   curl -fsSL https://raw.githubusercontent.com/diegoesolorzano/open-codesign/custom/app/scripts/bootstrap-worktrees.sh | bash

FORK_REMOTE="git@github.com:diegoesolorzano/open-codesign.git"
UPSTREAM_REMOTE="https://github.com/OpenCoworkAI/open-codesign.git"
DIR_NAME="open-codesign"

if [ -d "$DIR_NAME/.bare" ]; then
  echo "Error: $DIR_NAME/.bare already exists. Remove it first or run from a different directory."
  exit 1
fi

echo "==> Creating bare clone from fork..."
mkdir -p "$DIR_NAME"
git clone --bare "$FORK_REMOTE" "$DIR_NAME/.bare"

echo "==> Setting up .git pointer..."
echo "gitdir: ./.bare" > "$DIR_NAME/.git"

echo "==> Adding upstream remote..."
git -C "$DIR_NAME/.bare" remote add upstream "$UPSTREAM_REMOTE" 2>/dev/null || true
git -C "$DIR_NAME/.bare" fetch upstream

echo "==> Fetching all branches from origin..."
git -C "$DIR_NAME/.bare" fetch origin

echo "==> Creating worktree: main (upstream sync)..."
git -C "$DIR_NAME" worktree add main main

echo "==> Creating worktree: custom-app (development)..."
if git -C "$DIR_NAME/.bare" rev-parse --verify "origin/custom/app" >/dev/null 2>&1; then
  git -C "$DIR_NAME" worktree add custom-app custom/app
else
  git -C "$DIR_NAME" worktree add custom-app -b custom/app
fi

echo ""
echo "Done. Structure:"
echo ""
echo "  $DIR_NAME/"
echo "    .bare/        bare git repo"
echo "    main/         worktree: main (upstream sync only)"
echo "    custom-app/   worktree: custom/app (development)"
echo ""
echo "Remotes:"
git -C "$DIR_NAME/.bare" remote -v
echo ""
echo "Worktrees:"
git -C "$DIR_NAME/.bare" worktree list
