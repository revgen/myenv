###############################################################################
# Custom user bashrc file settings.
###############################################################################
if [ -z "$HOME" ]; then
    OLDPWD=${PWD}; cd ~ ; export HOME=${PWD}; cd ${OLDPWD}
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#------------------------------------------------------------------------------
export PS1="\u@\h:\W\$ "

# ------[ Terminal settings]---------------------------------------------------
if [[ $TERM == *color ]]; then color_prompt=yes; fi
#export LS_COLORS=

# ------[ Environment ]--------------------------------------------------------
export EDITOR=$(which vim || which vi)
if [ -f "${MYENVHOME}/home/.config/user.env" ]; then
    . ${MYENVHOME}/home/.config/user.env
else
    echo "Warning: <MYENVHOME>/home/.config/user.env not found"
fi

echo ${EDITOR} > ~/.selected_editor
mkdir -p "${BACKUP}" 2> /dev/null
mkdir -p "${PYTHON_VIRTUAL_ENV}" 2> /dev/null
mkdir -p "${USERBIN}" >/dev/null

# ------[ Tool's settings ]----------------------------------------------------
stty stop '';                                   # Fix Ctrl+S inside the vim
export GPG_TTY='tty';                           # need for gnupg.vim plugin

# ------[ Console History ]----------------------------------------------------
export HISTCONTROL=ignoreboth;      # Don't add similar command in the history
shopt -s histappend;                # Store command into the history immediately
PROMPT_COMMAND='history -a'
export HISTSIZE=9999;               # Store more commands in the history

# Prevent tar and other programs from giving special meaning to ._* archive members
export COPYFILE_DISABLE=1

# ------[ Aliases ]------------------------------------------------------------
if [ -f "${MYENVHOME}/home/.config/user.bash_aliases" ]; then
    . ${MYENVHOME}/home/.config/user.bash_aliases
fi

# ------[ OS specific: load specific macos or linux bashrc settings ]------------
if [ -f "${MYENVHOME}/home/.config/user.${OSTYPE}.bashrc" ]; then
    . ${MYENVHOME}/home/.config/user.${OSTYPE}.bashrc
fi

if [ -f "${WORKSPACE}/.config/.bashrc" ]; then . "${WORKSPACE}/.config/.bashrc"; fi

# ------[ Customer welcome screen ]--------------------------------------------
w | head -n 1
echo -e "   Active users: $(w -h | cut -d " " -f1 | sort -r | uniq | awk '{printf"%s%s",c,$0;c=", "}')
Local addresses: $(localip | awk '{printf"%s%s",c,$0;c=", "}')"

# ------[ Log ] ---------------------------------------------------------------
if [ -n "$DISPLAY" ]; then
    logger -t "${USER}.env"  "bash: init X-session"
elif [ -n "$SSH_TTY" ]; then
    logger -t "${USER}.env"  "bash: init ssh session [$SSH_CLIENT,$SSH_CONNECTION]"
fi

