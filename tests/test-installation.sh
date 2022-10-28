#!/usr/bin/env bash
cd "$(dirname "${0}")/.."
. ./tests/env.sh

start_tests

echo "Testing..."

finish_tests
