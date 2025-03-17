#!/bin/bash

set -euxo pipefail

sha=$(echo "$1" | sha256sum | awk '{ print $1 }')
skopeo copy --preserve-digests docker://$1 dir:/opt/image-cache/$sha
echo "$1,$sha" >> /opt/image-cache/mapping.txt
