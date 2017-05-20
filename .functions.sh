whichbin() {
    if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
        \which $1
    elif [ -e /etc/fedora-release ] || [ -e /etc/redhat-release ]; then
        \which --skip-alias $1
    else
        echo "unknown distribution" 1>&2
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
        \date +%s -d "$1"
    else
        \date +%s
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
        echo "Usage: ${FUNCNAME[0]} EPOCH_TIME" 1>&2
        return 1
    fi

    \date -d @"$1" --rfc-3339=seconds
}

findfile() {
    dir_path=$1
    name_pattern=$2

    if [ "${name_pattern}" = "" ]; then
        \find ${dir_path} -type f
    else
        \find ${dir_path} -type f -name ${name_pattern}
    fi
}

findfilegrep() {
    \find $1 -type f | \egrep $2
}

finddir() {
    \find $1 -type d
}

psgrep() {
    local pattern=$1
    local psaux=$(\ps aux)

    if [ "${pattern}" = "" ]; then
        echo "Usage: ${FUNCNAME[0]} PATTERN" 1>&2
        return 1
    fi

    echo -e "${psaux}" | \head -1
    echo -e "${psaux}" | \egrep "${pattern}"
}

pssort() {
    local sort_key=$1

    \ps aux --sort "${sort_key}" > /dev/null 2>&1
    if [ "$?" -eq 0 ]; then
        local stdout=$(\ps aux --sort "${sort_key}")
        echo -e "${stdout}"
    else
        local header=$(echo -e "$(\ps aux)" | \head -1)
        echo "invalid sort key. valid sort keys are:" ${header,,} 1>&2
        return 1
    fi
}

extract() {
    archive_file=$1
    if [ ! -f "${archive_file}" ]; then
        echo "'${archive_file}' is not a valid file to extract" 1>&2
        return 1
    fi

    case "${archive_file}" in
        *.tar.bz2) \tar -jxvf "${archive_file}"   ;;
        *.tar.gz)  \tar -zxvf "${archive_file}"   ;;
        *.bz2)     \bunzip2 "${archive_file}"     ;;
        *.gz)      \gunzip "${archive_file}"      ;;
        *.tar)     \tar -xvf "${archive_file}"    ;;
        *.tbz2)    \tar -jxvf "${archive_file}"   ;;
        *.tgz)     \tar -zxvf "${archive_file}"   ;;
        *.zip)     \unzip "${archive_file}"       ;;
        *.ZIP)     \unzip "${archive_file}"       ;;
        *) echo "'${archive_file}' cannot be extracted via extract()" 1>&2; return 2 ;;
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
        echo "Usage: ${FUNCNAME[0]} COMMAND" 1>&2
        return 1
    fi

    if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
        dpkg -S "$(whichbin ${command})"
    elif [ -e /etc/fedora-release ] || [ -e /etc/redhat-release ]; then
        rpm -qf "$(whichbin ${command})"
    else
        echo "unknown distribution" 1>&2
        return 1
    fi
}
