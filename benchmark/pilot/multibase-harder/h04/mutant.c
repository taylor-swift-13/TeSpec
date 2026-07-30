#include <math.h>
#include <stddef.h>

enum {
    FLAG_NAN = 1u,
    FLAG_NEGATIVE_ZERO = 2u,
    FLAG_LOW = 4u,
    FLAG_HIGH = 8u
};

typedef struct {
    double input;
    double lower;
    double upper;
    double output;
    unsigned int flags;
} Sample;

static double clamp_one(
    double input, double lower, double upper, unsigned int *flags)
{
    *flags = 0;
    if (isnan(input)) {
        *flags = FLAG_NAN;
        return input;
    }
    if (input == 0.0) {
        input = 0.0;
    }
    if (input < lower) {
        *flags |= FLAG_LOW;
        return lower;
    }
    if (input > upper) {
        *flags |= FLAG_HIGH;
        return upper;
    }
    return input;
}

unsigned int clamp_batch(Sample *samples, size_t count)
{
    size_t i;
    unsigned int clipped = 0;

    for (i = 0; i < count; ++i) {
        samples[i].output =
            clamp_one(samples[i].input, samples[i].lower, samples[i].upper,
                      &samples[i].flags);
        if ((samples[i].flags & (FLAG_LOW | FLAG_HIGH)) != 0) {
            ++clipped;
        }
    }
    return clipped;
}
