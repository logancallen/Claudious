# gh-availability test — 2026-04-24

**Purpose:** Decide Session #5 fix path (Option 2 self-PR vs Option 3b orphan reconciler).

**Prior evidence (archive/handoffs/2026-04-20-1534.md):** "MCP github tools unavailable, gh CLI blocked" during 2026-04-20 Process run. 4 days old at time of this test.

## Raw probe output

```
=== DATE ===
Fri Apr 24 06:35:05 UTC 2026

=== WHICH gh ===
exit: 0

=== gh --version ===
/bin/bash: line 66: gh: command not found
exit: 0

=== gh auth status ===
/bin/bash: line 71: gh: command not found
exit: 0

=== gh api /repos/logancallen/Claudious (permission probe) ===
/bin/bash: line 76: gh: command not found
exit: 0

=== gh pr list --limit 1 (read probe) ===
/bin/bash: line 81: gh: command not found
exit: 0

=== env vars (filtered for GH/GITHUB/TOKEN) ===
CODESIGN_MCP_TOKEN=<redacted>

=== runtime identity ===
root
Linux runsc 4.4.0 #1 SMP Sun Jan 10 15:06:54 PST 2016 x86_64 x86_64 x86_64 GNU/Linux
/home/user/Claudious

=== git remote config ===
origin	http://local_proxy@127.0.0.1:65241/git/logancallen/Claudious (fetch)
origin	http://local_proxy@127.0.0.1:65241/git/logancallen/Claudious (push)
remote.origin.url http://local_proxy@127.0.0.1:65241/git/logancallen/Claudious
remote.origin.fetch +refs/heads/*:refs/remotes/origin/*

=== git push dry-run (tests push auth path) ===
To http://127.0.0.1:65241/git/logancallen/Claudious
 * [new branch]      HEAD -> claude/gh-availability-probe-1777012492
exit: 0


=== MCP github tools ===
none
```


## Derived verdict

- gh CLI present: no
- gh authenticated: unknown
- gh read access to repo: unknown
- MCP github tools visible: see section above

## Decision matrix

| gh present | gh authed | gh read | → Session #5 fix path |
|------------|-----------|---------|----------------------|
| yes        | yes       | yes     | **Option 2** (routine self-PRs in Section 5) |
| yes        | yes       | no      | Option 2 with read-only fallback, or Option 3b |
| yes        | no        | —       | Option 3b (auth blocker too deep) |
| no         | —         | —       | Option 3b (no CLI = reconciler workflow only path) |

## Result

gh_present=no
gh_auth=unknown
gh_read=unknown

Recommend Option 2 if row 1 matches. Otherwise Option 3b.
