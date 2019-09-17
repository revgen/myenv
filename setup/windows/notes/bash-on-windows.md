Bash on windows
Home Dir on Windows: /c/Users/${USERNAME} -> %USERPROFILE%


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

# windows specific
alias toclip='clip'
alias ws='cd "$USERPROFILE\Documents\Workspace"; pwd'



---- Bash notes ----
https://unix.stackexchange.com/questions/9957/how-to-check-if-bash-can-print-colors
### In a shell script, use [ -t 1 ] to test if standard output is a terminal.

# check if stdout is a terminal...
if test -t 1; then
   echo "Color in terminal"
else
  echo "Grayed for pipe"
fi