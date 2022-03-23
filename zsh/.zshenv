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
