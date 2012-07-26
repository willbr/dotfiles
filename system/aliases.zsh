alias lsl='ls -l'
alias lsa='ls -a'
alias lsal='ls -al'

alias rm=nocorrect rm -i'

# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi

# jumpto aliases

function j {
    if [ -z "$1" ]; then
        cd ~; echo ~
        return
    else
        local target=`jumpto jump $1`
        if [ -n "$target" ]; then
            if [ -d "$target" ]; then
                cd $target; echo $target
            else
                echo error: $target is not a directory >&2
            fi
        else
            echo alias not found
        fi
    fi
}

_j() {
    reply=(`jumpto list | sed 's/;.*$//'`)
}

compctl -K _j j

alias jls='jumpto list'
alias ja='jumpto add'
alias je='jumpto edit'
alias jb='cd -'

function project {
    cd ~/src/$1
}
alias p='project'

_project() {
    reply=(`ls ~/src`)
}

compctl -K _project p

function mw() { watchr -e 'watch(".") {system "make"}' }
alias mw='nocorrect mw'

