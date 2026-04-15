# Mac Studio — Pending Environment Setup
# Run these commands in Terminal on Mac Studio next office visit

echo 'export CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1' >> ~/.zshrc
echo 'export CLAUDE_CODE_AUTO_COMPACT_WINDOW=400000' >> ~/.zshrc
echo 'export CLAUDE_CODE_SUBAGENT_MODEL=claude-sonnet-4-6' >> ~/.zshrc
echo 'export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=true' >> ~/.zshrc
echo 'export CLAUDE_CODE_DISABLE_NONSTREAMING_FALLBACK=1' >> ~/.zshrc
echo 'export CLAUDE_CODE_ENABLE_FINE_GRAINED_TOOL_STREAMING=1' >> ~/.zshrc
echo 'export MCP_SERVER_CONNECTION_BATCH_SIZE=6' >> ~/.zshrc
echo 'export MCP_CONNECTION_NONBLOCKING=1' >> ~/.zshrc
source ~/.zshrc

# Then run MCP installs:
claude mcp add -s user playwright -- npx @playwright/mcp@latest
claude mcp add --transport http transcript-api https://transcriptapi.com/mcp
# GitHub MCP requires PAT — see phase1-mcp-installs.md
git clone https://github.com/zarazhangrui/follow-builders.git ~/.claude/skills/follow-builders
cd ~/.claude/skills/follow-builders/scripts && npm install

# Copy the ## Proactive Tool Recommendations section from PC's ~/.claude/CLAUDE.md to Mac's ~/.claude/CLAUDE.md
