#!/bin/sh

echo "Add repository with Node.js 14.x"
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - || exit 1

echo "Install it from repository"
sudo apt -y install nodejs || exit 1

echo "Show version"

