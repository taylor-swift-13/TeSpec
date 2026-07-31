#!/usr/bin/env bash
set -euo pipefail

bundle_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
docker_bin=${DOCKER_BIN:-docker}
image_tag=$(tr -d '\r\n' <"$bundle_dir/IMAGE_TAG")
expected_image_id=$(tr -d '\r\n' <"$bundle_dir/IMAGE_ID")
image_archive=$(tr -d '\r\n' <"$bundle_dir/IMAGE_ARCHIVE")

command -v sha256sum >/dev/null
command -v gzip >/dev/null
"$docker_bin" version >/dev/null

(
  cd "$bundle_dir"
  sha256sum -c SHA256SUMS
)

gzip -dc "$bundle_dir/$image_archive" | "$docker_bin" load

actual_image_id=$(
  "$docker_bin" image inspect "$image_tag" --format '{{.Id}}'
)
actual_os=$(
  "$docker_bin" image inspect "$image_tag" --format '{{.Os}}'
)
actual_arch=$(
  "$docker_bin" image inspect "$image_tag" --format '{{.Architecture}}'
)

test "$actual_image_id" = "$expected_image_id"
test "$actual_os" = linux
test "$actual_arch" = amd64

"$docker_bin" run --rm --network none "$image_tag" self-test

test_root=$(mktemp -d /tmp/tespec-offline-mounted-test.XXXXXX)
trap 'rm -rf "$test_root"' EXIT
cp "$bundle_dir/examples/callee_heap.c" "$test_root/"
cp "$bundle_dir/examples/binds.json" "$test_root/"

(
  cd "$test_root"
  "$bundle_dir/tespec" analyze callee_heap.c \
    --function callee_heap \
    --write-binds generated-binds.json \
    --compact >analyze.json
  "$bundle_dir/tespec" run callee_heap.c \
    --function callee_heap \
    --binds binds.json \
    -I QCP_examples/QCP_demos_LLM \
    --output-dir output \
    --compact >run.json
  grep -q '"PASS": 2' output/report.json
  "$bundle_dir/tespec" skill tespec-e2e >tespec-e2e.SKILL.md
  grep -q 'Generate exactly 30 tests per spec' tespec-e2e.SKILL.md
  "$bundle_dir/tespec" skill tespec-artifacts \
    >tespec-artifacts.SKILL.md
  grep -q 'artifact-manifest.json' tespec-artifacts.SKILL.md
)

printf '%s\n' \
  "TeSpec offline bundle test passed." \
  "Image: $image_tag" \
  "ID: $actual_image_id" \
  "Platform: $actual_os/$actual_arch" \
  "All container runs used --network none."
