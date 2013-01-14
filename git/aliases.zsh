# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)
if [[ -f $hub_path ]]
then
  alias git=$hub_path
fi

alias g='git'
alias ga='git add'
alias gl='git pull --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"

alias glg='git log --max-count=10 --decorate --graph --oneline'
alias glgs='git log --stat --max-count=10 --decorate --graph --oneline'

alias gp='git push origin HEAD'
alias gd='git diff'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gm='git merge'
alias gco='git checkout'
alias gb='git branch'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
