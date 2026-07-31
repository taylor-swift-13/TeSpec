typedef long long demo_i64;
typedef unsigned int demo_u32;

typedef struct DemoState {
    demo_i64 reading;
    demo_u32 enabled;
    demo_u32 result;
} DemoState;

void update_demo(void *raw)
/*@ With (reading: Z) (enabled: Z) (old_result: Z)
    Require
      raw != 0 &&
      store(&(((DemoState *)raw)->reading), reading) *
      store(&(((DemoState *)raw)->enabled), enabled) *
      store(&(((DemoState *)raw)->result), old_result)
    Ensure
      exists (new_result: Z),
        store(&(((DemoState *)raw@pre)->reading), reading) *
        store(&(((DemoState *)raw@pre)->enabled), enabled) *
        store(&(((DemoState *)raw@pre)->result), new_result) &&
        (enabled == 1 => new_result == 2) &&
        (enabled != 1 && reading >= 10 => new_result == 1) &&
        (enabled != 1 && !(reading >= 10) => new_result == old_result)
*/
{
    DemoState *state = (DemoState *)raw;

    if (state->reading >= 10) {
        state->result = 1u;
    }
    if (state->enabled == 1u) {
        state->result = 2u;
    }
}
