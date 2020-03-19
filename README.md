# MiniDLNA

[MiniDLNA](https://sourceforge.net/projects/minidlna/) is a simple media server software.

This image is based on Alpine Linux.

## Usage

Example:

```bash
docker run -d --name minidlna \
  --net=host \
  -p 8200:8200 \
  -p 1900:1900/udp \
  -v <PATH_TO_VIDEOS_DIR>:/videos \
  -v <PATH_TO_MUSIC_DIR>:/music \
  -v <PATH_TO_PICUTRES_DIR>:/pictures \
  ivonet/minidlna
```

Only video

```bash
docker run -d --name minidlna \
  --net=host \
  -p 8200:8200 \
  -p 1900:1900/udp \
  -v $(pwd)/data:/minidlna \
  -v <PATH_TO_VIDEOS_DIR>:/videos \
  ivonet/minidlna
```

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


docker run -it --name minidlna \
  --net=host \
  -p 8200:8200 \
  -p 1900:1900/udp \
  -v /Volumes/video:/videos \
  ivonet/minidlna
