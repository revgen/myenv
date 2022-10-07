#!/usr/bin/env bash
title() {
  echo "============================================================"
  echo "$*"
  echo ""
}

start_tests() {
    title "Start tests (system=${OSNAME})"
    echo "PATH=${PATH}"
    myenv --version || exit 1
    ls test-* | grep -v "test-installation.sh" | while read -r test_script; do
        echo "------------------------------------------------------------"
        echo "Execute test '${test_script}'..."
        bash "${test_script}"
        test_errcode=$?
        if [ "${test_errcode}" -eq 0 ]; then
            echo "[OK ] Execute test '${test_script}'"
        else
            echo "[ERR] Execute test '${test_script}'"
            return 1
        fi
    done
}

finish_tests() {
    title "End tests (system=${OSNAME})"
    if [[ "${errors}" != "0" ]]; then
        echo "Failed: ${errors} errors"
        exit 1
    fi
    echo "Success"
}
#------------------------------------------------------------------------------
case "${OSTYPE}" in
  linux*)
    if grep "Microsoft\|WSL" /proc/sys/kernel/osrelease > /dev/null; then export OSNAME=wsl;
    else export OSNAME=linux; fi
    ;;
  darwin*)  export OSNAME=macos ;;
  *)        export OSNAME=unknown ;;    # solaris* / bsd* / msys* / cygwin*
esac

errors=0
cd "$(dirname "${0}")"
if ! start_tests; then errors=1; fi
cd - >/dev/null

finish_tests
