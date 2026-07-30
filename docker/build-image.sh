#!/usr/bin/env bash
set -euo pipefail

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
project_root=$(CDPATH= cd -- "$script_dir/.." && pwd)
docker_bin=${DOCKER_BIN:-docker}
base_image=${QCP_BASE_IMAGE:-qcp:offline-20260729-amd64}
image_tag=${TESPEC_IMAGE_TAG:-tespec:offline-0.3.0-amd64}
build_date=${BUILD_DATE:-$(date -u +%Y-%m-%dT%H:%M:%SZ)}

"$docker_bin" image inspect "$base_image" >/dev/null

exec "$docker_bin" build \
  --file "$project_root/docker/Dockerfile" \
  --build-arg "QCP_BASE_IMAGE=$base_image" \
  --build-arg "TESPEC_VERSION=0.3.0" \
  --build-arg "BUILD_DATE=$build_date" \
  --tag "$image_tag" \
  "$project_root"
