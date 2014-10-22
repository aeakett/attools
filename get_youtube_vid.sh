#!/bin/bash

if (( $# < 1 )); then
   echo "Usage: $0 video_url base_file_name"
        exit 1
fi

# if we haven't been given a base file name set it to be blank, otherwise, set it appropriatly
if  [ -z $2 ]
then
   BASE_NAME=
else
   BASE_NAME="--output $2.%(ext)s"
fi

YTDL_ARGS="--write-auto-sub --write-description --write-info-json --write-annotations --youtube-include-dash-manifest --all-subs"

youtube-dl $YTDL_ARGS $BASE_NAME $1
zip $2.subtitles.zip *.srt
rm *.srt