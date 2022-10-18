#!/bin/sh
#=======================================================================
## Cheats in command line. CLI for https://cheat.sh
## Usage: {SCRIPT_NAME} [language] <query>
#=======================================================================
arg1=${1:-"help"}

# shellcheck disable=SC2249
case "${arg1}" in
    help|--help|h|-h)
        sed -n '/^##/,/^$/s/^## \{0,1\}//p' "$0" | sed 's/{SCRIPT_NAME}/'"${0##*/}"'/g'
        exit 255;
esac

if [ -n "${2}" ]; then 
    shift
    q=$(echo "$*" | sed 's/ /-/g')
    url="cht.sh/${arg1}/${q}"
else
    url="cht.sh/${arg1}"
fi
echo "Request: ${url}"
if command -v  curl >/dev/null; then curl "${url}" 2>/dev/null;
else  wget -qO - "${url}" 2>/dev/null; fi
