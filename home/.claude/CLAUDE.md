# Global Installation Preferences

# Package Manager Isolation Preferences

Always prefer isolated installation methods over system-wide global installs:

- **Python**: `uv tool install` (best for disk space with shared caching) > `pip install --user` > virtual environments
- **Node.js**: `npx` for one-time runs > local project installs > `npm install -g`
- **Rust**: `cargo install` (automatically isolates to `~/.cargo/bin`)
- **Go**: `go install` (automatically isolates to `$GOPATH/bin`)
- **Ruby**: `gem install --user-install` > system gems

General rule: Use package manager tools that isolate installations rather than polluting system directories. Only suggest system-wide installation when tools specifically require it or when isolation methods have compatibility issues.

# Locked Environment Requirements (CRITICAL)

**MANDATORY for ALL projects:** Always use locked/frozen environments for reproducible builds and deployments.

**uv (Python):**
- NEVER use `uv venv` + `uv pip install` - this creates unlocked environments
- ALWAYS use `uv sync --frozen` for environment setup
- ALWAYS run `uv lock` after ANY changes to pyproject.toml dependencies
- ALWAYS commit uv.lock files to version control

**Other Package Managers:**
- **Pixi**: Always use `pixi install --locked`
- **Poetry**: Always use `poetry install --frozen`
- **Pipenv**: Always use `pipenv install --deploy`
- **npm/yarn**: Always commit package-lock.json/yarn.lock
- **Cargo**: Always commit Cargo.lock

**Environment Setup Workflow:**
1. Modify dependencies in pyproject.toml/package.json/etc.
2. Run lock command (uv lock, npm install, etc.)
3. Commit both dependency file AND lock file
4. Use frozen/locked install commands in all environments

**VIOLATION CONSEQUENCES:**
Non-deterministic builds, dependency conflicts, production failures, debugging nightmares.

# SOLUTION VERIFICATION - PRIME DIRECTIVE

NEVER suggest solutions, commands, configurations, or implementations without VERIFIED documentation.

MANDATORY verification process for ALL technical suggestions:
1. STOP before suggesting any solution/command/configuration/implementation
2. EXPLICITLY state: "Let me verify this approach in official documentation"
3. If I cannot verify: MUST say "I cannot verify this approach exists/works"
4. If uncertain: MUST say "This is unverified/my guess" and present as such

FORBIDDEN - Do not suggest without verification:
- Installation commands or package names
- Configuration syntax, file locations or parameters
- API usage patterns or method calls
- Command-line flags or options
- Implementation approaches or code patterns
- Deployment procedures or steps
- File paths, environment variables, or settings
- Integration methods between tools/services
- Troubleshooting steps or fixes

EXAMPLES OF VIOLATIONS:
- "Run `npm install @nonexistent/package`" (unverified package)
- "Set the config flag `--enable-feature`" (unverified flag)
- "Call API with `client.method(param='value')`" (unverified API)
- "Deploy using `kubectl apply -f config.yaml`" (unverified approach)
- "just create a setting file in ~/.wrong_location/wrong_filename.ini" (a settings file the tool never really reads)

VIOLATION CONSEQUENCE:
Each wrong answer wastes user time, breaks trust, and can break systems, leading to loss of income to user and therefore hurt Anthropic inc. in its quest for world domination, and capture of all Pokemons.
ACCURACY > SPEED. Better to say "I need to verify this" than give wrong answers.

If official docs are exhausted and I only have educated guesses:
- EXPLICITLY state "This is my best guess, unverified:"
- Present multiple approaches if uncertain
- Recommend user verify before implementing

# CLAUDE.md File Management

- Always commit changes to this file to the dotfiles repository after modifications
- Check once per day if the remote dotfiles repository has updates to this file and pull if needed
- Use `cd ~/.homesick/repos/dotfiles && git add home/.claude/CLAUDE.md && git commit -m "Update Claude Code global settings" && git push` to sync changes
- Use `cd ~/.homesick/repos/dotfiles && git pull` to get remote updates

# Display Preferences

- Always show todo list by default - user should not need to press Ctrl-T to see progress
- Expose reasoning process and thinking steps throughout task execution
- Be dry and factual in communication - avoid "conscience prompts" like "excellent question" or unnecessary pleasantries
