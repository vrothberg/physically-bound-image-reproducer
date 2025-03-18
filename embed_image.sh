#!/bin/bash

set -euxo pipefail

image=$1
additional_copy_args=${2:-""}

mkdir -p /opt/image-cache
sha=$(echo "$image" | sha256sum | awk '{ print $1 }')
skopeo copy $additional_copy_args --preserve-digests docker://$image dir:/opt/image-cache/$sha
echo "$image,$sha" >> /opt/image-cache/mapping.txt
