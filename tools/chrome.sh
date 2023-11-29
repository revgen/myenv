#!/bin/sh
BACKUP_TARGET="${BACKUP_TARGET:-"${HOME}/Documents/Backups"}"

profile_name=Default
if [ "$(uname -s || true)" == "Darwin" ]; then
    profile_dir="${HOME}/Library/Application Support/Google/Chrome/${profile_name}"
else
    profile_dir="${HOME}/.config/google-chrome/${profile_name}"
fi
bookmark_file="${profile_dir}/Bookmarks"

backup_bookmarks() {
    
    if [ ! -f "${bookmark_file}" ]; then echo "Error: bookmark file not found: ${bookmark_file}"; exit 1; fi
    mkdir -p "${BACKUP_TARGET}"
    echo "Backup chrome bookmarkds into the '${BACKUP_TARGET}' directory"
    cp -vf "${bookmark_file}" "${BACKUP_TARGET}/google-chrome-bookmarks-$(date +"%F-%H%M%S").bak" || exit 1
    echo "Done"
}

show_bookmarks() {
    if [ "${1}" == "--full" ]; then
        cat "${bookmark_file}"
    else
        cat "${bookmark_file}" | \
        grep -E '\"name|\"url' | \
        grep -vE '\"type\"\:' | \
        awk '{print $1 substr($0,index($0,$2))}' | \
        sed s'/^\"name\"\:/title \= /' | \
        sed s'/^\"url\"\:/url \= /' | \
        sed s'/\,$//' | \
        awk 'BEGIN { 
                    title="";
                    re=""
                    }
                    { 
                    if ( $1 ~ /^url/) { 
                        re=re""title"  "$0"\n\n";
                    } else if ( $1 ~ /^title/ ) { 
                        title=$0"\n"; 
                    }
                    } 
            END { 
                print re;
        }'
    fi
}

cmd="${1}"
case "${cmd}" in
    backup|bak) backup_bookmarks;;
    bookmarks) shift; show_bookmarks "${@}" ;;
    *) echo "Error: unknown command '${cmd}'"; exit 1;;
esac
