#!/bin/sh
#=============================================================================
## Move old files to the Trash using a older then X days settings.
##   ~/Downloads       - older then 30 days
##   /tmp              - older then 7 days
## Usage: {SCRIPT_NAME} [--dry-run]
#=============================================================================
TRASH=${HOME}/.Trash_11
DRY_RUN=false
info() {
    if [ "${DRY_RUN}" == "true" ]; then echo $@;
    else echo $@ | logger -s -t os.cleanup; fi
}

show_help() {
    sed -n '/^##/,/^$/s/^## \{0,1\}//p' "$0" | sed 's/{SCRIPT_NAME}/'"$(basename "${0}")"'/g'
    exit 255
}

cleanup_path() {
    path=${1}
    if [ ! -e "${path}" ]; then
        info "Error: path '${path}' not found"
        return 1
    fi
    info "Cleanup inside the '${path}'..."
    older_then_days=${2:-"30"}
    day=$(date +"%Y%m%d")
    now=$(date +"%H%M%S")
    count=$(find "${path}" -maxdepth 1 -mindepth 1 -mtime +${older_then_days} | wc -l | sed 's/^[ ]*//g')
    find "${path}" -maxdepth 1 -mindepth 1 -mtime +${older_then_days} |\
    while read cur_path; do
        new_dir=${TRASH}/$(basename "${path}")-${day}/${day}-${now}
        [ ! -d "${new_dir}" ] && mkdir -p "${new_dir}"
        new_path=${new_dir}/$(basename "${cur_path}")
        if [ "${DRY_RUN}" != "true" ]; then
            mv "${cur_path}" "${TRASH}/${new_path}"
        fi
        if [ $? -eq 0 ]; then
            count=$(($count + 1))
            info "Move ${cur_path} to the trash ${new_path}"
        fi
    done
    if [ $count -gt 0 ]; then
        msg="Removed ${count} items from the ${path}"
        info "${msg}"
        notify "Download Cleaner" "${msg}"
    else
        info "Find nothing to cleanup"
    fi
}

case "${1}" in
    dry-run|--dry-run) DRY_RUN=true ;;
    help|--help) show_help ;;
esac
cleanup_path "${HOME}/Downloads" 30
cleanup_path "/tmp" 1
