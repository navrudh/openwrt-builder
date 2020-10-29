#!/bin/bash

IMAGE=openwrt-builder:19.07.04-mt7621-r6220

echo "Building Image: $IMAGE"

docker build -t "$IMAGE" --build-arg "BUILDER=https://downloads.openwrt.org/releases/19.07.4/targets/ramips/mt7621/openwrt-imagebuilder-19.07.4-ramips-mt7621.Linux-x86_64.tar.xz" -f dockerfiles/openwrt-r6220-builder.Dockerfile .

THROWAWAY_CONTAINER=discard_garbage

docker run --name $THROWAWAY_CONTAINER $IMAGE /bin/true
docker cp $THROWAWAY_CONTAINER:"$HOME/builder/openwrt-imagebuilder-19.07.4-ramips-mt7621.Linux-x86_64/bin/targets" "$(pwd)/targets"
docker rm $THROWAWAY_CONTAINER

