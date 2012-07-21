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

alias jls='jumpto list'
alias ja='jumpto add'
alias je='jumpto edit'
alias jb='cd -'

