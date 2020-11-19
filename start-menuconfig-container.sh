docker run -d \
  -it \
  --name devtest \
  -v "$(pwd)"/workdir:/app \
  openwrt-builder:12.03
