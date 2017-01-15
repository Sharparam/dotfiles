typeset -U path

path=($HOME/bin $HOME/.local/bin $path)

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
zplug "plugins/rails", from:oh-my-zsh
zplug "plugins/rbenv", from:oh-my-zsh
zplug "plugins/ruby", from:oh-my-zsh
zplug "plugins/sublime", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "mafredri/zsh-async"

#zplug "themes/amuse", from:oh-my-zsh
zplug "sindresorhus/pure", defer:1

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

export $(gnome-keyring-daemon --start)

eval "$(thefuck --alias)"
eval "$(hub alias -s)"
eval "$(rbenv init -)"

alias emacs="TERM=xterm-256color emacs -nw"

cowfortune() {
	fortune $@ | cowsay -W 70
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

cowfortune
