# Global Installation Preferences

Prefer `uv tool install` for Python tools and packages when it's optimal for disk space usage (uv provides shared caching and deduplication). Fall back to `pip install --user` or virtual environments when uv compatibility issues exist or when tools specifically recommend pip installation. Never suggest installing packages globally without proper isolation.

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