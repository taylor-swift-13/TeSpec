#!/usr/bin/env bash
set -euo pipefail

probe_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
probe_tmp=$(mktemp -d)
trap 'rm -rf -- "$probe_tmp"' EXIT

if [[ -f "$probe_root/impl.c" && -f "$probe_root/spec.qcp" ]]; then
    impl_dir=$probe_root
    spec_path=$probe_root/spec.qcp
else
    impl_dir=$probe_root/input
    spec_path=$probe_root/input/spec.qcp
fi

cat >"$probe_tmp/probe.c" <<'EOF'
#include <inttypes.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include "impl.c"

static uint64_t bits(double value)
{
    uint64_t result;
    memcpy(&result, &value, sizeof(result));
    return result;
}

static void run_case(const char *name, double input)
{
    Sample sample = {
        .input = input,
        .lower = -1.0,
        .upper = 1.0,
        .output = 42.0,
        .flags = 0xffffffffu,
    };
    unsigned int returned = clamp_batch(&sample, 1);
    printf("%s: return=%u output_is_nan=%d output_bits=0x%016" PRIx64
           " flags=%u\n",
           name, returned, isnan(sample.output) ? 1 : 0,
           bits(sample.output), sample.flags);
}

int main(void)
{
    run_case("quiet_nan_payload", nan("0x1234"));
    run_case("negative_zero", -0.0);
    run_case("positive_zero", 0.0);
    return 0;
}
EOF

cc -std=c11 -Wall -Wextra -Werror -I"$impl_dir" \
   "$probe_tmp/probe.c" -lm -o "$probe_tmp/probe"

echo "== concrete implementation observations =="
"$probe_tmp/probe"

echo "== specification facts (no class label) =="
grep -nE 'BatchDomain permits|observable|NumericEq' \
  "$probe_root/dependencies/SEMANTICS.md"
grep -n 'AllNonNaN(outputs)\|exists outputs flags_after' \
  "$spec_path"
grep -nE 'Definition NumericEq|x = FNegZero|x = FPosZero' \
  "$probe_root/dependencies/definitions.v"

echo "Review note: flags_after is existential and appears only in the heap"
echo "description; check whether any separate predicate constrains its values."
echo "The probe reports facts only. Decide Sound and Complete independently."
