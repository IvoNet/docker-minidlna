# MiniDLNA

[MiniDLNA](https://sourceforge.net/projects/minidlna/) is a simple media server software.

This image is based on Alpine Linux.

## Usage

You need `--net=host` as you want to have the stuff discoverable on the host network...

Also see the `run.sh` shell script to see a very complete example


The example below is a basic run command with one mandatory mapping to a video directory
```bash
docker run -d \
   --net=host \
   --name MiniDLNA \
   -v "${HOME}/Movies:/videos" \
   ivonet/minidlna
```

If you want to add `media_dir` entries for more directories to be scanned by minidlna you can add the following.

```bash
docker run \
   -d \
   --name IvoNetDLNA \
   --net=host \
   -v "/Volumes/video/Movies/Abduction.2019:/videos" \
   -e MINIDLNA_MEDIA_DIR_DOWNLOADS="V,/downloads" \
   -v "/Volumes/downloads:/downloads" \
   -e MINIDLNA_MEDIA_DIR_MUSIC="A,/music" \
   -v "${HOME}/Music:/music" \
   -e MINIDLNA_MEDIA_DIR_PICTURES="P,/pics" \
   -v "${HOME}/Pictures:/pics" \
   -v "$(pwd)/.data:/var/lib/minidlna" \
   ivonet/minidlna

```
In the original config for minidlna you can see the folowing explanation for getting more folders scanned

```bash
# set this to the directory you want scanned.
# * if you want multiple directories, you can have multiple media_dir= lines
# * if you want to restrict a media_dir to specific content types, you
#   can prepend the types, followed by a comma, to the directory:
#   + "A" for audio  (eg. media_dir=A,/home/jmaggard/Music)
#   + "V" for video  (eg. media_dir=V,/home/jmaggard/Videos)
#   + "P" for images (eg. media_dir=P,/home/jmaggard/Pictures)
#   + "PV" for pictures and video (eg. media_dir=PV,/home/jmaggard/digital_camera)
```

I translated this by allowing for multiple combinations of:

```bash
   -e MINIDLNA_MEDIA_DIR_DOWNLOADS="V,/downloads" \
   -v "/Volumes/downloads:/downloads" 
```

as long as the environment variable starts with MINIDLNA_MEDIA_DIR_<and then something> it will get a new
entry in the config file according to the original description.
It also needs a volume mapping of course so therefore the combination -e/-v

Other properties can also be overridden like: 

```bash
   -e MINIDLNA_FRIENDLY_NAME="FooBarBaz DLNA" \
   -e MINIDLNA_NOTIFY_INTERVAL=10 \
   -v "$(pwd)/.data:/var/lib/minidlna" 
```
* `MINIDLNA_FRIENDLY_NAME` will broadcast a new friendly name of your choosing (default: IvoNet DLNA)
* `MINIDLNA_NOTIFY_INTERVAL` will set the notify interval in seconds (default: 30)
* `/var/lib/minidlna` is the volume where minidlna stores its data. You can chose to mount that to your disk or 
other volume to persist it between containers


Have fun.

# License

    Copyright 2020 (c) Ivo Woltring

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
