function whichbin() {
    local command_path

    if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
        command_path=$(\which $1 2> /dev/null)
    elif [ -e /etc/fedora-release ] || [ -e /etc/redhat-release ]; then
        command_path=$(\which --skip-alias $1 2> /dev/null)
    else
        echo "${FUNCNAME[0]}: unknown distribution" 1>&2
        return 22
    fi

    result=$?
    if [ "$result" -ne 0 ]; then
        echo "no ${1} in (${PATH})" 1>&2
        return $result
    fi

    readlink -f $command_path
}

# Convert datetime to an epoch time.
#
# example: a datetime to an epoch time
#     $ date2epoch "2017-01-01 00:00:00+0900"
#     1483196400
#
# example: show current epoc time
#     $ date2epoch
#     1493254466
function date2epoch() {
    if [ "$1" != "" ]; then
        \date +%s -d "$1"
    else
        \date +%s
    fi
}

# Convert an epoch time to a datetime
#
# example:
#     $ epoch2date 1483196400
#     2017-01-01 00:00:00+09:00
function epoch2date() {
    if [ "$1" = "" ]; then
        echo "Usage: ${FUNCNAME[0]} EPOCH_TIME" 1>&2
        return 22
    fi

    \date -d @"$1" --rfc-3339=seconds
}

# find files in a directory with exclude hidden files/directories
function ff() {
    local path=$1
    local name_pattern=$2

    if [ "$path" = "" ]; then
        echo "Usage: ${FUNCNAME[0]} DIR_PATH" 1>&2
        return 22
    fi

    if [ "$name_pattern" = "" ]; then
        \find "$path" -not -path '*/\.*' -type f
    else
        \find "$path" -not -path '*/\.*' -type f -name "$name_pattern"
    fi
}

# find directories in a directory with exclude hidden directories
function fd() {
    local path=$1
    local name_pattern=$2

    if [ "$path" = "" ]; then
        echo "Usage: ${FUNCNAME[0]} DIR_PATH" 1>&2
        return 22
    fi

    if [ "$name_pattern" = "" ]; then
        \find "$path" -not -path '*/\.*' -type d
    else
        \find "$path" -not -path '*/\.*' -type d -name "$name_pattern"
    fi
}

# find files and grep file name with exclude hidden files/directories
function ffg() {
    if [ $# -ne 2 ]; then
        echo "Usage: ${FUNCNAME[0]} ROOT_DIR PATTERN" 1>&2
        return 22
    fi

    ff "$1" | \grep -E --ignore-case "$2"
}

function psgrep() {
    local pattern=$1
    local psaux

    psaux=$(\ps aux)

    if [ "$pattern" = "" ]; then
        echo "Usage: ${FUNCNAME[0]} PATTERN" 1>&2
        return 22
    fi

    echo -e "$psaux" | \head -1
    echo -e "$psaux" | \grep -E "$pattern"
}

function pssort() {
    local sort_key=$1

    if \ps aux --sort "${sort_key}" > /dev/null 2>&1 ; then
        local stdout
        stdout=$(\ps aux --sort "${sort_key}")
        echo -e "${stdout}"
    else
        local header
        header=$(echo -e "$(\ps aux)" | \head -1)
        echo "invalid sort key. valid sort keys are:" ${header,,} 1>&2
        return 1
    fi
}

function extract() {
    local archive_file=$1

    if [ ! -f "${archive_file}" ]; then
        echo "'${archive_file}' is not a valid file to extract" 1>&2
        return 1
    fi

    case "${archive_file}" in
        *.tar.bz2) \tar -xvf "${archive_file}"    ;;
        *.tar.gz)  \tar -xvf "${archive_file}"    ;;
        *.tar.xz)  \tar -xvf "${archive_file}"    ;;
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

function httpserver() {
    local port=$1
    local pymajorver

    # get Python major version number
    pymajorver=$(python -c "from __future__ import print_function; import sys; print(sys.version_info[0])")

    if [ "$pymajorver" = "2" ]; then
        python -m SimpleHTTPServer ${port}
    elif [ "$pymajorver" = "3" ]; then
        python -m http.server ${port}
    fi
}

# list up installed packages
function lspkg() {
    if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
        dpkg --list
    elif [ -e /etc/fedora-release ] || [ -e /etc/redhat-release ]; then
        rpm -qa
    else
        echo "unknown distribution" 1>&2
        return 1
    fi
}

function listpkg() {
    for command in $(compgen -c | sort); do
        bin_path=$(whichbin "$command" 2> /dev/null)
        if [ "$?" -ne 0 ]; then
            continue
        fi

        package=$(whichpkg "$bin_path" 2> /dev/null)
        if [ "$?" -ne 0 ]; then
            continue
        fi

        if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
            echo "$package"
        elif [ -e /etc/fedora-release ] || [ -e /etc/redhat-release ]; then
            echo "$package: $bin_path"
        else
            echo "unknown distribution" 1>&2
            return 1
        fi
    done
}

# find a package which includes a specified command
function whichpkg() {
    local command="$1"

    if [ "${command}" = "" ]; then
        echo "Usage: ${FUNCNAME[0]} COMMAND" 1>&2
        return 22
    fi

    command_path=$(whichbin "${command}")
    result=$?
    if [ "$result" -ne 0 ]; then
        return $result
    fi

    if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
        package=$(dpkg -S "$command_path")
    elif [ -e /etc/fedora-release ] || [ -e /etc/redhat-release ]; then
        package=$(rpm -qf "$command_path")
    else
        echo "unknown distribution" 1>&2
        return 1
    fi

    result=$?
    if [ "$result" -ne 0 ]; then
        echo "file ${command_path} is not owned by any package"
        return $result
    fi

    echo "$package"
}

# select a directory and change current directory to the directory
function cdp() {
    if ! type peco > /dev/null 2>&1; then
        echo "${FUNCNAME[0]}: peco not installed"
        return 1
    fi

    dst_dir=$(\find $1 -maxdepth 2 -type d | \peco)
    if [ "$dst_dir" = "" ]; then
        return 1
    fi

    \pushd ${dst_dir} > /dev/null
}

function ffgp() {
    if ! type peco > /dev/null 2>&1; then
        echo "${FUNCNAME[0]}: peco not installed"
        return 1
    fi

    less $(ffg . $1 | peco)
}


function lastmodified() {
    local dir_path=$(readlink -f "$1")

    if [ "${dir_path}" = "" ]; then
        echo "Usage: ${FUNCNAME[0]} DIR_PATH" 1>&2
        return 22
    fi

    \find "$dir_path" -type d -name '.*' -prune -o -type f -printf '%T+ %p\n' | sort
}


function histgrep() {
    if [ "$1" = "" ]; then
        echo "Usage: ${FUNCNAME[0]} DIR_PATH" 1>&2
        return 22
    fi

    history | \grep -E "$1" | uniq --skip-fields 2
}
