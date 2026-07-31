typedef long long demo_i64;
typedef unsigned int demo_u32;

typedef struct DemoState {
    demo_i64 reading;
    demo_u32 enabled;
    demo_u32 result;
} DemoState;

void update_demo(void *raw)
{
    DemoState *state = (DemoState *)raw;

    if (state->reading >= 10) {
        state->result = 1u;
    }
    if (state->enabled == 1u) {
        state->result = 2u;
    }
}
