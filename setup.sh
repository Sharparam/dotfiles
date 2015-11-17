#!/bin/bash

file_exists() {
    [[ -f "$1" ]] && return 0 || return 1
}

link_dotfile() {
    local f = "$1"

    if ( file_exists "$f" )
    then
        mv "$f" "$f.bak"
    fi

    ln -s "dotfiles/${f:1}" "$f"
}

cd $HOME
git clone git@github.com:Sharparam/dotfiles.git

link_dotfile ".vimrc"
link_dotfile ".zshrc"
