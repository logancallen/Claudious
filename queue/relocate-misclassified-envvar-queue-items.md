# QUEUED: Relocate Misclassified Env-Var Queue Items to proposals/

**Classification:** QUEUED (SAFE + HIGH + TRIVIAL, file ops within repo)
**Risk:** SAFE — structural cleanup only, content preserved

## Why Queued
Two items in `queue/` require shell-profile edits, which violates the queue rule:

> IMPORTANT: Queue items must ONLY modify .md files within the Claudious repo. If a change requires CLI commands, external file access, or system-level action, it goes to proposals/ regardless of risk level.

Affected files:
1. `queue/fine-grained-tool-streaming-env-var.md` — requires adding `CLAUDE_CODE_ENABLE_FINE_GRAINED_TOOL_STREAMING=1` to shell profile on Mac + PC
2. `queue/mcp-connection-batch-size-env-vars.md` — requires adding `MCP_SERVER_CONNECTION_BATCH_SIZE=6` and `MCP_CONNECTION_NONBLOCKING=1` to shell profile on Mac + PC

Both were misclassified as auto-deployable. They are SAFE and HIGH-impact, but the implementation step lives outside the Claudious repo.

## Implementation Steps
1. `git mv queue/fine-grained-tool-streaming-env-var.md proposals/fine-grained-tool-streaming-env-var.md`
2. `git mv queue/mcp-connection-batch-size-env-vars.md proposals/mcp-connection-batch-size-env-vars.md`
3. Inside each moved file, change header line from `# QUEUED:` to `# PROPOSAL:` and update the `**Classification:**` line to `PROPOSAL (SAFE + HIGH, requires shell-profile edit)`

## Verification
- `queue/` contains only items that edit `.md` files inside the repo
- Both moved items preserve their content in `proposals/`
- Headers reflect proposal status, not queued status

## Applies To
`queue/` and `proposals/` structure — all ops inside Claudious repo.
