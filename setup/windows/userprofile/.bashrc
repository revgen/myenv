# option processing has set $color to yes, no or auto
if [ "${color:-"auto"}" == "auto" ]; then
    if [ -t 1 ]; then
        export color=yes
    else
        export color=no
    fi
fi
if [ "${color}" == "yes" ]; then
    export PS1="\[\033[32m\]\u@\h\[\033[35m\]:\[\033[33m\]\W\[\033[0m\]\$ "
else
    export PS1="\u@\h:\W\$ "
fi

# Bash history settings
export HISTCONTROL=ignoreboth:erasedups

alias c='clear'
alias toclip='clip'
alias ws='cd "${HOME}/Workspace"; pwd'
alias mc='start /MAX "mc.exe"'
alias apk='choco'
alias apt='choco'
alias vscode='code'
alias du0='du -sh'

du1() {
    du -hd 1 "${1:-"."}" | sort -h
}

# ---- Windows specific --------------
export GIT_SSH="/c/Program Files/PuTTY/plink.exe"
# force using color for node.js under the Windows Mintty
export FORCE_COLOR=true

sudo() {
    if [ "${1:-"--help"}" == "--help" ]; then
        echo "Usage: sudo <command>"
        return 1
    fi
    powershell -Command "Start-Process cmd -Verb RunAs -ArgumentList '/c $@'"
}

if [ -z "$(which code 2>/dev/null)" ] && [ -z "$(alias | grep code | grep ' code=')" ]; then
    alias code='"${USERPROFILE}/AppData/Local/Programs/Microsoft VS Code/Code.exe"'
fi

uname -a
