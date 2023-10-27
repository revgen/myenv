#!/usr/bin/env bash
NOFORMAT='\033[0m'
INFO='\033[0;32m'
title() {
    echo -e "${INFO}==[ ${@} ]======${NOFORMAT}"
}

cd "$(dirname "${0}")/../.."
echo "Project directory is ${PWD}"

if [ -z "$(which ruff 2>/dev/null)" ]; then echo "Python ruff tool is required"; exit 1; fi
if [ -z "$(which shellcheck 2>/dev/null)" ]; then echo "Shellcheck tool is required"; exit 1; fi

title "Check python scripts..."
log_file="/tmp/$(basename "${0}").log"
rm -r "${log_file}"
for path in $(echo "./home/.local/bin/ ./tools"); do
    echo "Processing ${path}"
    (find "${path}" -iname "*.py"; grep -rl "/python\|env python" "${path}") \
    | sort -u | while read py_file; do
        ruff "${py_file}" | tee -a "${log_file}"
    done
done
if grep "Found" "${log_file}" | grep -q "error"; then echo "Python code checked with errors."; exit 1; fi
echo "Python code checked successfully."

title "Check schell scripts..."
# ./tools/shlint ./home/.local/bin/
#  && \
# ./tools/shlint ./tools/ && exit 1
echo "Shell code checked successfully."
