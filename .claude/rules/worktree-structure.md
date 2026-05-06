# Worktree Structure

This repo uses a bare clone + git worktrees layout for parallel development.

## Directory layout

```
open-codesign/
  .bare/          # bare git repo (objects, refs, config)
  .git            # pointer file: "gitdir: ./.bare"
  main/           # worktree: branch main (upstream sync only)
  custom-app/     # worktree: branch custom/app (our development)
```

## Rules

- **Never edit files directly in `main/`** — it exists only for upstream sync operations
- **All development happens in `custom-app/`** or in new worktrees
- **Never run `pnpm install` in the bare root** — always `cd` into a worktree first

## Creating a new worktree

```bash
cd /Volumes/External/Workspace/PERSONALES-GIT/open-codesign
git worktree add <directory-name> -b <branch-name>
```

## Listing worktrees

```bash
git -C /Volumes/External/Workspace/PERSONALES-GIT/open-codesign/.bare worktree list
```

## Removing a worktree

```bash
git -C /Volumes/External/Workspace/PERSONALES-GIT/open-codesign/.bare worktree remove <directory-name>
```

Do NOT delete worktree directories manually — always use `git worktree remove` to keep git refs clean.
