struct payload {
    long values[2];
    long tag;
};

struct snode {
    struct payload payload;
    struct snode *next;
};

struct dnode {
    struct dnode *previous;
    struct dnode *next;
    struct payload payload;
};

struct bundle {
    long totals[2];
    struct snode *single;
    struct dnode *doubly;
};

long bump_single(struct snode *node, long delta)
{
    if (node == 0) return 0;
    node->payload.values[0] += delta;
    return node->payload.values[0] + bump_single(node->next, delta);
}

long bump_double(struct dnode *node, long delta)
{
    if (node == 0) return 0;
    node->payload.values[1] += delta;
    return node->payload.values[1] + bump_double(node->next, delta);
}

long update_bundle(struct bundle *b, long sd, long dd)
{
    b->totals[0] += bump_single(b->single, sd);
    b->totals[1] += bump_double(b->doubly, dd);
    return b->totals[0] + b->totals[1];
}
