#!/bin/sh
#=============================================================================
## Jekyll helper script
## Usage: {SCRIPT_NAME} <install|init|build|serve|clean>
#=============================================================================
case "${1:-"help"}" in
    install) gem install jekyll bundler ;;
    init|new) /usr/local/bin/jekyll new $2 ;;
    build)  /usr/local/bin/jekyll build ;;
    serve)  /usr/local/bin/jekyll serve --port ${2:-"8080"} ;;
    clean)  /usr/local/bin/jekyll clean ;;
    help|*) sed -n '/^##/,/^$/s/^## \{0,1\}//p' "$0" | sed 's/{SCRIPT_NAME}/'"$(basename "$0")"'/g' ;;
esac

