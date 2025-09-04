# Global Installation Preferences

# Package Manager Isolation Preferences

Always prefer isolated installation methods over system-wide global installs:

- **Python**: `uv tool install` (best for disk space with shared caching) > `pip install --user` > virtual environments
- **Node.js**: `npx` for one-time runs > local project installs > `npm install -g`
- **Rust**: `cargo install` (automatically isolates to `~/.cargo/bin`)
- **Go**: `go install` (automatically isolates to `$GOPATH/bin`)
- **Ruby**: `gem install --user-install` > system gems

General rule: Use package manager tools that isolate installations rather than polluting system directories. Only suggest system-wide installation when tools specifically require it or when isolation methods have compatibility issues.

# SOLUTION VERIFICATION - PRIME DIRECTIVE

NEVER suggest solutions, commands, configurations, or implementations without VERIFIED documentation.

MANDATORY verification process for ALL technical suggestions:
1. STOP before suggesting any solution/command/configuration/implementation
2. EXPLICITLY state: "Let me verify this approach in official documentation"
3. If I cannot verify: MUST say "I cannot verify this approach exists/works"
4. If uncertain: MUST say "This is unverified/my guess" and present as such

FORBIDDEN - Do not suggest without verification:
- Installation commands or package names
- Configuration syntax or parameters
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

VIOLATION CONSEQUENCE:
Each wrong answer wastes user time, breaks trust, and can break systems.
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
