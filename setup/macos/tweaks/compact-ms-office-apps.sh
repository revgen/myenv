#!/bin/sh
echo "==================================================================="
echo "The script will compact Microsoft Apps directories."
echo "It will remove unused locales and create a symlinks for duplicates."
#==============================================================================
logfile="/tmp/$(basename "${0}").log"
trace() { echo $@ | tee "${logfile}"; }
debug() { [ "${DEBUG}" == "true" ] && echo $@ | tee "${logfile}"; }

safe_rm() {
    echo "${1}" | grep -q "/Applications/Microsoft " \
    && (debug "  - Remove ${1}" || true) && sudo rm -r "${1}"
}
show_size() {
    du -sh /Applications/Microsoft\ *.app
    echo "----    ---------------"
    find /Applications -type d -maxdepth 1 -name 'Microsoft *.app' -exec du -ch {} + | grep total$
}
cleanup_proofingtool() {
    name=${1}
    app=${2:-"/tmp.app"}
    trace "[${name}] Remove all *.proofingtool, except English and Russian"
    find "${app}" -type d -iname "*.proofingtool" -and -not -iname "English*.proofingtool" -and -not -iname "Russian*.proofingtool" | sort \
    | while read p; do
        safe_rm "${p}"
    done
}
create_symlink() {
    name=${1}
    app=${2:-"/tmp.app"}
    dir=${3}
    main_app="/Applications/Microsoft Word.app"
    if [ ! -d "${app}/${dir}" ] && [ ! -L "${app}/${dir}" ]; then
        trace "[${name}] Symlink ${app}/${dir} - SKIP (doesn't exists: ${app}/${dir})"
    fi
    if [ ! -d "${main_app}/${dir}" ] && [ ! -L "${main_app}/${dir}" ]; then
        trace "[${name}] Symlink ${app}/${dir} - SKIP (doesn't exists: ${main_app}/${dir})"
    fi
    if [ "${app}" == "${main_app}" ]; then
        trace "[${name}] Symlink ${app}/${dir} - SKIP (Main Application)"
    else
        trace "[${name}] Symlink ${app}/${dir} -> ${main_app}"
        safe_rm "${app}/${dir}"
        sudo ln -s "${main_app}/${dir}" "${app}/${dir}"
    fi
}
app_process() {
    app=${1}
    if [ ! -e "${app}" ]; then
        trace "[WARNING] The application '${app}' not found!"
        return
    fi
    name=$(basename "${app}")
    cleanup_proofingtool "${name}" "${app}"
    create_symlink "${name}" "${app}" "Contents/Resources/DFonts"
    create_symlink "${name}" "${app}" "Contents/Frameworks/MicrosoftOffice.framework"
    create_symlink "${name}" "${app}" "Contents/Frameworks/OutlookCore.framework"
    create_symlink "${name}" "${app}" "Contents/Frameworks/OfficeArt.framework"
    create_symlink "${name}" "${app}" "Contents/Resources/Office Themes"
    create_symlink "${name}" "${app}" "Contents/Resources/Fonts"
    create_symlink "${name}" "${app}" "Contents/Frameworks/mso40ui.framework"
    create_symlink "${name}" "${app}" "Contents/Frameworks/mso99.framework"
    create_symlink "${name}" "${app}" "Contents/Frameworks/Chart.framework"
    create_symlink "${name}" "${app}" "Contents/Resources/DocsUIBundle_Mac.bundle"
    create_symlink "${name}" "${app}" "Contents/Frameworks/Visual Basic for Applications.framework"
    create_symlink "${name}" "${app}" "Contents/Frameworks/MicrosoftCSI.framework"
    create_symlink "${name}" "${app}" "Contents/Frameworks/msospectre.framework"
}

echo "Log file: ${logfile}"
echo ""
echo "--[Before]----------------------------"
show_size
echo "--------------------------------------"
read -p "Continue (y/N)? " opt

if [ "${opt:-"N"}" == "Y" ] || [ "${opt}" == "y" ]; then
    app_process "/Applications/Microsoft Word.app"
    app_process "/Applications/Microsoft Excel.app"
    app_process "/Applications/Microsoft Outlook.app"
    app_process "/Applications/Microsoft PowerPoint.app"
    echo "--[After ]----------------------------"
    show_size
    echo "--------------------------------------"
else
    echo "Skip"
fi
