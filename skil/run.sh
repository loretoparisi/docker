#!/bin/bash
#
# SKIL CE Docker scripts
# @2017 Loreto Parisi (loretoparisi at gmail dot com)
#
docker run --rm -it -p 9008:9008 -p 8080:8080 -v /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro skil bash -c "/usr/local/bin/cmd.sh"