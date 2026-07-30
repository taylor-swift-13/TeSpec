#include <stddef.h>

void target(int *state, int data_length, int area_length, int force)
{
    int writeidx = state[1];

    if (writeidx + data_length <= area_length) {
        writeidx = (writeidx + data_length) % area_length;
    } else {
        writeidx = data_length - (area_length - writeidx);
    }

    state[1] = writeidx;

    if (force != 0) {
        state[0] = writeidx;
    }
}
