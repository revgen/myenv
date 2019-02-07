###############################################################################
# Custom user bashrc file settings for MacOS system.
####################################i###########################################
if [ -n "$SSH_TTY" ]; then export TERM=xterm; fi # fix "screen" on OSX
if [ -f /etc/bash_completion ]; then  . /etc/bash_completion; fi
if [ -d "${USERBIN}" ]; then
    # Hide ../bin directory from Finder by default 
    chflags hidden "${USERBIN}"
fi

toclip() {
    #remove last 'newline' char and copy to clipboard
    awk '{q=p;p=$0}NR>1{print q}END{ORS = ""; print p}'| pbcopy
}

fromclip() {
    pbpaste
}


iterm_title () {
    TITLE=$*;
    if [ -z "${TITLE}" ]; then TITLE=$(basename "${PWD}"); fi
    export PROMPT_COMMAND='echo -ne "\033]0;$TITLE\007"'
}

open_app() {
    [ -z "${1}" ] && echo "Error: usage open_app <app_name> [arg1]" && exit 1
    if [ -z "${2}" ]; then
        /usr/bin/open -a "${1}" "${2}"
    else
        /usr/bin/open -a "${1}"
    fi
}

alias lt='ls -ATlh'
alias ports='lsof -i -n -P'
alias osinfo='sw_vers'
alias osver='sw_vers -productVersion'
alias srm='rm -rvP'
alias sdelete='rm -rvP'
alias brew-cleanup='brew cleanup; rm -f -r /Library/Caches/Homebrew/*'
alias mp3tag='kid3'

export JAVA_HOME=$(/usr/libexec/java_home)
export NODE_PATH=/usr/local/lib/node_modules
export PATH="$HOME/Library/Python/2.7/bin:$PATH:/usr/local/sbin"
export BACKUP_DIRECTORIES="${HOME}/Library/Containers/com.syniumsoftware.ifinance4;/Applications/1Password.app;${HOME}/Library/Containers/*com.agilebits.onepassword-osx-helper;"

if [ -z "$SSH_TTY" ]; then
    # Fix the DISPLAY variable if it is empty
    if [ -z "$DISPLAY" ]; then
        export DISPLAY=":0"
    fi
fi
