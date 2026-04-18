# Dotfiles

A collection of configuration files for a modern development environment with Neovim, Zsh, tmux, and WezTerm.

## Features

- **Neovim**: Modern vim configuration with LSP, completion, and plugin management via lazy.nvim
- **Zsh**: Enhanced shell with autosuggestions, syntax highlighting, and custom prompt
- **tmux**: Terminal multiplexer with vim-like keybindings
- **WezTerm**: GPU-accelerated terminal emulator configuration
- **Claude**: AI assistant skill integration

## Quick Start

1. Install dependencies (macOS):
   ```bash
   brew install neovim tmux fzf ripgrep direnv node python
   brew install --cask wezterm
   ```

2. Clone the repository:
   ```bash
   git clone <repository-url> ~/dotfiles
   cd ~/dotfiles
   ```

3. Run the installation script:
   ```bash
   ./install.sh
   ```

4. Restart your terminal or source the new configuration:
   ```bash
   source ~/.zshenv
   ```

## Dependencies

### Required
- **Zsh**: Shell
- **Git**: Version control

### Optional (for enhanced features)
- **Neovim**: Text editor
- **tmux**: Terminal multiplexer
- **WezTerm**: Terminal emulator (`brew install --cask wezterm`)
- **fzf**: Fuzzy finder
- **ripgrep**: Fast text search
- **direnv**: Environment variable management
- **Homebrew** (macOS): Package manager
- **Node.js**: Required for web/JSON LSP servers (ts_ls, html, cssls, astro, jsonls)
- **Python**: Required for Python LSP servers (pyright, ruff)

The configuration includes helpful installation hints for missing dependencies.

### PATH
The following directories are automatically added to `PATH` if they exist:
- `~/.local/bin`
- `~/bin`

## What's Included

### Neovim Configuration (`nvim/`)
- **LSP Support**: Configured for Python, Lua, Bash, Terraform, and web development
- **Plugin Management**: Uses lazy.nvim for efficient plugin loading
- **Code Completion**: nvim-cmp with LSP, LuaSnip snippets, buffer, and path sources
- **Syntax Highlighting**: Treesitter-based highlighting
- **File Navigation**: Telescope fuzzy finder integration
- **Code Formatting**: conform.nvim with auto-format on save
- **Status Line**: lualine.nvim with active LSP server display
- **Indent Guides**: indent-blankline.nvim for visual indentation
- **Schema Completion**: SchemaStore.nvim for JSON/YAML schema support
- **AI Integration**: Claude Code (`claudecode.nvim`) and GitHub Copilot support

#### LSP Servers
Language servers are automatically installed via Mason on first launch.

- Python (pyright, ruff)
- Lua (lua_ls)
- Bash (bashls)
- Terraform (terraformls, tflint)
- Web development (ts_ls, html, cssls, astro)
- JSON (jsonls with SchemaStore)

Mason also auto-installs: `stylua`, `shellcheck`, `prettier`

#### LSP Keymaps (active when LSP attaches)

| Key | Action |
|-----|--------|
| `gd` / `gD` | Go to definition / declaration |
| `gi` / `gr` | Go to implementation / references |
| `K` | Hover documentation |
| `<C-s>` | Signature help |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>f` | Format buffer |
| `<leader>D` | Go to type definition |
| `[d` / `]d` | Jump to previous / next diagnostic |
| `<leader>e` | Open diagnostic float |
| `<leader>q` | Send diagnostics to location list |

#### Code Formatting (conform.nvim)
Auto-formats on save with the following formatters:

- **Lua**: stylua
- **Terraform / HCL**: terraform_fmt
- **Astro, JSON, YAML, Markdown**: prettierd

#### GitHub Copilot Keymaps (insert mode)

| Key | Action |
|-----|--------|
| `Alt-j` | Accept suggestion |
| `Alt-l` | Accept line |
| `Alt-w` | Accept word |
| `Alt-n` | Next suggestion |
| `Alt-p` | Previous suggestion |

### Zsh Configuration (`zsh/`)
- **Enhanced Prompt**: Git status (`+` staged, `*` unstaged) and Python virtual environment indicators
- **Autocompletion**: Zsh completions with brew and AWS CLI support
- **Plugins**:
  - zsh-autosuggestions for command suggestions
  - zsh-syntax-highlighting for syntax coloring
  - zsh-completions for additional completions
- **Tool Integration**: fzf, direnv, and tmux auto-launch

### tmux Configuration (`tmux.conf`)
- **Prefix Key**: `Ctrl-j` (instead of default `Ctrl-b`)
- **Vim-like Navigation**: vi mode keys for copy mode
- **Clipboard Integration**: Copy to system clipboard with `pbcopy`
- **Pane Management**: Inherit current directory when creating new panes/windows
- **True Color Support**: 256-color terminal support

#### tmux Keybindings

| Key | Action |
|-----|--------|
| `Ctrl-j c` | New window |
| `Ctrl-j %` | Vertical split |
| `Ctrl-j "` | Horizontal split |
| `Ctrl-j H/J/K/L` | Resize panes |
| `v` | Start selection in copy mode |
| `y` | Copy selection |

