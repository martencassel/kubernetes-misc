#!/bin/bash

docker build -t ubuntu-18.04-systemd:latest .

docker container run -it --privileged true \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    ubuntu-18.04-systemd:latest