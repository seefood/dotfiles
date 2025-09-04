# Git commit everything

Whenever editing files in a git repo (which is most of the time):

- Every time a task is done, create a commit. That means also update Claude.md, README, infrastructure docs if relevant.
- Commit on every task finish, small commits are better than larger ones, allows the user to roll back or squash later.
- Use descriptive commit messages to capture the full scope of the changes.

## EXTREMELY IMPORTANT: Code Quality Checks

**ALWAYS run the following commands before completing any task:**

Automatically use the IDE's built-in diagnostics tool to check for linting and type errors:

   - Run `mcp__ide__getDiagnostics` to check all files for diagnostics
   - Fix any linting or type errors before considering the task complete
   - Do this for any file you create or modify

This is a CRITICAL step that must NEVER be skipped when working on any code-related task.


# Global Installation Preferences

## Package Manager Isolation Preferences

Always prefer isolated installation methods over system-wide global installs:

- **Python**: `uv tool install` (best for disk space with shared caching) > `pip install --user` > virtual environments
- **Node.js**: `npx` for one-time runs > local project installs > `npm install -g`
- **Rust**: `cargo install` (automatically isolates to `~/.cargo/bin`)
- **Go**: `go install` (automatically isolates to `$GOPATH/bin`)
- **Ruby**: `gem install --user-install` > system gems

General rule: Use package manager tools that isolate installations rather than polluting system directories. Only suggest system-wide installation when tools specifically require it or when isolation methods have compatibility issues.

## Locked Environment Requirements (CRITICAL)

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

NEVER suggest solutions, commands, configurations, or implementations without Looking up Context 7 or VERIFIED/official documentation.

## Look up documentation with Context7

When code examples, setup or configuration steps, or library/API documentation are requested, use the Context7 mcp server to get the information.
If the info

## MANDATORY verification process for ALL technical suggestions

1. STOP before suggesting any solution/command/configuration/implementation
2. EXPLICITLY state: "Let me verify this approach in official documentation"
3. If I cannot verify: MUST say "I cannot verify this approach exists/works"
4. If uncertain: MUST say "This is unverified/my guess" and present as such

## FORBIDDEN - Do not suggest without verification

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

Each wrong answer wastes user time, breaks trust, and can break systems, leading to loss of income to user
and therefore hurt Anthropic inc. in its quest for world domination, and capturing of all Pokemons.
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

# UX - Display Preferences

- Always show todo list by default - user should not need to press Ctrl-T to see progress
- when I prompt you to "think", "think hard" or "ultrathink": Expose reasoning process and thinking steps throughout task execution
- Be dry and factual in communication - avoid "conscience prompts" like "excellent question" or unnecessary pleasantries
- in general, Assume you are talking to a senior engineer.

# Rule Improvement Triggers

- New code patterns not covered by existing rules
- Repeated similar implementations across files
- Common error patterns that could be prevented
- New libraries or tools being used consistently
- Emerging best practices in the codebase

## Analysis Process:
- Compare new code with existing rules
- Identify patterns that should be standardized
- Look for references to external documentation
- Check for consistent error handling patterns
- Monitor test patterns and coverage

## Rule Updates:

- **Add New Rules When:**
  - A new technology/pattern is used in 3+ files
  - Common bugs could be prevented by a rule
  - Code reviews repeatedly mention the same feedback
  - New security or performance patterns emerge

- **Modify Existing Rules When:**
  - Better examples exist in the codebase
  - Additional edge cases are discovered
  - Related rules have been updated
  - Implementation details have changed

- **Example Pattern Recognition:**

  ```typescript
  // If you see repeated patterns like:
  const data = await prisma.user.findMany({
    select: { id: true, email: true },
    where: { status: 'ACTIVE' }
  });

  // Consider adding to [prisma.mdc](mdc:shipixen/.cursor/rules/prisma.mdc):
  // - Standard select fields
  // - Common where conditions
  // - Performance optimization patterns
  ```

- **Rule Quality Checks:**
- Rules should be actionable and specific
- Examples should come from actual code
- References should be up to date
- Patterns should be consistently enforced

## Continuous Improvement:

- Monitor code review comments
- Track common development questions
- Update rules after major refactors
- Add links to relevant documentation
- Cross-reference related rules

## Rule Deprecation

- Mark outdated patterns as deprecated
- Remove rules that no longer apply
- Update references to deprecated rules
- Document migration paths for old patterns

## Documentation Updates:

- Keep examples synchronized with code
- Update references to external docs
- Maintain links between related rules
- Document breaking changes
