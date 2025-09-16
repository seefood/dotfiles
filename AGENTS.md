# Agent Instructions for Dotfiles Repository

## Build/Lint/Test Commands

- **Lint**: `pre-commit run --all-files` (runs shellcheck, shfmt, whitespace checks)
- **Format**: `pre-commit run shfmt --all-files`
- **Test single file**: No specific test runner; use shellcheck directly: `shellcheck path/to/script.sh`
- **Full test suite**: Run pre-commit hooks: `pre-commit install && pre-commit run --all-files`

## Code Style Guidelines

### Shell Scripts

- Use `#!/bin/bash` shebang
- Enable strict mode: `set -e` at script start
- Use `local` for function variables
- Functions: lowercase with underscores, e.g., `path_remove()`
- Error handling: Check command success with `|| { echo "error"; exit 1; }`

### Formatting (EditorConfig)

- **Indentation**: Tabs (4 spaces) for most files, spaces (4) for Python
- **Line endings**: LF (Unix)
- **Encoding**: UTF-8
- **Final newline**: Required
- **Trim whitespace**: Yes
- **JSON/YAML/Markdown**: 2 spaces indentation

### Naming Conventions

- Functions: snake_case (e.g., `path_append`, `yaml2json`)
- Variables: lowercase with underscores
- Environment variables: UPPERCASE
- Files: lowercase with hyphens for scripts

### Imports and Dependencies

- Use full paths in PATH modifications
- Check directory existence: `[[ -d ${path} ]] && PATH="$(path_prepend "${path}" "${PATH}")"`
- Prefer local installations over system-wide

### Error Handling

- Use `set -e` for script failure on errors
- Check command availability: `hash command 2>/dev/null || { echo "install command first"; exit 1; }`
- Provide clear error messages with context
