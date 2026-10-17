#!/bin/sh
set -eu
compat_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
for arg in "$@"; do
    case "$arg" in
        *.exec.c)
            exec /usr/bin/gcc -fno-builtin \
                -I"${OPAM_SWITCH_PREFIX:?}/lib/cn/runtime/libcn/include" \
                "$compat_dir/allocator-runtime.c" "$@"
            ;;
    esac
done
exec /usr/bin/gcc -fno-builtin "$@"
