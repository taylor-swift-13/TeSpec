#!/usr/bin/env bash
set -euo pipefail

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
project_root=$(CDPATH= cd -- "$script_dir/.." && pwd)
docker_bin=${DOCKER_BIN:-docker}
image_tag=${1:-tespec:offline-0.3.0-amd64}
bundle_name=${2:-tespec-offline-0.3.0-20260729-amd64}
dist_root=${DIST_ROOT:-"$project_root/dist"}
bundle_dir="$dist_root/$bundle_name"
archive_name=tespec-image-linux-amd64.tar.gz

if [[ -e "$bundle_dir" ]]; then
  echo "bundle destination already exists: $bundle_dir" >&2
  exit 2
fi

image_id=$("$docker_bin" image inspect "$image_tag" --format '{{.Id}}')
image_os=$("$docker_bin" image inspect "$image_tag" --format '{{.Os}}')
image_arch=$("$docker_bin" image inspect "$image_tag" --format '{{.Architecture}}')
if [[ "$image_os/$image_arch" != "linux/amd64" ]]; then
  echo "offline bundle requires linux/amd64, got $image_os/$image_arch" >&2
  exit 2
fi

mkdir -p "$bundle_dir/examples" "$bundle_dir/skills"
cp "$script_dir/bundle/load-and-test.sh" "$bundle_dir/"
cp "$script_dir/bundle/tespec" "$bundle_dir/"
cp "$script_dir/bundle/README_OFFLINE.md" "$bundle_dir/"
cp "$script_dir/bundle/examples/callee_heap.c" "$bundle_dir/examples/"
cp "$script_dir/bundle/examples/binds.json" "$bundle_dir/examples/"
cp -R "$project_root/skills/qcp-spec-test" "$bundle_dir/skills/"
cp -R "$project_root/skills/tespec-e2e" "$bundle_dir/skills/"
cp -R "$project_root/skills/tespec-four-class" "$bundle_dir/skills/"
cp -R "$project_root/skills/tespec-artifacts" "$bundle_dir/skills/"

printf '%s\n' "$image_tag" >"$bundle_dir/IMAGE_TAG"
printf '%s\n' "$image_id" >"$bundle_dir/IMAGE_ID"
printf '%s\n' "$archive_name" >"$bundle_dir/IMAGE_ARCHIVE"
"$docker_bin" image inspect "$image_tag" >"$bundle_dir/image-manifest.json"

"$docker_bin" save "$image_tag" | gzip -n -6 >"$bundle_dir/$archive_name"

chmod 0755 "$bundle_dir/load-and-test.sh" "$bundle_dir/tespec"
(
  cd "$bundle_dir"
  find . -type f ! -name SHA256SUMS -print0 \
    | sort -z \
    | xargs -0 sha256sum >SHA256SUMS
)

printf '%s\n' \
  "Offline bundle created: $bundle_dir" \
  "Image: $image_tag" \
  "ID: $image_id" \
  "Platform: $image_os/$image_arch"
