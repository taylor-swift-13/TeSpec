#!/bin/sh
set -eu
compat_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
link_input=false
for arg in "$@"; do
    case "$arg" in
        -c|-S|-E) exec /usr/bin/gcc -fno-builtin "$@" ;;
        *.o|*.exec.c) link_input=true ;;
    esac
done
if "$link_input"; then
    exec /usr/bin/gcc -fno-builtin \
        -I"${OPAM_SWITCH_PREFIX:?}/lib/cn/runtime/libcn/include" \
        "$compat_dir/allocator-runtime.c" "$@"
fi
exec /usr/bin/gcc -fno-builtin "$@"
