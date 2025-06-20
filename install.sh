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
ln -snfv "${DOTFILES_ROOT}/zsh/zshrc.local" "${HOME}/.config/zsh/.zshrc.local"
ln -snfv "${DOTFILES_ROOT}/zsh/zprofile" "${HOME}/.config/zsh/.zprofile"
ln -snfv "${DOTFILES_ROOT}/zsh/zprofile.local" "${HOME}/.config/zsh/.zprofile.local"
ln -snfv "${DOTFILES_ROOT}/zsh/modules" "${HOME}/.config/zsh/modules"
# ln -snfv ${DOTPATH}/.zshenv ${HOME}/.zshenv
# ln -snfv ${DOTPATH}/.zsh ${HOME}/.zsh

# claude
echo "Linking claude configuration files..."
ln -snfv "${DOTFILES_ROOT}/claude/commands" "${HOME}/.claude/commands"
