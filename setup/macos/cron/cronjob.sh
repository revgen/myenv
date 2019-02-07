#!/bin/bash
#=============================================================================
## Helper script for cron.
## It helps execute a script by internal interval.
##
## Usage: {SCRIPT_NAME} <command> [interval]
##   command    - script name or command to execution (use a full path)
##   interval   - time interval in seconds
##
## Example:
##   # Execute 'custom-script.sh' after the 1h
##   cronjob.sh custom-script.sh 3600
#=============================================================================
cron_scripts_dir=$(dirname "${0}")
cd ${cron_scripts_dir}/../../
export MYENVHOME=${MYENVHOME:-"${PWD}"}
export PATH=${HOME}/bin:${cron_scripts_dir}:${HOME}/.local/bin:${PATH}
script_name=$(basename "${0}")
status_dir=/var/tmp/${script_name}/
debug() { [ "${DEBUG}" == "true" ] && echo [${cmd}] $@ ; }

cd ${HOME}
mkdir -p "${status_dir}" 2>/dev/null
cmd=${1:-"--help"}
case "${cmd}" in
    help|--help) sed -n '/^##/,/^$/s/^## \{0,1\}//p' "$0" | sed 's/{SCRIPT_NAME}/'"$(basename "${0}")"'/g'; exit 1;;
esac

interval=${2:-"86400"};                # Default timeout 1day = 86400 seconds
# 24 hours - 86400 seconds
# 30 days - 2592000 seconds

debug "Begin..."
status_file=${status_dir}/${script_name}_$(basename "${cmd}").stat
log_file="${status_file}.log"
debug "Status file: ${status_file}"
[ ! -f "${status_file}" ] && echo "0" > "${status_file}"
old_value=$(cat "${status_file}")
now_value=$(date +%s)
debug "Old time value = ${old_value}"
diff_value=$((${now_value} - ${old_value}))
debug "Time diff = ${diff_value}"
debug "Executing '${cmd}'..."
if [ ${diff_value} -ge ${interval} ]; then
    logger -s "[${script_name}] Executing '${cmd}': log='${log_file}'..."
    debug "Executing..."
    ${cmd} | tee -a "${log_file}"
    debug "Done"
    debug "Updated time value = ${now_value}"
    echo "${now_value}" > "${status_file}"
    echo "[${script_name}] Done '${cmd}'" >> "${log_file}"
    logger -s "[${script_name}] Done '${cmd}': log='${log_file}'"
else
    # logger -s "[${script_name}] Skip execution '${cmd}'."
    echo "[${script_name}] Skip execution '${cmd}'." >> "${log_file}"
    debug "${diff_value} < ${interval} -> Skip execution"
fi
debug "End"
