#!/usr/bin/env sh

cap_maim() {
    png="${HOME}/Pictures/$(date +%s).png"
    maim -s "${png}"
    xclip -selection clipboard -t image/png "${png}"
}

cap_maim

