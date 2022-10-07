#!/bin/bash

echo "-----------------------------------------------------"
echo "You current system kernel is:"
uname -r
echo "-----------------------------------------------------"
echo "Other 'old' kernels in your system:"
dpkg -l | grep -E 'linux-image-[0-9]+' | grep -Fv $(uname -r) | awk '{print $1"\t"$2"\t" $3}'
echo ""
echo "#There will be three status in the listed kernel images:"
echo "  rc: means it has already been removed."
echo "  ii: means installed, eligible for removal."
echo "  iU: DON’T REMOVE. It means not installed, but queued for install in apt."
echo "-----------------------------------------------------"
echo ""

