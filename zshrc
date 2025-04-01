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

autoload -Uz colors && colors
autoload -Uz compinit && compinit

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

PATH=$HOME/.local/bin:$HOME/usr/bin:$PATH
if ! command -v sheldon &> /dev/null; then
    curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
        | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
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

    if type direnv &>/dev/null; then
        eval "$(direnv hook zsh)"
    fi
fi

if ! command -v starship &> /dev/null; then
    mkdir -p ~/usr/bin
    curl -sS https://starship.rs/install.sh \
    | sh -s -- -b ~/usr/bin
fi
if type "starship" &> /dev/null; then
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    eval "$(starship init zsh)"
fi

if [ -e $HOME/.zsh/local.zsh ]; then
    source $HOME/.zsh/local.zsh
fi