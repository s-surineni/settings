# For git
alias act="git commit -am "
alias ct="git commit -m "
alias cot="git checkout "
alias stt="git status"
alias pullhead='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias x="exit"
alias gitcl="git checkout -- ."
alias gitre="git restore --staged"

alias emax="emacsclient -n"                      # used to be "emacs -nw"
alias semac="sudo emacsclient -t"                # used to be "sudo emacs -nw"
alias emacsc="emacsclient -c -a emacs"           # new - opens the GUI with alternate non-daemon
alias sttu="git status -uno"
alias emaxs="SUDO_EDITOR=\"emacsclient -n\" sudo -e"
alias tmux="tmux -u"


function gacp() {
    git commit -am "$1"
    git push origin HEAD
}


function gcp() {
    git commit -m "$1"
    git push origin HEAD
}
