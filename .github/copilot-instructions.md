# Copilot Instructions

This is a personal Linux dotfiles and development environment repository. It contains shell configurations, editor setups, Docker tooling, and utility scripts.

## Setup Commands

```bash
# Full environment setup (runs symlinks + installs)
./setup_all.sh

# Create config symlinks only (links configs into ~/.config/ and ~/)
config/set_sym_links.sh

# Install apt packages (all categories)
scripts/linux_tools.sh

# Install apt packages (handy subset only)
scripts/linux_tools.sh handy

# Install Rust toolchain
scripts/install_rust.sh

# Install Rust CLI tools (bat, ripgrep, lsd, git-delta, starship, etc.)
scripts/install_rust_tools.sh
```

## Docker Workflow

```bash
# Build and run interactively
scripts/run.sh

# Mount a working directory
scripts/run.sh -w /path/to/project

# Force rebuild without cache
scripts/run.sh -f

# Build image only
scripts/run.sh -b

# Run privileged (e.g., for CAN bus or hardware access)
scripts/run.sh -p

# Pass extra docker args
scripts/run.sh -- --env MY_VAR=value
```

Two Dockerfiles exist: `docker/Dockerfile` (Ubuntu 22.04) and `docker/Dockerfile_U24` (Ubuntu 24.04). The entrypoint remaps container UID/GID to the host user's to preserve file ownership on mounted volumes.

## Architecture

### Config Symlink System
`config/set_sym_links.sh` is the central wiring script. It symlinks everything in `config/` to the expected locations (`~/.config/`, `~/`, etc.). Editing a file in `config/` and re-running the script is all that's needed to apply changes.

### Neovim Config
Located at `config/nvim/`. Entry point is `init.lua`, which bootstraps [lazy.nvim](https://github.com/folke/lazy.nvim). All modules live under `lua/feather/`:
- `core/` — vim options and keymaps
- `plugins/` — one file per plugin, each returning a lazy.nvim spec table (`return { "author/plugin", ... }`)

### Shell Config Layering
- `config/bash_files/bashrc` — interactive shell entry point
- `config/bash_files/bash_aliases` — aliases (also sourced by fish via `bash_to.fish`)
- `config/bash_files/bash_profile` — login shell config
- Fish shell aliases mirror bash aliases to keep both shells consistent.

### SafeEnvironment/
Isolated Neovim modules not yet integrated into the main config. Currently contains `haptic-hover/`, a Lua module that fires haptic feedback (via an external Python script) on LSP hover events. It hooks `vim.lsp.handlers["textDocument/hover"]` with a 500ms debounce. Commands: `HapticHoverToggle`, `HapticHoverSetPattern <pattern>`.

## Key Conventions

- **Shell scripts** use `#!/usr/bin/env bash` and source `scripts/common.sh` for shared utilities (e.g., `is_command()` to check if a binary exists before installing).
- **Package lists** are defined as bash arrays (e.g., `PACKAGES_BASE`, `PACKAGES_HANDY`) at the top of installer scripts.
- **Neovim plugins** each get their own file in `config/nvim/lua/feather/plugins/` returning a single lazy.nvim spec table.
- **`bin/` utilities** are short, lowercase, no extension (e.g., `canup`, `reclaim`). Add new host utilities here.
- **Docker user**: default username `rocs`, password `feather`, timezone `US/Arizona`. The entrypoint script handles UID/GID remapping automatically.
- **Config naming**: directories match tool names exactly (`alacritty`, `nvim`, `tmux`, `fish`, `helix`).
- **Alacritty themes** live in a git submodule at `config/alacritty/alacritty-theme/`.
