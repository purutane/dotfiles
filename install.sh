#!/usr/bin/env bash

DOTFILES_ROOT=$(cd "$(dirname $0)"&& pwd)

# wezterm
echo "Linking wezterm configuration files..."
mkdir -p "${HOME}/.config/wezterm"
ln -snfv "${DOTFILES_ROOT}/wezterm.lua" "${HOME}/.config/wezterm/wezterm.lua"

# tmux
echo "Linking tmux configuration files..."
ln -snfv "${DOTFILES_ROOT}/tmux.conf" "${HOME}/.tmux.conf"

# nvim
echo "Linking nvim configuration files..."
ln -snfv "${DOTFILES_ROOT}/nvim" "${HOME}/.config/"

# zsh
echo "Linking zsh configuration files..."
ln -snfv "${DOTFILES_ROOT}/zshenv" "${HOME}/.zshenv"
mkdir -p "${HOME}/.config/zsh"
ln -snfv "${DOTFILES_ROOT}/zsh/zshrc" "${HOME}/.config/zsh/.zshrc"
[[ -f "${DOTFILES_ROOT}/zsh/zshrc.local" ]] && ln -snfv "${DOTFILES_ROOT}/zsh/zshrc.local" "${HOME}/.config/zsh/.zshrc.local"
ln -snfv "${DOTFILES_ROOT}/zsh/zprofile" "${HOME}/.config/zsh/.zprofile"
[[ -f "${DOTFILES_ROOT}/zsh/zprofile.local" ]] && ln -snfv "${DOTFILES_ROOT}/zsh/zprofile.local" "${HOME}/.config/zsh/.zprofile.local"
ln -snfv "${DOTFILES_ROOT}/zsh/modules" "${HOME}/.config/zsh/modules"
# ln -snfv ${DOTPATH}/.zshenv ${HOME}/.zshenv
# ln -snfv ${DOTPATH}/.zsh ${HOME}/.zsh

# claude
echo "Linking claude configuration files..."
# ln -snfv "${DOTFILES_ROOT}/claude/commands" "${HOME}/.claude/commands"
ln -snfv "${DOTFILES_ROOT}/claude/skills" "${HOME}/.claude/skills"
ln -snfv "${DOTFILES_ROOT}/claude/hooks" "${HOME}/.claude/hooks"

# claude settings: merge only the shared "hooks" key into settings.json.
# settings.json itself stays machine-local (permissions/plugins differ per PC)
# and must not be a symlink (Claude Code's atomic writes would replace it).
CLAUDE_SETTINGS="${HOME}/.claude/settings.json"
if command -v jq >/dev/null 2>&1; then
  mkdir -p "${HOME}/.claude"
  [[ -f "${CLAUDE_SETTINGS}" ]] || echo '{}' > "${CLAUDE_SETTINGS}"
  tmp=$(mktemp)
  jq -s '.[0] * .[1]' "${CLAUDE_SETTINGS}" "${DOTFILES_ROOT}/claude/settings.hooks.json" > "${tmp}" \
    && mv "${tmp}" "${CLAUDE_SETTINGS}" \
    && echo "Merged claude hooks into ${CLAUDE_SETTINGS}"
else
  echo "jq not found; skipped merging claude hooks into ${CLAUDE_SETTINGS}" >&2
fi
