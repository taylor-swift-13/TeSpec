typedef struct Payload {
    int readings[2];
    int delta;
} Payload;

typedef struct DNode {
    struct DNode *previous;
    struct DNode *following;
    Payload payload;
} DNode;

static int apply_meter_delta(Payload *payload)
{
    payload->readings[0] += payload->delta;
    return payload->readings[0];
}

int update_meters(DNode *head)
{
    DNode *cursor = head;
    int total = 0;

    if (cursor != (DNode *)0) {
        total += apply_meter_delta(&cursor->payload);
        cursor = cursor->following;
    }
    while (cursor != (DNode *)0) {
        total += cursor->payload.readings[0];
        cursor = cursor->following;
    }
    return total;
}
