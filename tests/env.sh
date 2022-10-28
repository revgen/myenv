#!/usr/bin/env bash
case "${OSTYPE}" in
  linux*)
    if grep "Microsoft\|WSL" /proc/sys/kernel/osrelease > /dev/null; then export OSNAME=wsl;
    else export OSNAME=linux; fi
    ;;
  darwin*)  export OSNAME=macos ;;
  *)        export OSNAME=unknown ;;    # solaris* / bsd* / msys* / cygwin*
esac

errors=0

title() {
  echo "============================================================"
  echo "$*"
  echo ""
}

start_tests() {
    title "Start tests (system=${OSNAME})"
}

finish_tests() {
    title "End tests (system=${OSNAME})"
    if [[ "${errors}" != "0" ]]; then
        echo "Failed: ${errors} errors"
        exit 1
    fi
    echo "Success"
}

