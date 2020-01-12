# command aliases: Linux
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias +x='chmod +x'

alias bashrc='source ~/.bashrc'
alias bashfuncs='source ~/.bash_functions'
alias bashaliases='source ~/.bash_aliases'

alias abspath='readlink -f'
alias current_shell='readlink /proc/$$/exe'
alias date='date --rfc-3339=seconds'
alias default_ip_addr="echo $(ifdata -pa $(route | \grep -E '^default|^0\.0\.0\.0' | awk '{print $8}' | uniq))"
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


if type ag > /dev/null 2>&1; then
    alias ag='ag --pager less -B 2 -A 8'
    alias agcpp="ag --pager less --cpp"
    alias aggo="ag --pager less --go"
    alias agpy="ag --pager less --python"
fi

if type apt > /dev/null 2>&1; then
    alias apt-update='apt update; apt list --upgradable'
fi

if type colordiff > /dev/null 2>&1; then
    alias diff='\colordiff -u --ignore-space-change --tabsize=4'
else
    alias diff='\diff -u --ignore-space-change --tabsize=4'
fi


# git aliases
if type git > /dev/null 2>&1; then
    alias g='git'
    alias gshow='git show'
    alias glog='git log'
    alias glogp='git log --patch'
    alias glog-oneline='git log --pretty=format:"%cd|%H|%s" --date=short'
    alias glog-summary='git log --pretty=format:"[%cd %H] %s" --date=short --stat'
fi


# language aliases: Python
if type python > /dev/null 2>&1; then
    alias py='python'
    alias pyver='python --version'

    if type python2 > /dev/null 2>&1; then
        alias py2='python2'
    fi

    if type python3 > /dev/null 2>&1; then
        alias py3='python3'
    fi

    ## language aliases: Python - pip
    if type pip > /dev/null 2>&1; then
        alias pip-local-upgrade='pip install --upgrade --no-index .'
        alias pip-upgrade='pip install --upgrade --upgrade-strategy eager'
    fi

    ## language aliases: Python - pytest-runner
    alias pst='python setup.py test'
    alias pstv='python setup.py test --addopts -v'
    alias pstvv='python setup.py test --addopts -vv'
    alias pstrx='python setup.py test --addopts --runxfail'
    alias pstrxv='python setup.py test --addopts "--runxfail -v"'
    alias pstrxvv='python setup.py test --addopts "--runxfail -vv"'
    alias pstlf='python setup.py test --addopts "--lf -vv"'
    alias pstrxlf='python setup.py test --addopts "--lf -vv --runxfail"'

    ## language aliases: Python - pytest-watch
    if type ptw > /dev/null 2>&1; then
        alias ptw='ptw --onpass "echo passed" --onfail "echo failed"'
    fi

    ## language aliases: Python - watchdog
    if type watchmedo > /dev/null 2>&1; then
        alias localci-test='watchmedo shell-command -W -p="*.py" -R --command="python setup.py test --addopts \"--runxfail --lf -vv\"" .'
        alias localci-upgrade='watchmedo shell-command -W -p="*.py" -R --command="date --rfc-3339=seconds; pip install . --upgrade" .'
    fi
fi

## language aliases: Python - pyenv
if [ -e "${HOME}/.pyenv" ]; then
    alias pyenvs='pyenv versions'
    alias pyenvver='pyenv version'
    alias pyenvsys='pyenv local system'
    alias pyenv2='pyenv local $(pyenv versions | \grep -oE "2\.7\.[0-9]+" | sort -r | head -n 1)'
    alias pyenv35='pyenv local $(pyenv versions | \grep -oE "3\.5\.[0-9]+" | sort -r | head -n 1)'
    alias pyenv36='pyenv local $(pyenv versions | \grep -oE "3\.6\.[0-9]+" | sort -r | head -n 1)'
    alias pyenv37='pyenv local $(pyenv versions | \grep -oE "3\.7\.[0-9]+" | sort -r | head -n 1)'
    alias pyenv38='pyenv local $(pyenv versions | \grep -oE "3\.8\.[0-9]+" | sort -r | head -n 1)'
    alias pyenv39='pyenv local $(pyenv versions | \grep -oE "3\.9\.[0-9]+|3.9-dev" | sort -r | head -n 1)'
    alias pyenv3='pyenv local $(pyenv versions | \grep -oE "3\.[0-9]+\.[0-9]+" | sort -r | head -n 1)'
    alias pyenvpypy='pyenv local $(pyenv versions | \grep -oE "pypy[3-9]\.[0-9]+-[0-9]+\.[0-9]+\.[0-9]+" | sort -r | head -n 1)'
    alias pyenvconda='pyenv local $(pyenv versions | \grep -oE "anaconda[2-9]-20[0-9]{2}.[12][0-9]" | sort -r | head -n 1)'
fi


# language aliases: Golang
if type go > /dev/null 2>&1; then
    alias gover='go version'
fi
