#!/bin/sh
# Custom startup script
# put this script into the /usr/local/etc/rc.d/ directory

start() {
    LOG=/var/log/`basename "${0}"`.log
    echo "Write text to log file: ${LOG}"
    echo "`date` [$name]: $@" | tee -a "${LOG}"

    echo "Start custom services"
    service httpserver start
}
case "${1:-"help"}" in
	start) start ;;
	help|--help) echo "Usage: $0 start"; exit 1 ;;
	*) echo "Error: unknown command '$1'."; exit 1 ;;
esac

