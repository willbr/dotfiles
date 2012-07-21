alias reload!='. ~/.zshrc'

alias ll='ls -l'
alias la='ls -a'

alias ..='cd ..'
alias ...='cd ../..'

alias l='ls'
alias e='open .'
alias q='exit'
alias vimrc='vim ~/.vimrc'

alias t='todo'
alias tl='do_this_next last'
alias tel='do_this_next edit-last'
alias n='do_this_next'
alias ne='do_this_next edit'

alias du='du -h'

alias grep='grep --color=auto'

if [[ `uname` == 'Darwin' ]]; then
    alias v='mvim -v'
    alias vim='mvim -v'
else
    alias v='vim'
fi

