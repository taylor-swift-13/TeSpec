#include <stddef.h>

typedef struct {
    const unsigned char *left;
    const unsigned char *right;
    size_t left_len;
    size_t right_len;
    unsigned char *scratch;
    unsigned char *output;
    size_t capacity;
    size_t output_len;
} BinaryJob;

static unsigned int bit_from_right(
    const unsigned char *bits, size_t length, size_t offset)
{
    if (offset >= length) {
        return 0;
    }
    return (unsigned int)bits[length - offset - 1];
}

static size_t add_reversed(BinaryJob *job)
{
    size_t width =
        job->left_len > job->right_len ? job->left_len : job->right_len;
    size_t used = 0;
    unsigned int carry = 0;

    while (used < width) {
        unsigned int sum =
            bit_from_right(job->left, job->left_len, used) +
            bit_from_right(job->right, job->right_len, used) + carry;
        job->scratch[used] = (unsigned char)(sum & 1u);
        carry = sum >> 1;
        ++used;
    }
    return used;
}

static void copy_forward(BinaryJob *job, size_t used)
{
    size_t i;

    for (i = 0; i < used; ++i) {
        job->output[i] = job->scratch[used - i - 1];
    }
}

int add_binary_job(BinaryJob *job)
{
    size_t used = add_reversed(job);

    copy_forward(job, used);
    job->output_len = used;
    return (int)used;
}
