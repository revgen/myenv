###############################################################################
# Custom user bashrc file settings specific for Linux system.
###############################################################################
alias lt='ls -AElh'
alias ports='netstat -tulpan'
alias osinfo='lsb_release -a'
alias osver="lsb_release -a 2>/dev/null | grep Release | awk '{print $2}'"
alias psc='ps aux --sort=-pcpu | head'
alias psm='ps aux --sort=-pmem | head'
alias sdelete='shred -vfz'
alias moc='mocp'

export JAVA_HOME="/usr/lib/jvm/java-8-oracle/"

toclip() {
    #remove last 'newline' char and copy to clipboard
    awk '{q=p;p=$0}NR>1{print q}END{ORS = ""; print p}'| xclip -selection clipboard
}

fromclip() {
    xclip -selection clipboard -o
}
