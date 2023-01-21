if grep -iq Microsoft /proc/version; then
    export IS_WSL=1
else
    export IS_WSL=
fi

export PROJECT_HOME="$HOME/projects/python"

if [[ "$HOST" == "melina" ]]; then
    export TERMINAL="kitty"
fi

export VISUAL="nvim"
export EDITOR="nvim"

if [[ $IS_WSL ]]; then
    export BROWSER="wslview"
else
    export BROWSER="firefox"
fi

export BASE16_THEME="eighties"

# WTF, Ansible?
export ANSIBLE_NOCOWS=1

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

export GOPATH=$HOME/.go

export DOOMDIR=$HOME/.config/doom

export PERL5LIB="$HOME/.perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="$HOME/.perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"$HOME/.perl5\""
export PERL_MM_OPT="INSTALL_BASE=$HOME/.perl5"
