#!/usr/bin/env bash
set -e

echo "The script is installing ncspot (Spotify TUI client) to the system."
echo "Project homepage: https://github.com/hrkfdn/ncspot"
echo ""
if [ -t 0 ]; then
    echo "Press any key to continue (Ctrl+C to exit)..."
    read -n 1
    echo ""
fi

echo "Geting latest version..."
curl -s https://api.github.com/repos/hrkfdn/ncspot/releases | jq -r '.[].assets.[].browser_download_url' | grep "macos" \
    | tee /tmp/ncspot-links.txt | head -n 10
version="$(cut -d'/' -f8 /tmp/ncspot-links.txt | sort --version-sort -r | head -n 1)"
echo "Latest version is ${version}"
if [ -z "${version}" ]; then echo "Error: version incorrect"; exit 1; fi

link="$(grep "${version}" /tmp/ncspot-links.txt | grep ".tar.gz" | grep "$(uname -p | sed 's/i386/x86_64/g')")"
echo "Downloading ${link}..."
curl -Lko "ncspot.tar.gz" "${link}" || exit 1

echo "Unpacking..."
tar xzfv ncspot.tar.gz
rm ncspot.tar.gz
chmod +x ncspot

echo "Copy ncspot to the system"
if [ -w /usr/local/bin ]; then
	mv -vf ncspot /usr/local/bin || exit 1
else
	mkdir -p ~/.local/bin/
	mv -vf ncspot ~/.local/bin/ || exit 1
fi

echo "Done"
which ncspot
ncspot --version
<<<<<<< HEAD
=======

>>>>>>> 94003a9 (Save)
