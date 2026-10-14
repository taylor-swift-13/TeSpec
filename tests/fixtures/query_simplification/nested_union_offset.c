struct Item { int padding; int value; };
union Payload { struct Item node; int raw; };
struct Envelope { int code; union Payload payload; };

/* The provider exposes byte offsets; C uses nested fields. */
int sample(struct Envelope *p)
/*@ Require data_at((char*)p + 8, int, 7)
    Ensure __return == 8 && data_at((char*)p@pre + 8, int, 8) */
{
    p->payload.node.value += 1;
    return p->payload.node.value;
}
