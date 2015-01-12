# bose-scripts
Small scripts to control a networked Bose audio system on Linux. These should work with any Bose SoundTouch system (tested with the Wave SoundTouch).

## Setup

By following these steps, you will be able to use the ``bose-play.sh`` script to start playing any media file or Youtube audio on your Bose device.

* Go through the normal setup of the Bose system using the provided software. The software runs fine in Wine.
* Install the following software:
    - [expect](http://expect.sourceforge.net/)
    - ffmpeg
    - minidlna (or equivalent streaming software)
    - youtube-dl (optional, for playing Youtube videos)
* Configure minidlna with the media directory ``/tmp/bose-audio``.
* Find your device's IP address and set the ``BOSE_ADDR`` environment variable to this value.
* Try running the ``bose-play.sh`` script with some valid file or URL. It will likely not play any audio, but this will create a file in the minidlna media directory.
* Using the Bose software, add the minidlna server as a media source. Go to ``Music -> Album -> PC`` and start playing the only file there, ``in.mp3``.
* Press and hold Preset 1 to set it to play the ``PC`` album.

With this finished, future runs of ``bose-play.sh`` should automatically start playing the desired file.

## Usage

Run the ``bose-play.sh`` script with one argument, the file or URL to retrieve media from. Currently, only sites supported by ``youtube-dl`` will work.

``./bose-play.sh [media-file]``

``./bose-play.sh [youtube-url]``

## How it works

The Bose SoundTouch systems open several ports. Port 17000 has an interactive shell-like program that understands a variety of commands, including remote control button press simulation. With this capability, the scripts can tell the system to start playing one of the presets.

To play music, you normally must click through the Bose software to find the song you want. The setup instructions above tell how to configure a streaming daemon (like minidlna) to point to a folder that will only have a single MP3 file; by doing so, it is guaranteed that the song you want will play.

To tie this all together, the ``bose-play.sh`` script simply converts a source file to MP3 (one of the few supported formats), replaces the single streaming file, and sends remote keypresses to restart play from the streaming server.

## Bose automation

If ``bose-play.sh`` is not useful for you (its very system specific), you could write your own scripts based off of the ``bose-key.sh`` script. This script will send a passed keypress to your Bose system. See that file for a list of the known keypress identifiers.
