#!/usr/bin/env bash

handle=ivonet
image=minidlna
tag="$(<VERSION)"

if [ -z tag ]; then
  echo "No version found in the VERSION file"
  echo "Assuming 'latest'"
  tag="latest"
else
  echo "tag $tag"
fi

podman build \
  --platform linux/amd64,linux/arm64 \
  --manifest docker.io/$handle/$image:$tag \
  .

if [ $? -ne 0 ]; then
  exit 1
fi

podman manifest inspect $handle/$image:$tag
if [ $? -ne 0 ]; then
  exit 1
fi

if [ "${1:-}" == 'deploy' ]; then
  podman manifest push --all \
    docker.io/$handle/$image:$tag \
    docker://docker.io/$handle/$image:$tag

  podman manifest push --all \
    docker.io/$handle/$image:$tag \
    docker://docker.io/$handle/$image:latest
fi
