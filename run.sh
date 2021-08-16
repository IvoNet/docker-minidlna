#!/usr/bin/env bash
docker run \
   --rm \
   --name IvoNetDLNA \
   --net=host \
   -v "/Volumes/video/Movies/:/videos" \
   -e MINIDLNA_FRIENDLY_NAME="FooBarBaz DLNA" \
   -e MINIDLNA_NOTIFY_INTERVAL=10 \
   -e MINIDLNA_MEDIA_DIR_DOWNLOADS="V,/downloads" \
   -v "/Volumes/downloads:/downloads" \
   -e MINIDLNA_MEDIA_DIR_MUSIC="A,/music" \
   -v "${HOME}/Music:/music" \
   -e MINIDLNA_MEDIA_DIR_PICTURES="P,/pics" \
   -v "${HOME}/Pictures:/pics" \
   -v "$(pwd)/.data:/minidlna" \
   ivonet/minidlna
