#!/bin/sh
echo "Keep your Mac awake when this script is running"
echo ""
timeout_day=86400
timeout=${1:-"${timeout_day}"}
case "${1}" in
    help|--help)
        echo "Usage: $(basename "${0}") [timeout seconds]"
        ;;
    *)
        echo "Started on $(date)"
        if [ "${timeout}" == "${timeout_day}" ]; then
            echo "Press Ctrl+C to stop or wait for one day."
        else
            echo "Press Ctrl+C to stop or wait for ${timeout} seconds."
        fi
        caffeinate -idum -t ${timeout} && echo "Done"
        ;;
esac