# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)
if [[ -f $hub_path ]]
then
  alias git=$hub_path
fi

# The rest of my fun git aliases
alias g='git'
compdef g=git
alias ga='git add'
compdef _git ga=git-add
alias gl='git pull --prune'
compdef _git gl=git-pull
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
compdef _git glog=git-log

alias glg='git log --max-count=10 --decorate --graph --oneline'
alias glgs='git log --stat --max-count=10 --decorate --graph --oneline'

alias gp='git push origin HEAD'
compdef _git gp=git-push
alias gd='git diff'
alias gc='git commit -v'
compdef _git gc=git-commit
alias gca='git commit -v -a'
compdef _git gca=git-commit
alias gm='git merge'
compdef _git gm=git-merge
alias gco='git checkout'
compdef _git gco=git-checkout
alias gb='git branch'
compdef _git gb=git-branch
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
compdef _git gs=git-status
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
