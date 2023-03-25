#!/usr/bin/env sh

DOTPATH=${HOME}/dotfiles

# create symbolic link
for f in .??*
do
    [ "${f}" = ".git" ] && continue
    [ "${f}" = ".gitignore" ] && continue
    [ "${f}" = ".gitmodules" ] && continue
    [ "${f}" = ".config" ] && continue
    [ "${f}" = ".local" ] && continue
    echo ${f}
    ln -snfv "${DOTPATH}/${f}" "${HOME}/${f}"
done

# config
## alacritty
ln -snfv ${DOTPATH}/.config/alacritty ${HOME}/.config/alacritty

## qtile
ln -snfv ${DOTPATH}/.config/qtile ${HOME}/.config/qtile

# cap_maim.sh
ln -snfv ${DOTPATH}/.local/bin/cap_maim.sh ${HOME}/.local/bin/cap_maim.sh

