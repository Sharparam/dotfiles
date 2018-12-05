typeset -U path

path=($HOME/bin $HOME/.local/bin /usr/lib/go-1.8/bin $path)

wsl_hostnames=(PC490 Sharparam-PC)
is_wsl=${wsl_hostnames[(I)$(hostname)]}

if [[ $is_wsl ]];
then
  echo '[WSL] Disabling setting priority on background processes'
  unsetopt BG_NICE
  echo '[WSL] Setting umask to 022'
  umask 022
fi

export ZSH_TMUX_AUTOSTART=false
export ZSH_TMUX_AUTOSTART_ONCE=true
# The tmux plugin is stupid and doesn't properly detect 256color terminals
#export ZSH_TMUX_FIXTERM=false

source $HOME/.zplug/init.zsh

zplug "lib/*", from:oh-my-zsh

#zplug "plugins/autojump", from:oh-my-zsh
zplug "plugins/bundler", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/gem", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/github", from:oh-my-zsh
zplug "plugins/history-substring-search", from:oh-my-zsh
zplug "plugins/pyenv", from:oh-my-zsh
zplug "plugins/rails", from:oh-my-zsh
zplug "plugins/rbenv", from:oh-my-zsh
zplug "plugins/ruby", from:oh-my-zsh
#zplug "plugins/sublime", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh
zplug "plugins/tmuxinator", from:oh-my-zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "mafredri/zsh-async"

if [ ! $is_wsl ];
then
  zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
fi

zplug "simonwhitaker/gibo", use:/, hook-build:"ln -fs gibo-completion.zsh _gibo"

zplug "djui/alias-tips"

zplug "supercrabtree/k"

export _Z_CMD=j
zplug "rupa/z", use:z.sh

if ! zplug check; then
    zplug install
fi

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

zplug load

# User configuration

# You may need to manually set your language environment
#export LANG=en_GB.UTF-8
export LANGUAGE=en_US.UTF-8

#. /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh

export VISUAL="vim"
export EDITOR="vim"
export TERMINAL="termite"
export BROWSER="firefox"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

#export ANDROID_HOME=/opt/android-sdk

pgrep gnome-keyring >& /dev/null
if [ $? -eq 0 ]; then
    export $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
if [ $is_wsl ]; then
  if [ -z "$(pgrep ssh-agent)" ]; then
    rm -rf /tmp/ssh-*
    eval $(ssh-agent -s) > /dev/null
  else
    export SSH_AGENT_PID=$(pgrep ssh-agent)
    export SSH_AUTH_SOCK=$(find /tmp/ssh-* -name 'agent.*')
  fi
  if [ "$(ssh-add -l)" = "The agent has no identities." ]; then
    ssh-add
  fi
fi

if [ ! $is_wsl ];
then
  eval "$(thefuck --alias)"
  eval "$(hub alias -s)"
fi

if [[ -d "$HOME/.rbenv/" ]]; then
  eval "$(rbenv init -)"
fi

if [[ -d "/usr/share/perl6/" ]]; then
    path=(/usr/share/perl6/vendor/bin /usr/share/perl6/site/bin $path)
fi

if [[ -d "$HOME/.pyenv/" ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    path=($HOME/.pyenv/bin "$path[@]")
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

if [ $is_wsl ];
then
  autoload -Uz promptinit
  promptinit
  prompt adam1

  BASE16_SHELL=$HOME/.config/base16-shell/
  [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
fi

alias emacs="TERM=xterm-256color emacs -nw"

# Ugly workaround to get SSH working properly in all terminals
alias ssh="TERM=xterm-256color ssh"

alias mux="tmuxinator"

alias sketchup="WINEARCH=win64 WINEPREFIX=~/.sketchup wine start /unix ~/.sketchup/drive_c/Program\ Files/SketchUp/SketchUp\ 2017/SketchUp.exe"

cowfortune() {
    cowargs=('-b' '-d' '-g' '-p' '-s' '-t' '-w' '-y' '')
    cowextra=${cowargs[$(($RANDOM % ${#cowargs[@]}))]}
    files=($(cowsay -l | tail -n +2))
    cowfile=${files[$((RANDOM % ${#files[@]}))]}
    fortune $@ | cowsay -W 70 -f ${cowfile} ${cowextra}
}

thinkfortune () {
    fortune $@ | cowthink -W 70 -f bong -s
}

launch() {
    nohup $@ >&/dev/null &
}

scrotclip() {
    scrot $@ /tmp/scrotclip.png -e 'xclip -se c -t image/png -i $f && rm $f'
}

# WTF, Ansible?
export ANSIBLE_NOCOWS=1

cowfortune
