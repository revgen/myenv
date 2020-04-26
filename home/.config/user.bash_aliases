alias cdme='cd ${MYENVHOME} && pwd'
alias me=myenv

alias :q='exit'
alias ll='ls -alFh'
alias l='ll'
alias ltree='ls -R|grep ":$"|sed -e "s/:$//" -e "s/[^-][^\/]*\//--/g" -e "s/^/   /" -e "s/-/|/"'
alias c='clear'
alias s='ssh'
alias ..='cd ..'
alias ...='cd ../..'
alias j='jobs -l'
# allow tree show unicode symbols
alias tree='tree -N'
#alias pygmentize='pygmentize -O style=monokai -f console256 -g'
alias vscode='code'
alias lower='tr "[:upper:]" "[:lower:]"'
alias upper='tr "[:lower:]" "[:upper:]"'
alias newline_to_comma="awk '{printf\"%s%s\",c,$0;c=\", \"}'"
alias lynx='lynx -accept_all_cookies'
alias docs='cd ${HOME}/Documents && pwd'
alias down='cd ${HOME}/Downloads && pwd'
alias ws='cd ${WORKSPACE} && pwd'

alias neofetch='neofetch --color_blocks off --off'

alias edit=${EDITOR}
alias v='edit'
alias bc='bc -l'
[ -z "$(which sha1sum)" ] && alias sha1sum='shasum -a 1'
[ -z "$(which sha256sum)" ] && alias sha256sum='shasum -a 256'
[ -z "$(which sha512sum)" ] && alias sha512sum='shasum -a 512'
alias tig='tig --all'
alias hex='xxd'
alias tohex='xxd -p'
alias fromhex='xxd -p -r'
alias line_number='awk '\''{printf("% 6d %s\n", NR, $0)}'\'
alias mpg123='mpg123 -Cv'
alias mplayer='mplayer -af volnorm'
alias mp3tag='kid3'

alias xml-to-json='python3 -m xmljson'

alias linuxdev-start='docker run -dit -v ${HOME}/Downloads:/root/Downloads --name=linuxdev ubuntu:18.04 bash'
alias linuxdev-stop='docker stop linuxdev; docker rm linuxdev'
alias linuxdev-sh='docker exec -it linuxdev bash'
alias linuxdev-status='docker ps --filter name=linuxdev'

# ------[ Custom tools ]-------------------------------------------------------
mkcd() {
    case "${1:---help}" in
        help|--help)
            echo "Create directory and go into"
            echo "Usage: mkcd <directory name>" ;;
        *)
            if [ ! -d "$1" ]; then mkdir -p "$@" && cd $_ ;
            else cd $1; fi
            ;;
    esac
}

mkcd-now() {
    mkcd $(date +"%Y%m%d-%H%M%S")
}

mkcd-today() {
    mkcd $(date +"%Y%m%d")
}

echo_red()      { echo $'\e[32;1m'$1$'\e[0m'; }
echo_blue()     { echo $'\e[36;1m'$1$'\e[0m'; }
echo_green()    { echo $'\e[32;1m'$1$'\e[0m'; }
echo_yellow()   { echo $'\e[33;1m'$1$'\e[0m'; }
echo_white()    { echo $'\e[37;1m'$1$'\e[0m'; }

alias echo-red=echo_red
alias echo-blue=echo_blue
alias echo-green=echo_green
alias echo-yellow=echo_yellow
alias echo-white=echo_white

echo_log()      { echo $(date +"%Y-%m-%dT%H:%M:%S ") $@; }
alias echo-log=echo_log

