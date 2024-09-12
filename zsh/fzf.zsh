alias cdd=anyframe-widget-cdr
alias hist=anyframe-widget-execute-history
alias prkl=anyframe-widget-kill
bindkey "^f" anyframe-widget-insert-filename

function put-history () {
    BUFFER="$(anyframe-source-history | anyframe-selector-auto "$LBUFFER" --no-sort | sed s/\\\\n/\\$'\n'/g)"
    CURSOR=$#BUFFER
    zle -R -c
}
zle -N put-history
bindkey "^r" put-history
