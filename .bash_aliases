# command aliases: Linux
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias +x='chmod +x'

alias bashrc='source ~/.bashrc'
alias bashfuncs='source ~/.functions.sh'
alias bashaliases='source ~/.bash_aliases'

alias abspath='readlink -f'
alias current_shell='readlink /proc/$$/exe'
alias date='\date --rfc-3339=seconds'
alias df='df -h --portability'
alias less='less --tabs=4'
alias mkdir='mkdir -pv'
alias rmcomment='\grep -vE "^\s*#|^\s*$"'
alias sudo='sudo '
alias sudoe='sudo -E '

alias dchi='debchange --increment --distribution bionic --urgency low'
alias dputppa="dput ppa:thombashi/ppa"

grep_options='--ignore-case --line-number --binary-files=without-match --color=always'
alias egrep='\grep -E '$(echo ${grep_options})
alias fgrep='\grep -F '$(echo ${grep_options})
alias grep='grep '$(echo ${grep_options})
unset grep_options

ls_options='--color=always --group-directories-first --time-style=long-iso --file-type --human-readable --hide-control-chars'
alias ls='\ls '$(echo ${ls_options})
alias la='\ls -A '$(echo ${ls_options})
alias ll='\ls -l '$(echo ${ls_options})
alias lla='\ls -lA '$(echo ${ls_options})
alias lrt='\ls -lrt '$(echo ${ls_options})
alias lrta='\ls -lrtA '$(echo ${ls_options})
unset ls_options

alias echopath='echo $PATH | tr -s ":" "\n"'


if command -v ag > /dev/null 2>&1; then
    alias ag='ag --pager less -B 2 -A 8'
    alias agcpp="ag --pager less --cpp"
    alias aggo="ag --pager less --go"
    alias agpy="ag --pager less --python"
fi

if command -v apt > /dev/null 2>&1; then
    alias apt-update='apt update && apt list --upgradable'
fi

if command -v colordiff > /dev/null 2>&1; then
    alias diff='\colordiff -u --ignore-space-change --tabsize=4'
else
    alias diff='\diff -u --ignore-space-change --tabsize=4'
fi

if command -v errno > /dev/null 2>&1; then
    alias last_errno='errno "$?"'
fi

# git aliases
if command -v git > /dev/null 2>&1; then
    alias g='git'
    alias gshow='git show'
    alias glog='git log'
    alias glogp='git log --patch'
    alias glog-oneline='git log --pretty=format:"%cd|%H|%s" --date=short'
    alias glog-summary='git log --pretty=format:"[%cd %H] %s" --date=short --stat'
fi


# language aliases: Python
if command -v python > /dev/null 2>&1; then
    alias py='python'
    alias pyver='python --version'

    if command -v python2 > /dev/null 2>&1; then
        alias py2='python2'
    fi

    if command -v python3 > /dev/null 2>&1; then
        alias py3='python3'
    fi

    ## language aliases: Python - pip
    if command -v pip > /dev/null 2>&1; then
        alias pip-local-upgrade='pip install --upgrade --no-index .'
        alias pip-outdated='pip list --outdated'
        alias pip-upgrade='pip install --upgrade --upgrade-strategy eager'
    fi

    ## language aliases: Python - mypy
    if command -v pip > /dev/null 2>&1; then
        alias mypy='mypy --ignore-missing-imports --show-error-context --show-error-codes --python-version 3.5'
    fi

    ## language aliases: Python - pytest
    alias pyt='pytest'
    alias pytrx='pytest --runxfail'
    alias pytlf='pytest --last-failed'
    alias pytrxlf='pytest --runxfail --last-failed'

    function pytlog () {
        pytest "$1" | tee pytest.log
    }

    ## language aliases: Python - pyupgrade
    if command -v pyupgrade > /dev/null 2>&1; then
        alias pyupgrade-py3plus='ffg . "\.py$" | xargs pyupgrade --py3-plus'
        alias pyupgrade-py36='ffg . "\.py$" | xargs pyupgrade --py36'
    fi

    ## language aliases: Python - pytest-watch
    if command -v ptw > /dev/null 2>&1; then
        alias ptw='ptw --onpass "echo passed" --onfail "echo failed"'
    fi

    ## language aliases: Python - watchdog
    if command -v watchmedo > /dev/null 2>&1; then
        alias localci-py='watchmedo shell-command -W -p="*.py" -R --command="pytest --runxfail --lf -vv" .'
    fi
fi

## language aliases: Python - pyenv
if [ -e "${HOME}/.pyenv" ]; then
    alias pyenvs='pyenv versions'
    alias pyenvver='pyenv version'
    alias pyenvsys='pyenv local system'

    alias pyenv2='pyenv local $(pyenv versions | \grep -oE "2\.7\.[0-9]+" | sort -r | head -n 1)'

    alias pyver35='echo $(pyenv versions | \grep -oE "3\.5\.[0-9]+" | sort | tail -n 1)'
    alias pyver36='echo $(pyenv versions | \grep -oE "3\.6\.[0-9]+" | sort | tail -n 1)'
    alias pyver37='echo $(pyenv versions | \grep -oE "3\.7\.[0-9]+" | sort | tail -n 1)'
    alias pyver38='echo $(pyenv versions | \grep -oE "3\.8\.[0-9]+" | sort | tail -n 1)'
    alias pyver39='echo $(pyenv versions | \grep -oE "3\.9\.[0-9]+|3.9-dev" | sort | tail -n 1)'
    alias pyverpypy='echo $(pyenv versions | \grep -oE "pypy[3-9]\.[0-9]+-[0-9]+\.[0-9]+\.[0-9]+" | sort | tail -n 1)'
    alias pyverconda='echo $(pyenv versions | \grep -oE "anaconda[2-9]-20[0-9]{2}.[12][0-9]" | sort | tail -n 1)'

    alias pyenv35='pyenv local $(pyver35)'
    alias pyenv36='pyenv local $(pyver36)'
    alias pyenv37='pyenv local $(pyver37)'
    alias pyenv38='pyenv local $(pyver38)'
    alias pyenv39='pyenv local $(pyver39)'
    alias pyenv3='pyenv local $(pyenv versions | \grep -oE "3\.[0-9]+\.[0-9]+" | sort -r | head -n 1)'
    alias pyenvpypy='pyenv local $(pyverpypy)'
    alias pyenvconda='pyenv local $(pyverconda)'

    alias pyenvall='pyenv local $(pyver36) $(pyver37) $(pyver38) $(pyver39) $(pyverpypy)'
fi


# language aliases: Golang
if command -v go > /dev/null 2>&1; then
    alias gover='go version'
fi