### WezTerm Configuration (`wezterm.lua`)
- **Font**: UDEV Gothic 35NFLG
- **Color Scheme**: Tokyo Night Storm theme
- **Clean Interface**: Tab bar disabled for minimal look
- **Padding**: Consistent window padding

### Claude Integration (`claude/`)
- **Skills**: Specialized commit message generation
- **Neovim Integration**: claudecode.nvim with the following keymaps:

| Key | Action |
|-----|--------|
| `<leader>cc` | Toggle Claude Code panel |
| `<leader>cf` | Focus Claude Code panel |
| `<leader>cs` | Send visual selection to Claude (visual mode) |
| `<leader>cb` | Add current buffer to Claude |
| `<Esc><Esc>` | Exit terminal mode in Claude panel |

## Installation Details

The `install.sh` script creates symbolic links for all configuration files:

- **WezTerm**: `~/.config/wezterm/wezterm.lua`
- **tmux**: `~/.tmux.conf`
- **Neovim**: `~/.config/nvim/`
- **Zsh**:
  - `~/.zshenv`
  - `~/.config/zsh/.zshrc`
  - `~/.config/zsh/.zprofile`
  - `~/.config/zsh/modules/` (plugins)
- **Claude**: `~/.claude/skills/`

## Customization

### Local Overrides
Create local configuration files in the dotfiles directory for environment-specific settings that won't be tracked by git:
- `~/dotfiles/zsh/zshrc.local`
- `~/dotfiles/zsh/zprofile.local`

Run `./install.sh` after creating them to symlink into `~/.config/zsh/`.

### Plugin Management
Neovim plugins are managed in `nvim/lua/plugins/`. Each plugin has its own configuration file.

### Zsh Modules
Additional zsh plugins can be added to `zsh/modules/`.

## Updating

Pull the latest changes and re-run the install script if new files were added:

```bash
git pull
./install.sh
```

Since all configs are symlinked, most changes take effect immediately. For Neovim-specific updates:

```bash
# Sync plugins
nvim --headless "+Lazy sync" +qa

# Update LSP servers (inside Neovim)
:MasonUpdate
```

## Troubleshooting

**Neovim first launch is slow**
lazy.nvim automatically installs all plugins on first launch. Wait for it to complete, then restart Neovim.

**`zshrc.local` / `zprofile.local` not found**
These files are intentionally excluded from the repository (for environment-specific variables, secrets, etc.). If `zsh/zshrc.local` or `zsh/zprofile.local` exist in the dotfiles directory, `install.sh` will symlink them automatically. Otherwise, create them manually as needed:
```bash
touch ~/dotfiles/zsh/zshrc.local
touch ~/dotfiles/zsh/zprofile.local
./install.sh
```

**`~/.config/nvim` already exists as a directory**
If a non-symlink `nvim` directory exists, `install.sh` cannot replace it automatically. Remove it first:
```bash
rm -rf ~/.config/nvim
./install.sh
```

## Compatibility

- **macOS**: Primary target platform
- **Linux**: Supported with appropriate package manager adjustments

## License

This configuration is provided as-is for personal use and customization.
