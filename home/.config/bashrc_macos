export TERM=xterm-256color

if [ -n "$SSH_TTY" ]; then export TERM=xterm; fi  # fix "screen" on OSX
# supress zsh verbose message in macOS 10.15+
export BASH_SILENCE_DEPRECATION_WARNING=1

export PATH="${HOME}/.local/bin:/opt/homebrew/bin:${PATH}"

if [ -z "${JAVA_HOME}" ] && [ -x "/usr/libexec/java_home" ]; then
  JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)
  export JAVA_HOME="${JAVA_HOME}"
fi
if [ -z "${NODE_PATH}" ] && [ -d "/usr/local/lib/node_modules" ]; then
  export NODE_PATH=/usr/local/lib/node_modules
fi

# Fix the DISPLAY variable if it is empty
if [ -z "$SSH_TTY" ] && [ -z "$DISPLAY" ]; then
    export DISPLAY=":0"
fi

#-- Useful aliases -----------------------------------------------------------
alias lt='ls -ATlh'
alias ports='lsof -i -n -P'
alias osinfo='sw_vers'
alias osver='sw_vers -productVersion'
alias srm='rm -rvP'
alias sdelete='rm -rvP'
alias brew-cleanup='brew cleanup; rm -f -r /Library/Caches/Homebrew/*'
alias xopen='/usr/bin/open'
alias preview='open -a Preview.app'
alias nproc='sysctl -n hw.ncpu'
alias ncdu-root='sudo ncdu / --exclude /Volumes --exclude /System/Volumes --exclude /dev --exclude /private'

#-- Useful functions ----------------------------------------------------------
toclip() {
  #remove last 'newline' char and copy to clipboard
  awk '{q=p;p=$0}NR>1{print q}END{ORS = ""; print p}'| pbcopy
}

fromclip() {
    pbpaste
}

iterm_title () {
    TITLE=${1:-"$(basename "${PWD}")"}
    export PROMPT_COMMAND='echo -ne "\033]0;$TITLE\007"'
}