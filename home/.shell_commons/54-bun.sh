# shellcheck shell=bash

# Added by claude-mem plugin: https://marketplace.anthropic.com/marketplace/thedotmack/claude-mem

# bun completions
[ -s "/$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

alias claude-mem='~/.bun/bin/bun "$HOME/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"'
