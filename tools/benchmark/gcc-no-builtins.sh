#!/bin/sh
# Ensure calls to benchmark functions such as abs reach their CN instrumentation.
exec /usr/bin/gcc -fno-builtin "$@"
