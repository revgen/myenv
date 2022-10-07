#!/bin/sh
#=======================================================================
## Cheats in command line. CLI for https://cheat.sh
## Usage: {SCRIPT_NAME} [language] <query>
#=======================================================================
arg1=${1:-"help"}
case "${arg1}" in
    help|--help|h|-h)
        sed -n '/^##/,/^$/s/^## \{0,1\}//p' "$0" | sed 's/{SCRIPT_NAME}/'"${0##*/}"'/g'
        exit 255;
esac

if [ -n "${2}" ]; then 
    shift
    q=$(echo $@ | sed 's/ /-/g')
    echo "Request: cht.sh/${arg1}/${q}"
    curl cht.sh/${arg1}/${q} 2>/dev/null
else
    echo "Request: cht.sh/${arg1}"
    curl cht.sh/${arg1} 2>/dev/null
fi

