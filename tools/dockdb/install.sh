#!/bin/sh
URL=https://raw.githubusercontent.com/revgen/docker-repository/master/docker-database/bin/dockdb
download_url() {
    if [ -z "$(which curl)" ]; then curl -so ${1} "${2}";
    else wget -qO ${1} "${2}"; fi
}

echo "Download dockdb tool"
download_url "${BIN}/dockdb" "URL" && \
chmod +x "${BIN}/dockdb" && \
ls -ahl "${BIN}/dockdb" && \
echo "Done"
