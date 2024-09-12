export TERM=xterm-256color
export CLICOLOR=true

case ${OSTYPE} in
    darwin*)
        alias ls='ls -G' ;;
    *)
        alias ls='ls --color=auto'
esac

alias vim='nvim'
alias ll='ls -lhtr'
alias la='ls -A'
alias lla='ll -A'

setopt auto_pushd
setopt pushd_ignore_dups
setopt magic_equal_subst
setopt auto_cd
setopt list_packed
setopt hist_ignore_all_dups
setopt numeric_glob_sort
setopt prompt_subst
setopt auto_menu
bindkey -e

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

if [ -e $HOME/.zsh/local.zsh ]; then
    source $HOME/.zsh/local.zsh
fi

cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}
sheldon_cache="$cache_dir/sheldon.zsh"
sheldon_toml="$HOME/.config/sheldon/plugins.toml"
if [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
  mkdir -p $cache_dir
  sheldon source > $sheldon_cache
fi
source "$sheldon_cache"
unset cache_dir sheldon_cache sheldon_toml

if [ -z $SINGULARITY_NAME ]; then
    export LANG=en_US.UTF-8

    export RBENV_ROOT=$ENV_ROOT/.rbenv
    if [ -d $RBENV_ROOT ]; then
        export PATH=$RBENV_ROOT/bin:$PATH
        eval "$(rbenv init -)"
    fi

    export PYENV_ROOT=$ENV_ROOT/.pyenv
    if [ -d $PYENV_ROOT ]; then
        export PATH=$PYENV_ROOT/bin:$PATH
        export PYENV_VIRTUALENV_DISABLE_PROMPT=1
        eval "$(pyenv init -)"
        eval "$(pyenv init --path)"

        if [ -d $PYENV_ROOT/plugins/pyenv-virtualenv ]; then
            eval "$(pyenv virtualenv-init -)"
        fi
    fi

    if [ -d $ENV_ROOT/.rye ]; then
        source "$ENV_ROOT/.rye/env"
    fi

    if type direnv &>/dev/null; then
        eval "$(direnv hook zsh)"
    fi

    export PLENV_ROOT=$ENV_ROOT/.plenv
    if [ -d $PLENV_ROOT ]; then
        export PATH=$PLENV_ROOT/bin:$PATH
        eval "$(plenv init -)"
    fi

fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/conda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/conda/etc/profile.d/conda.sh" ]; then
        . "/opt/conda/etc/profile.d/conda.sh"
    else
        export PATH="/opt/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

