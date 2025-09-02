# Global Installation Preferences

# Package Manager Isolation Preferences

Always prefer isolated installation methods over system-wide global installs:

- **Python**: `uv tool install` (best for disk space with shared caching) > `pip install --user` > virtual environments
- **Node.js**: `npx` for one-time runs > local project installs > `npm install -g` 
- **Rust**: `cargo install` (automatically isolates to `~/.cargo/bin`)
- **Go**: `go install` (automatically isolates to `$GOPATH/bin`)  
- **Ruby**: `gem install --user-install` > system gems

General rule: Use package manager tools that isolate installations rather than polluting system directories. Only suggest system-wide installation when tools specifically require it or when isolation methods have compatibility issues.

# Solution Guidelines

- Never improvise solutions that are not documented in official tool/module instructions
- If you have a guess, check it against official documentation first
- Do not offer solutions without verifying they exist in official docs
- If official docs are exhausted, check community forums and blogs
- If all resources are exhausted and you only have a guess, explicitly state "This is my guess" and don't present it as a definitive solution

# CLAUDE.md File Management

- Always commit changes to this file to the dotfiles repository after modifications
- Check once per day if the remote dotfiles repository has updates to this file and pull if needed
- Use `cd ~/.homesick/repos/dotfiles && git add home/.claude/CLAUDE.md && git commit -m "Update Claude Code global settings" && git push` to sync changes
- Use `cd ~/.homesick/repos/dotfiles && git pull` to get remote updates

# Display Preferences

- Always show todo list by default - user should not need to press Ctrl-T to see progress
- Expose reasoning process and thinking steps throughout task execution