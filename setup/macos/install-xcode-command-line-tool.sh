#!/bin/sh
echo "==[ Install command line tool ]========================================="
xcode-select --install

echo "==[ Agree to the license ]=============================================="
sudo xcodebuild -license
