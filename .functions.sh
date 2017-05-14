# thombashi/dotfiles/.functions

whichbin() {
    if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
        /usr/bin/which $1
    elif [ -e /etc/fedora-release ] || [ -e /etc/redhat-release ]; then
        /usr/bin/which --skip-alias $1
    else
        echo "unknown distribution"
        return 1
    fi
}

<< __date2epoch_docstring__
Convert datetime to an epoch time.

example: a datetime to an epoch time
    $ date2epoch "2017-01-01 00:00:00+0900"
    1483196400

example: show current epoc time
    $ date2epoch
    1493254466
__date2epoch_docstring__
date2epoch() {
    if [ "$1" != "" ]; then
        $(whichbin date) +%s -d "$1"
    else
        $(whichbin date) +%s
    fi
}

<< __epoch2date_docstring__
Convert an epoch time to a datetime

example:
    $ epoch2date 1483196400
    2017-01-01 00:00:00+09:00
__epoch2date_docstring__
epoch2date() {
    if [ "$1" = "" ]; then
        echo "Usage: ${FUNCNAME[0]} EPOCH_TIME"
        return 1
    fi

    $(whichbin date) -d @"$1" --rfc-3339=seconds
}

findfile() {
    $(whichbin find) $1 -type f
}

findfilegrep() {
    $(whichbin find) $1 -type f | $(whichbin egrep) $2
}

finddir() {
    $(whichbin find) $1 -type d
}

psgrep() {
    local pattern=$1
    local psaux=$(ps aux)

    if [ "${pattern}" = "" ]; then
        echo "Usage: ${FUNCNAME[0]} PATTERN"
        return 1
    fi

    echo -e "${psaux}" | head -1
    echo -e "${psaux}" | $(whichbin egrep) "${pattern}"
}

pssort() {
    local sort_key=$1

    ps aux --sort "${sort_key}" > /dev/null 2>&1
    if [ "$?" -eq 0 ]; then
        local stdout=$(ps aux --sort "${sort_key}")
        echo -e "${stdout}"
    else
        local header=$(echo -e "$(ps aux)" | head -1)
        echo "invalid sort key. valid sort keys are:" ${header,,}
    fi
}

extract() {
    if [ -f "$1" ]; then
        echo "'$1' is not a valid file to extract"
        return 1
    fi

    case "$1" in
        *.tar.bz2)  tar -jxvf "$1"   ;;
        *.tar.gz)   tar -zxvf "$1"   ;;
        *.bz2)      bunzip2 "$1"     ;;
        *.gz)       gunzip "$1"      ;;
        *.tar)      tar -xvf "$1"    ;;
        *.tbz2)     tar -jxvf "$1"   ;;
        *.tgz)      tar -zxvf "$1"   ;;
        *.zip)      unzip "$1"       ;;
        *.ZIP)      unzip "$1"       ;;
        *) echo "'$1' cannot be extracted via extract()"; return 2 ;;
    esac
}

httpserver() {
    local port=$1

    # get Python major version number
    local pymajorver=$(python -c "from __future__ import print_function; import sys; print(sys.version_info[0])")

    if [ "$pymajorver" = "2" ]; then
        python -m SimpleHTTPServer ${port}
    elif [ "$pymajorver" = "3" ]; then
        python -m http.server ${port}
    fi
}

whichpkg() {
    local command="$1"
    
    if [ "${command}" = "" ]; then
        echo "Usage: ${FUNCNAME[0]} COMMAND"
        return 1
    fi

    if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
        dpkg -S "$(whichbin ${command})"
    elif [ -e /etc/fedora-release ] || [ -e /etc/redhat-release ]; then
        rpm -qf "$(whichbin ${command})"
    else
        echo "unknown distribution"
        return 1
    fi
}
