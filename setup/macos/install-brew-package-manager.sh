#!/bin/sh
# The last installation command can be found on the official page:
# https://brew.sh/

echo "==[ Install homebrew ]=================================================="
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "==[ Update homebrew ]==================================================="
brew update

# xcode-select --install
# sudo xcodebuild -license
