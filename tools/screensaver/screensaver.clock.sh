#!/usr/bin/env bash
#while true; do tput clear; date +"%H : %M : %S" | figlet -c ; sleep 1; done
if [ -z "$(which termsaver)" ]; then
   echo "Error: Can't find termsaver application. Please install it first."
   echo "  # apt-get install termsaver"
   echo "  # pip install termsaver"
else
    termsaver clock
fi

