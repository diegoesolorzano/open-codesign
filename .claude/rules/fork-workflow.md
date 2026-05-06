# Fork Workflow

This repo is a fork of `OpenCoworkAI/open-codesign`. Two remotes exist:

- `origin` — our fork (`diegoesolorzano/open-codesign`), where we push
- `upstream` — the original repo (`OpenCoworkAI/open-codesign`), read-only

## Syncing upstream changes

```bash
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
git checkout custom/app
git merge main
```

Always resolve conflicts on `custom/app`, never on `main`. The `main` branch must be a clean mirror of upstream.

## Contributing back

To send a fix or improvement upstream:

1. Create a branch from `main` (not from `custom/app`)
2. Make the change
3. Push to `origin`
4. Open a PR against `OpenCoworkAI/open-codesign`

Never PR from `custom/app` — it contains our custom code that upstream doesn't want.

## Branch conventions

| Branch | Purpose | Push to |
|---|---|---|
| `main` | Mirror of upstream | origin (after sync) |
| `custom/app` | Our custom TypeScript app | origin |
| `custom/*` | Other custom work | origin |
| `fix/*` | Fixes to contribute upstream | origin, then PR to upstream |
