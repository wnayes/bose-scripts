#!/bin/bash

# Check argument was passed.
if [[ -z "$1" ]]
then
  echo "Please pass a media file to play."
  exit 1
fi

src=$1

# If source was Youtube video, download it first.
if [[ "$src" == http* ]]
then
  rm -f /tmp/bose-youtube-dl
  youtube-dl "$src" -f bestaudio -o /tmp/bose-youtube-dl
  src="/tmp/bose-youtube-dl"
fi

# Ensure Bose is not playing anything right now.
./bose-key.exp stop

# Clear any previous audio files.
rm -f /tmp/bose-audio/in.mp3
mkdir -p /tmp/bose-audio

# Convert to mp3 so Bose understands.
ffmpeg -i "$src" -metadata album="PC" -codec:a libmp3lame -qscale:a 2 /tmp/bose-audio/in.mp3

# Instruct Bose to play.
./bose-key.exp preset_1
./bose-key.exp prev
