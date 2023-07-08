#!/usr/bin/env bash
cd "$(dirname "${0}")/../.."

new_version=${1:-"0.0.1"}

update_sh_file() {
    version="${1}"
    filepath="${2}"
    echo "Putting new version ${version} to the ${filepath} file..."
    cp "${filepath}" "${filepath}.orig"
    cat "${filepath}.orig" \
    | sed 's/^VERSION=[0-9]*\.[0-9]\.[0-9]/VERSION='"${version}"'/' \
    > "${filepath}" && rm -f "${filepath}.orig"
    grep "^VERSION=" "${filepath}"
    echo "Done with the ${filepath} file"
}

update_sh_file "${new_version}" "./myenv"
update_sh_file "${new_version}" "./install-myenv.sh"
