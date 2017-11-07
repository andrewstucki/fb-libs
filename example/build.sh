#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

rm -rf "$DIR/build"
docker run -v /var/run/docker.sock:/var/run/docker.sock -v "$DIR":/build proxygen /bin/bash -c "mkdir -p /build/build && \
  cd /build/build && \
  cmake .. && \
  make && \
  strip ./bin/StaticServer && \
  ldd ./bin/StaticServer && \
  dockerize -t static-test /build/build/bin/StaticServer"
