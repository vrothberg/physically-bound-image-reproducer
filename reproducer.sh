#!/bin/bash

set -euxo pipefail

podman rm -af -t0
podman run --detach --name=reproducer fedora:latest sleep infinity

mkdir -p /var/build
cp /etc/containers/Containerfile /var/build
cp /usr/bin/reproducer.sh /var/build
sed -i -e 's|fedora:latest|alpine:latest|g' /var/build/Containerfile
podman build -t localhost/new:image -f /var/build/Containerfile

bootc switch --transport=containers-storage localhost/new:image
bootc upgrade
