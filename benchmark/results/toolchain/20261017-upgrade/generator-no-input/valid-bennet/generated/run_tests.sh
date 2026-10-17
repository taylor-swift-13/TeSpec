#!/bin/bash

# Auto-generated bash script for CN test generation
RUNTIME_PREFIX="$OPAM_SWITCH_PREFIX/lib/cn/runtime"
[ -d "${RUNTIME_PREFIX}" ] || {
    printf "Could not find CN's runtime directory (looked at: '${RUNTIME_PREFIX}')"
    exit 2
}

TEST_DIR=/home/yangfp/teSpec/benchmark/results/toolchain/20261017-upgrade/generator-no-input/valid-bennet/generated
pushd $TEST_DIR > /dev/null

# Compile
if /usr/bin/gcc -c -o "./valid.cn.test.o" "./valid.cn.test.c" -g "-I${RUNTIME_PREFIX}/include/" ${CFLAGS} ${CPPFLAGS} ; then
    :
else
    printf "Failed to compile 'valid.cn.test.c' in ${TEST_DIR}."
    exit 2
fi

if /usr/bin/gcc -c -o "./valid.cn.exec.o" "./valid.cn.exec.c" -g "-I${RUNTIME_PREFIX}/include/" ${CFLAGS} ${CPPFLAGS} ; then
    :
else
    printf "Failed to compile 'valid.cn.exec.c' in ${TEST_DIR}."
    exit 2
fi

# Link
if /usr/bin/gcc -o "./tests.out" valid.cn.test.o valid.cn.exec.o "${RUNTIME_PREFIX}/libcn_test.a" "${RUNTIME_PREFIX}/libbennet.a" "${RUNTIME_PREFIX}/libcn_smt.a" "${RUNTIME_PREFIX}/libcn_replica.a" "${RUNTIME_PREFIX}/libcn_exec.a" -g "-I${RUNTIME_PREFIX}/include/" ${CFLAGS} ${CPPFLAGS} ; then
    :
else
    printf "Failed to link *.o files in ${TEST_DIR}."
    exit 2
fi

# Run
./tests.out --seed 0 --smt-skewing sized --discard-factor 10 --dynamic-local-iterations 1
test_exit_code=$? # Save tests exit code for later

popd > /dev/null
exit $test_exit_code
