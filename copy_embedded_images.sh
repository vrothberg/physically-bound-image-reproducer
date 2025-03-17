#!/bin/bash

set -euxo pipefail

while IFS="," read -r image sha
do
	skopeo copy --preserve-digests dir:/opt/image-cache/$sha containers-storage:$image
done < /opt/image-cache/mapping.txt
