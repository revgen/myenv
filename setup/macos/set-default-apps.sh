#!/usr/bin/env bash
# Find AppID: osascript -e 'id of app "VLC"'
VIDEO_APP=org.videolan.vlc
AUDIO_APP=org.videolan.vlc
IMAGE_APP=com.qview.qView
echo "The script is setup default application for media files"
echo "* ${VIDEO_APP} -> videos"
echo "* ${AUDIO_APP} -> audio"
echo "* ${IMAGE_APP} -> images"

if [ -z "$(which duti)" ]; then
    echo "Error: 'duti' tool not found. Please install it first."
    echo "$ brew install duti"
    exit 1
fi

read -p "Continue (y/N)? " opt
[ "${opt}" != "y" ] && echo "Skip" && exit 1

set_default() {
    duti -s "${1:-"UNKNOWN_APP_ID"}" ".${2:-"UNKNOWN-EXT"}" all
    errcode=$?
    if [ $errcode -eq 0 ]; then echo "[OK ] Set defaul app for '${2}' to '${1}'";
    else echo "[ERR] Set default app for '${2}' to '${1}': Errocode = $errcode"; return $errcode;
    fi
}

# Video
set_default "${VIDEO_APP}" avi
set_default "${VIDEO_APP}" mp4
set_default "${VIDEO_APP}" mpeg
set_default "${VIDEO_APP}" flv
set_default "${VIDEO_APP}" mkv
set_default "${VIDEO_APP}" webm
set_default "${VIDEO_APP}" wmv

# Media
set_default "${AUDIO_APP}" mp3
set_default "${AUDIO_APP}" ogg
set_default "${AUDIO_APP}" wav
set_default "${AUDIO_APP}" m3u
set_default "${AUDIO_APP}" pls

#Image
set_default "${IMAGE_APP}" jpg
set_default "${IMAGE_APP}" jpeg
set_default "${IMAGE_APP}" png
set_default "${IMAGE_APP}" bmp
set_default "${IMAGE_APP}" gif
set_default "${IMAGE_APP}" gifx
set_default "${IMAGE_APP}" tiff
set_default "${IMAGE_APP}" webp

