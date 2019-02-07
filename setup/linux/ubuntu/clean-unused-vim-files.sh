#!/bin/sh
vimdir=$(dirname $(ls /usr/share/vim/vim*/defaults.vim))
echo "Clean unused vim resources from '${vimdir} directory"
echo "Directory size before cleaning: $(du -hs "${vimdir}")"
sudo rm -rvf ${vimdir}/lang/*
sudo rm -rvf ${vimdir}/doc/*
sudo rm -rvf ${vimdir}/tutor/*
sudo rm -rvf ${vimdir}/ftp*
sudo find ${vimdir}/keymap -type f ! -iname 'russian-jcuken*.vim' -exec rm -rf {} \;
#sudo find /usr/share/vim/vim*/spell -type f ! -name '*.vim' ! -name 'en.utf-8.spl' -exec rm -vf {} \;
echo "Directory size after cleaning: $(du -hs "${vimdir}")"
