export LANG=ja_JP.UTF-8
export TERM=screen-256color
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

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice wait lucid
zinit light-mode for \
    zsh-users/zsh-completions \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-history-substring-search \
    zdharma/fast-syntax-highlighting \

zinit ice from"gh-r" as"program" wait lucid
zinit light junegunn/fzf
zinit ice wait lucid
zinit light mollifier/anyframe
alias cdd=anyframe-widget-cdr
alias hist=anyframe-widget-execute-history
alias prkl=anyframe-widget-kill
bindkey "^r" anyframe-widget-put-history
bindkey "^f" anyframe-widget-insert-filename

zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

### End of Zinit's installer chunk

if [ -e $HOME/.zsh/local.zsh ]; then
    source $HOME/.zsh/local.zsh
fi

if [ -d $HOME/.rbenv ]; then
    export RBENV_ROOT=$HOME/.rbenv
    export PATH=$RBENV_ROOT/bin:$PATH
    eval "$(rbenv init -)"
fi

if [ -d $HOME/.pyenv ]; then
    export PYENV_ROOT=$HOME/.pyenv
    export PATH=$PYENV_ROOT/bin:$PATH
    eval "$(pyenv init -)"

    if [ -d $PYENV_ROOT/plugins/pyenv-virtualenv ]; then
        eval "$(pyenv virtualenv-init -)"
    fi
fi

if type "starship" &> /dev/null; then
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    eval "$(starship init zsh)"
fi
