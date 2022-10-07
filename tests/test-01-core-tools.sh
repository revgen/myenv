#!/usr/bin/env bash
set -e
echo "Current directory: $(pwd)"

echo "Check localip"
localip | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
echo "Check localip - success"

echo "Check externalip"
externalip | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
echo "Check externalip - success"

echo "Check myenv-logo"
myenv-logo
echo "Check myenv-logo - success"

echo "Check sysinfo"
tmpfile=.sysinfo.tmp
sysinfo | tee "${tmpfile}"
grep "Local IP" "${tmpfile}"
grep "Public IP" "${tmpfile}"
grep "Internet" "${tmpfile}" | grep "CONNECTED"
grep "Local time" "${tmpfile}"
grep "UTC time" "${tmpfile}"
echo "Check sysinfo - success"
