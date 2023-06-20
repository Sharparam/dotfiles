# zsh seems to set $HOST automatically?
#export HOST=$(hostname)
export HOSTNAME=$HOST

if grep -iq Microsoft /proc/version; then
  export IS_WSL=true
else
  export IS_WSL=false
fi

export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

export PROJECT_HOME="$HOME/projects/python"

if [[ $IS_WSL == false ]]; then
  export TERMINAL="kitty"
fi

export VISUAL="nvim"
export EDITOR="nvim"

if [[ $IS_WSL == true ]]; then
  export BROWSER="wslview"
else
  export BROWSER="firefox"
fi

export NIX_REMOTE=daemon

export BASE16_THEME="eighties"
export CATPPUCCIN_THEME="macchiato"

if [[ -z "$XDG_DATA_DIRS" ]]; then
  export XDG_DATA_DIRS="/usr/local/share:/usr/share"
fi

nix_share="$HOME/.nix-profile/share:$XDG_DATA_DIRS"
if [[ ":${XDG_DATA_DIRS}:" != *":${nix_share}:"* ]]; then
  export XDG_DATA_DIRS="${nix_share}${XDG_DATA_DIRS:+:${XDG_DATA_DIRS}}"
fi

# WTF, Ansible?
export ANSIBLE_NOCOWS=1

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

export GOPATH=$HOME/.go

export DOOMDIR=$HOME/.config/doom

export PERL5LIB="$HOME/.perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="$HOME/.perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"$HOME/.perl5\""
export PERL_MM_OPT="INSTALL_BASE=$HOME/.perl5"

export GITHUB_USER=Sharparam

export CMAKE_GENERATOR="Ninja Multi-Config"
