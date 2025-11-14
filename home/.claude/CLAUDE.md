# CRITICAL RULES - PRIORITY 1

## Verification

- Before suggesting commands/configs/implementations: State "Let me verify this approach in official documentation"
- If cannot verify: State "I cannot verify this approach exists/works"
- If uncertain: State "This is unverified/my guess"
- Never suggest unverified: install commands, config syntax, API usage, CLI flags, file paths, deployment steps

## Git Operations

- Commit after every completed task
- Git commit successful only if exit code = 0
- NEVER use `commit --no-verify` without explicit user permission
- If pre-commit hooks fail: STOP, ask user how to proceed
- Task is NOT complete until commit passes hooks cleanly

## Environment Management

- Python: ALWAYS `uv sync --frozen`, NEVER `uv venv + uv pip install`. same for pixi, npm, etc.
- After pyproject.toml / pixi.toml changes: `uv lock` then commit lock file
- All package managers: ONLY use locked/frozen modes at build time / CI
- Always mark lock files as binary in .gitattributes

## Code Quality

- Before task completion: Run `mcp__ide__getDiagnostics`
- Fix all linting/type errors before considering task complete
- Apply to any file created/modified

## Communication

- Show expanded todo list by default
- Avoid pleasantries ("excellent question", etc.)
- Assume talking to senior engineer

# STANDARD RULES - PRIORITY 2

## Git Workflow

- Small commits better than large
- Descriptive commit messages
- Update documentation when relevant
- Feature branch naming: `feature-name/###-phase-name` (e.g., `queue-ui/001-specification`, `multiqueue/003-phase-2`)
  - Format: lowercase-with-hyphens / three-digit-number - lowercase-with-hyphens
  - Never merge to default branch without explicit user request
  - Each feature typically has multiple phases with sequential numbering

## Package Management

- Prefer isolation over system-wide: `uv tool install` > `pip install --user`
- Node: `npx` > local installs > global

## CLAUDE.md Management

- Commit changes to dotfiles repo after modifications
- Pull remote updates daily: `cd ~/.homesick/repos/dotfiles && git pull`
- Sync command: `cd ~/.homesick/repos/dotfiles && git add home/.claude/ && git commit -m "Update Claude Code global settings" && git push`

# SELF-IMPROVEMENT

## Rule Updates

- New tech/pattern used in 3+ files → add rule
- Common bugs preventable → add rule
- Code review feedback repeated → add rule
- Better examples found → update rule
- Edge cases discovered → modify rule

## Pattern Recognition

- Monitor repeated implementations across files
- Track common error patterns
- Watch for emerging best practices
- Update rules after major refactors
- Keep examples synchronized with codebase

## Rule Management

- Mark outdated patterns as deprecated
- Remove rules that no longer apply
- Document migration paths for old patterns
- Cross-reference related rules

# ERROR PATTERNS TO AVOID

## Rule Following Failures

- Dense files with mixed priorities reduce rule retrieval
- Most critical rules get lost in volume
- 50KB max recommended for optimal performance
- you can be a bit less verbose, I am a senior engineer
