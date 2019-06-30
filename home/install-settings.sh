#!/bin/sh
set -o nounset
set -o errexit
export MYENVHOME=${MYENVHOME:-"${HOME}/.local/var/myenv"}
. ${MYENVHOME}/home/.config/user.env
export PATH=${MYENVHOME}/home/bin:${PATH}
ostype=$(uname -s | tr '[:upper:]' '[:lower:]' | sed 's/darwin/macos/g')

SCRIPT_DIR=$(fullpath "$(dirname "${0}")")
echo "==[ Install main settings: start ]========================================="
echo ">>> Copy private environment settings"
ln-safe "${MYENVHOME}/home/.vimrc" "$HOME/.vimrc"
ln-safe "${MYENVHOME}/home/.screenrc" "$HOME/.screenrc"
ln-safe "${MYENVHOME}/home/.gitconfig" "$HOME/.gitconfig"
ln-safe "${MYENVHOME}/home/.vim" "$HOME/.vim"
ln-safe "${MYENVHOME}/home/.mplayer" "$HOME/.mplayer"
ln-safe "${MYENVHOME}/home/.config/mc" "$HOME/.config/mc"
ln-safe "${MYENVHOME}/home/.elinks/elinks.conf" "$HOME/.elinks/elinks.conf"
ln-safe "${MYENVHOME}/home/.moc/config" "$HOME/.moc/config"
ln-safe "${MYENVHOME}/home/.moc/track-changed" "$HOME/.moc/track-changed"
ln-safe "${MYENVHOME}/home/.moc/themes" "$HOME/.moc/themes"
if [ "${ostype}" == "linux" ]; then
    ln-safe "${MYENVHOME}/home/.config/openbox" "$HOME/.config/openbox"
fi
ln-safe  --copy "${MYENVHOME}/home/.config/wallpaper.jpg" "$HOME/.config/wallpaper.jpg"

echo ">>> Update bash_profile and bashrc configuration files"
myenv_bashrc=${MYENVHOME}/home/.config/user.bashrc
user_bashrc=${HOME}/.bashrc
touch "${HOME}/.bashrc"
touch "${HOME}/.bash_profile"
echo "  - Add bashrc to bash_profile"
if [ -z "$(grep ".bashrc" "$HOME/.bash_profile")" ]; then
    echo "[[ -s $HOME/.bashrc ]] && source $HOME/.bashrc" >> "$HOME/.bash_profile"
fi
echo "  - Add MYENVHOME to the ${HOME}/.bashrc"
if [ -z "$(grep "export MYENVHOME=" "${HOME}/.bashrc")" ]; then
    echo "export MYENVHOME=${MYENVHOME}" >> "${HOME}/.bashrc"
fi
echo "  - Add user.bashrc to the ${HOME}/.bashrc"
if [ -z "$(grep "${myenv_bashrc}" "${HOME}/.bashrc")" ]; then
    echo ". \"${myenv_bashrc}\"" >> "${HOME}/.bashrc"
fi
echo "  - Check ${HOME}/.bash_profile"
cat "$HOME/.bash_profile" | awk '{printf("%d: %s\n", NR, $0)}' | grep ".bashrc"
echo "  - Check ${HOME}/.bashrc"
cat "${HOME}/.bashrc" | awk '{printf("%d: %s\n", NR, $0)}' | grep "user.bashrc\|MYENVHOME"

echo "==[ Install main settings: end   ]========================================="
