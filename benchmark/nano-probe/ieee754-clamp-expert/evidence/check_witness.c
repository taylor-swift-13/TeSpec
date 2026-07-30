#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include "../input/impl.c"

static uint64_t bits(double value)
{
    uint64_t result;
    memcpy(&result, &value, sizeof(result));
    return result;
}

static double from_bits(uint64_t value)
{
    double result;
    memcpy(&result, &value, sizeof(result));
    return result;
}

int main(void)
{
    Sample negative_zero = {
        .input = -0.0,
        .lower = -1.0,
        .upper = 1.0,
        .output = 17.0,
        .flags = FLAG_HIGH,
    };
    const unsigned int zero_return = clamp_batch(&negative_zero, 1);
    const int zero_ok = bits(negative_zero.output) == UINT64_C(0x8000000000000000)
        && negative_zero.flags == FLAG_NEGATIVE_ZERO && zero_return == 0;

    const uint64_t nan_bits = UINT64_C(0x7ff8000000000025);
    Sample nan = {
        .input = from_bits(nan_bits),
        .lower = -1.0,
        .upper = 1.0,
        .output = 17.0,
        .flags = FLAG_HIGH,
    };
    const unsigned int nan_return = clamp_batch(&nan, 1);
    const int nan_ok =
        bits(nan.output) == nan_bits && nan.flags == FLAG_NAN && nan_return == 0;

    printf(
        "{\"negative_zero_trace\":%s,\"nan_trace\":%s,\"passed\":%s}\n",
        zero_ok ? "true" : "false",
        nan_ok ? "true" : "false",
        zero_ok && nan_ok ? "true" : "false");
    return zero_ok && nan_ok ? 0 : 1;
}
