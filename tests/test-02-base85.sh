#!/usr/bin/env bash
set -e

echo "Check base85"
echo "Test-message" | myenv base85 \
| grep "<+U,m/T#'?F(&]m$3"
echo "Check base85 - success"
