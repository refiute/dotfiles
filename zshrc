export LANG=ja_JP.UTF-8
export TERM=xterm-256color
export CLICOLOR=true

case ${OSTYPE} in
    darwin*)
        alias ls='ls -G' ;;
    *)
        alias ls='ls --color=auto'
esac

alias ll='ls -lhtr'
alias la='ls -A'
alias lla='ll -A'
alias vim='nvim'

setopt auto_pushd
setopt pushd_ignore_dups
setopt magic_equal_subst
setopt auto_cd
setopt list_packed
setopt hist_ignore_all_dups
setopt numeric_glob_sort
setopt prompt_subst
setopt auto_menu

ex(){
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1    ;;
            *.tar.gz)    tar xvzf $1    ;;
            *.tar.xz)    tar xvJf $1    ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xvf $1     ;;
            *.tbz2)      tar xvjf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.zip)       unzip $1 -d ${1%.zip}  ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *.lzma)      lzma -dv $1    ;;
            *.xz)        xz -dv $1      ;;
            *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

function chpwd() { ls }

export ZPLUG_HOME=$HOME/.zplug
if [ -d $ZPLUG_HOME ]; then
    source $ZPLUG_HOME/init.zsh

    zplug "zplug/zplug", hook-build:"zplug --self-manage"
    zplug "zsh-users/zsh-completions"
    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-history-substring-search"
    zplug "zsh-users/zsh-syntax-highlighting", defer:2

    zplug "marzocchi/zsh-notify"

    zplug "lib/clipboard", from:oh-my-zsh
    zplug "lib/history", from:oh-my-zsh
    zplug "plugins/gitfast", from:oh-my-zsh
    zplug "plugins/pip", from:oh-my-zsh
    zplug "plugins/python", from:oh-my-zsh
    zplug "plugins/pyenv", from:oh-my-zsh
    zplug "plugins/gem", from:oh-my-zsh

    zplug "mafredri/zsh-async"
    zplug "sindresorhus/pure", use:"pure.zsh", as:theme

    zplug "peco/peco", as:command, from:gh-r
    zplug "mollifier/anyframe"
    alias cdd=anyframe-widget-cdr
    alias hist=anyframe-widget-execute-history
    alias prkl=anyframe-widget-kill
    bindkey "^r" anyframe-widget-put-history
    bindkey "^f" anyframe-widget-insert-filename

    if ! zplug check; then
        printf "Install? [y/N]"
        if read -q; then
            echo; zplug install
        fi
    fi
    zplug load
fi

if [ -d $HOME/.rbenv ]; then
    export RBENV_ROOT=$HOME/.rbenv
    export PATH=$RBENV_ROOT/bin:$PATH
    eval "$(rbenv init -)"
fi

if [ -d $HOME/.pyenv ]; then
    export PATH=$HOME/.pyenv/bin:$PATH
    eval "$(pyenv init -)"

    if [ -d $PYENV_ROOT/plugins/pyenv-virtualenv ]; then
        eval "$(pyenv virtualenv-init -)"
    fi
fi

if [ -e $HOME/.zsh/local.zsh ]; then
    source $HOME/.zsh/local.zsh
fi
