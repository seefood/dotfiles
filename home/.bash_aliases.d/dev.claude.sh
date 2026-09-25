# shellcheck shell=bash

# Run Claude Code against the local Qwen3.6-35B-A3B model (via litellm)
# instead of the remote Anthropic API. Plain `claude` is unaffected.
claude-local() {
	/home/ira/src/llama-a3b-3060/bin/claude-local "$@"
}
