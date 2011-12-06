# source global definitions
if [ -f /etc/bash.bashrc ]; then
    source /etc/bash.bashrc
fi
# private configs
if [ -f $HOME/Dropbox/bashrc ]; then
    source $HOME/Dropbox/bashrc
fi
# sourcing completion files
for file in $HOME/.bash/completion/*; do
    source $file
done
# sourcing personal aliases
source $HOME/.bash/aliases

# don't put duplicate lines in the history
export HISTCONTROL=erasedups
# nice formatting
export HISTTIMEFORMAT='%F %T '
# long list
export HISTSIZE=100000

# grep options
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

# function to go to a parent directory of the current
# directory. It takes the number of directory to ascend as
# argument.
up(){
    local d=""
    limit=$1
    for ((i=1 ; i <= limit ; i++))
    do
        d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
        d=..
    fi
    cd $d
}

# simple exctract function for compressed file based on only bashrc
extract () 
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1        ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1       ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xvf $1        ;;
            *.tbz2)      tar xvjf $1      ;;
            *.tgz)       tar xvzf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}


# loading rvm and its completion FTW
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

# my personal prompt, with colours, git current branch and ruby version
function ps_function() {
white="\[\033[0;37m\]"
red="\[\033[0;31m\]"
blue="\[\033[1;34m\]"
green="\[\033[0;32m\]"
branch='$(__git_ps1 "(%s)")'
lsb=`lsb_release -d | awk {' print $2"-"$3'}`
PS1="$red[$green ($($rvm_path/bin/rvm-prompt v g))$blue\u$red@$blue\h$red#$blue$lsb \W$green $branch$red]$green\$$white"
}
export PROMPT_COMMAND=ps_function

