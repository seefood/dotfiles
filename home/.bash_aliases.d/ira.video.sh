#!/bin/bash

# Get cracking on some demuxing

function demuxaudio() {
	about 'Demux audio out of a .mov/.avi/.mp4 file.'
	group 'gif'
	param '1: MOV/AVI/MP4 file name(s)'

	for file; do
		local output_file="${file%.*}"
		local output_suffix
		output_suffix="$(mediainfo "$file" | grep "Format  " |
			tail -1 | awk '{print $3}' | tr '[:upper:]' '[:lower:]')"
		# Common names
		[[ $output_suffix == "opus" ]] && output_suffix="ogg"
		ffmpeg -loglevel panic -i "${file}" -c:a copy -vn -sn "${output_file}.${output_suffix}"
	done
}

function av1() {
	local destfile vidfile
	for vidfile in "$@"; do
		destfile="${vidfile%%.mp4}.av1.mp4"
		if test -e "$destfile"; then
			echo "$destfile already exists, not going to ovewrite it."
			return 1
		fi
		if ! test -e "$vidfile"; then
			echo "$vidfile does not exist, skipping."
		else
			ffmpeg -loglevel error -i "$vidfile" -pix_fmt yuv420p10le -strict -1 -f yuv4mpegpipe - |
				SvtAv1EncApp -i stdin --passes 2 --rc 0 --crf 43 --preset 8 --input-depth 10 -b stdout |
				ffmpeg -i - -i "$vidfile" -map 0:v -map 1:a:0 -c:a copy -c:v copy "$destfile"
		fi
	done
}
