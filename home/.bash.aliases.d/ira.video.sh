# Get cracking on some demuxing

function demuxaudio () {
    about 'Demux audio out of a .mov/.avi/.mp4 file.'
    group 'gif'
    param '1: MOV/AVI/MP4 file name(s)'

    for file ; do

        local output_file="${file%.*}"
        local output_suffix="$(mediainfo "$file" | grep "Format  " | \
            tail -1 | awk '{print $3}' | tr A-Z a-z)"
        # Common names
        [[ $output_suffix == "opus" ]] && output_suffix="ogg"

        ffmpeg -loglevel panic -i "${file}" -c:a copy -vn -sn "${output_file}.${output_suffix}"

    done
}
