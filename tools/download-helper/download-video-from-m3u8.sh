#!/bin/sh
url=${1}
case "${url:-"help"}" in
    --help|help) echo "Use: $(basename "${0}") <url to m3u8>"; exit 1;;
esac

title=${2:-"$(basename "${url}")"}
name=$RANDOM
dir=/tmp/$(basename "${0}")/${name}
cache=${dir}/cache
mkdir -p "${cache}" 2>/dev/null
playlist="${dir}/index.m3u8"

download_file() {
    url=${1}
    target=${2}
    echo "Downloading ${url}..."
    wget -O "${target}" "${url}" || exit 1
    echo "Download complete"
}

video_links_from_playlist() {
    url=${1}
    playlist=${2}
    root_url=$(dirname "${url}")
    # echo "Base url for playlist: ${root_url}"
    grep -v "^#" ${target} | while read p; do
        echo "${root_url}/${p}"
    done
}

func1() {
linkRoot=$(dirname "${videoLink}")
echo "Link root: ${linkRoot}"
    echo "Parsing playlist ${playlist}..."
    cat "${playlist}" | grep -v "^#" > "${playlist}.1"
    count=$(tail -n 1 "${playlist}.1" | sed 's/segment//g' | sed 's/.ts//g')
    echo "Total video counts = ${count}"
    cat "${playlist}.1" | while read n; do
        url=${linkRoot}/${n}
        echo ">>> Download ${url}"
        wget -O "${dir}/${n}" "${url}" || (echo 'Error!!!' && exit 1)
    done
    echo "Download complete"
    du -ach ${dir}/*.ts | grep total
    echo "Converting..."
    for i in $(ls ${dir}/*.ts | sort -V); do
        echo "file $i"
    done > "${dir}/video.lst"
    [ ! -f "${dir}/video.lst" ] && echo "List file '${dir}/video.lst' not created"
}

merge_all_videos() {
    video_list_file=${1}
    video_output_name=${2}
    echo "Concatenate all segments into the one file ${video_output_name}..."
    ffmpeg -f concat -safe 0 -i "${video_list_file}" -c copy -bsf:a aac_adtstoasc "${video_output_name}"
    if [ -f "${video_output_name}" ]; then
        echo "Result file: ${video_output_name}"
    else
        echo "Error"
        exit 1
    fi
    #echo "Done. Renaming..." && (mkdir -p $HOME/Downloads/.z 2>/dev/null || true) && \
    #mv "${dir}/video.mp4" "$HOME/Downloads/.z/${videoName}.mp4" && \
    #du -hd0 "$HOME/Downloads/.z/${videoName}.mp4" && \
    #echo "Cleaning..." && \
    #rm -r "${dir}" && \
    echo "Done"
}

download_file "${url}" "${playlist}"
video_links_from_playlist "${url}" "${playlist}" | while read part_url; do
    idx=$(python -c 'import time; print time.time()')
    name=${idx}.ts
    download_file "${part_url}" "${cache}/${name}"
done

echo "Creating video list for conversion..."
for i in $(ls ${cache}/*.ts | sort -V); do
    echo "file $i"
done  > "${cache}/video.lst"
[ ! -f "${cache}/video.lst" ] && echo "List file '${dir}/video.lst' not created"

output_file=${dir}/${title}.mp4
merge_all_videos "${cache}/video.lst" "${output_file}"
echo "Clean all cache files"
rm ${cache}/*.ts
echo "Done: ${output_file}"

