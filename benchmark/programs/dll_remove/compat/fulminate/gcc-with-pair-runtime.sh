#!/bin/sh
set -eu
here=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
programs=$(CDPATH= cd -- "$here/../../.." && pwd)
shared="$programs/Dbl_Linked_List__singleton/compat/cn-5.2/gcc-with-runtime.sh"
link=false
for arg in "$@"; do
    case "$arg" in
        -E|-S|-c) exec "$shared" "$@" ;;
        *.o|*.exec.c) link=true ;;
    esac
done
if "$link"; then
    exec "$shared" -I"${OPAM_SWITCH_PREFIX:?}/lib/cn/runtime/include" \
        -I"$programs/../../arxiv/fulminate-cn/src/examples/Dbl_Linked_List" \
        "$here/pair-runtime.c" "$@"
fi
exec "$shared" "$@"
