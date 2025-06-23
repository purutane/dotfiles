# Dotfiles

A collection of configuration files for a modern development environment with Neovim, Zsh, tmux, and WezTerm.

## Features

- **Neovim**: Modern vim configuration with LSP, completion, and plugin management via lazy.nvim
- **Zsh**: Enhanced shell with autosuggestions, syntax highlighting, and custom prompt
- **tmux**: Terminal multiplexer with vim-like keybindings
- **WezTerm**: GPU-accelerated terminal emulator configuration
- **Claude**: AI assistant command integration

## Quick Start

1. Clone the repository:
   ```bash
   git clone <repository-url> ~/dotfiles
   cd ~/dotfiles
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

3. Restart your terminal or source the new configuration:
   ```bash
   source ~/.zshenv
   ```

## What's Included

### Neovim Configuration (`nvim/`)
- **LSP Support**: Configured for Python, Lua, Bash, Terraform, and web development
- **Plugin Management**: Uses lazy.nvim for efficient plugin loading
- **Code Completion**: Advanced completion with nvim-cmp
- **Syntax Highlighting**: Treesitter-based highlighting
- **File Navigation**: Telescope fuzzy finder integration
- **AI Integration**: Claude Code and GitHub Copilot support

### Zsh Configuration (`zsh/`)
- **Enhanced Prompt**: Git status and Python virtual environment indicators
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

### WezTerm Configuration (`wezterm.lua`)
- **Font**: UDEV Gothic 35NFLG
- **Color Scheme**: Tokyo Night Storm theme
- **Clean Interface**: Tab bar disabled for minimal look
- **Padding**: Consistent window padding

### Claude Integration (`claude/`)
- **Custom Commands**: Specialized commit message generation

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
- **Claude**: `~/.claude/commands/`

## Dependencies

### Required
- **Zsh**: Shell
- **Git**: Version control

### Optional (for enhanced features)
- **Neovim**: Text editor
- **tmux**: Terminal multiplexer
- **WezTerm**: Terminal emulator
- **fzf**: Fuzzy finder
- **ripgrep**: Fast text search
- **direnv**: Environment variable management
- **Homebrew** (macOS): Package manager

The configuration includes helpful installation hints for missing dependencies.

## Customization

### Local Overrides
Create local configuration files that won't be tracked by git:
- `~/.config/zsh/.zshrc.local`
- `~/.config/zsh/.zprofile.local`

### Plugin Management
Neovim plugins are managed in `nvim/lua/plugins/`. Each plugin has its own configuration file.

### Zsh Modules
Additional zsh plugins can be added to `zsh/modules/`.

## Key Features

### Zsh Prompt
- Current directory indicator
- Git branch and status symbols (`+` for staged, `*` for unstaged)
- Python virtual environment display
- Color-coded for easy identification

### Neovim LSP
Configured language servers:
- Python (pyright)
- Lua (lua_ls)
- Bash (bashls)
- Terraform (terraformls)
- Web development (ts_ls, html, cssls)

### tmux Keybindings
- `Ctrl-j c`: New window
- `Ctrl-j %`: Vertical split
- `Ctrl-j "`: Horizontal split
- `Ctrl-j H/J/K/L`: Resize panes
- `v`: Start selection in copy mode
- `y`: Copy selection

## Compatibility

- **macOS**: Primary target platform
- **Linux**: Supported with appropriate package manager adjustments

## License

This configuration is provided as-is for personal use and customization.