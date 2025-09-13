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

export BASE16_THEME="eighties"
export CATPPUCCIN_THEME="macchiato"

unset SSH_AGENT_PID
export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

# WTF, Ansible?
export ANSIBLE_NOCOWS=1

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

export GOPATH=$HOME/.go

export DOOMDIR=$HOME/.config/doom

export PERL5LIB="$HOME/.perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="$HOME/.perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"$HOME/.perl5\""
export PERL_MM_OPT="INSTALL_BASE=$HOME/.perl5"

if [[ $IS_WSL == true ]]; then
  export GIT_SSH="ssh.exe"
fi

export GITHUB_USER=Sharparam

export MAKEFLAGS="-j$(nproc)"
export CMAKE_GENERATOR="Ninja"

export DOTNET_CLI_TELEMETRY_OPTOUT=1

export ZSH_PLUGINS_ALIAS_TIPS_EXCLUDES="_ vi vim"

[ -d "$HOME/.bun" ] && export BUN_INSTALL="$HOME/.bun"

# Restic stuff
[ -f "$HOME/.config/restic/repository" ] && export RESTIC_REPOSITORY_FILE="$HOME/.config/restic/repository"
if [[ -f "$HOME/.config/restic/password_command" ]]; then
  export RESTIC_PASSWORD_COMMAND=$(<"$HOME/.config/restic/password_command")
elif [[ -f "$HOME/.config/restic/password" ]]; then
  export RESTIC_PASSWORD_FILE="$HOME/.config/restic/password"
fi
