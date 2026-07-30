typedef unsigned char u8;
typedef unsigned int u32;

typedef struct {
    u8 *pkv;
    u32 len;
    u8 chksum;
} ChecksumState;

void update_checksum(ChecksumState *state)
{
    u32 i;

    state->chksum = 0;
    for (i = 0; i < state->len; ++i) {
        state->chksum = (u8)(state->chksum + state->pkv[i]);
    }
    state->chksum = (u8)(state->chksum & 15u);
}
