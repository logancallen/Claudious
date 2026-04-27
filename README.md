# Claudious

Shared state store for Logan's Claude Projects. Three manually-maintained canonical files attached as project knowledge across every Claude Project.

## The three files

| File | Contents |
|---|---|
| `canonical/state.md` | Current Claude models, Claude Code, toolchain (MCPs, skills, plugins) |
| `canonical/playbook.md` | Prompting rules + antipatterns |
| `canonical/changelog.md` | What changed and when |

## Updating

1. Edit the relevant file.
2. Bump `Last updated:` at the top.
3. Add a one-line entry to `changelog.md`.
4. `git add canonical/ && git commit -m "canonical: <file> — <what>" && git push`
5. Click Sync in each connected Claude Project.

No pipeline, no routines, no autonomous writes. State is current because Logan keeps it current.

## Rollback

```bash
# Windows
bash "C:/Users/logan/Projects/Claudious/scripts/rollback-config.sh" YYYY-MM-DD

# Mac
bash ~/Projects/claudious/scripts/rollback-config.sh YYYY-MM-DD
```

Or `git revert <sha>` on the offending commit.
