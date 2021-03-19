#!/usr/bin/sh

DOTPATH=${HOME}/dotfiles

# create symbolic link
for f in .??*
do

    [ "${f}" = ".git" ] && continue
    [ "${f}" = ".gitignore" ] && continue
    ln -snfv "${DOTPATH}/${f}" "${HOME}/${f}"
done

