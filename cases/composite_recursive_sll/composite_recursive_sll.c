struct sample_pair {
    int lane[2];
    int bias;
};

struct sample_link {
    struct sample_pair payload;
    struct sample_link *next;
};

int recursive_payload_sum(struct sample_link *node)
{
    if (node == (void *)0) {
        return 0;
    }
    return node->payload.lane[0] +
           node->payload.lane[1] +
           node->payload.bias +
           recursive_payload_sum(node->next);
}

int composite_recursive_sll(struct sample_link *head)
/*@ With (second: Z)
         (a0: Z) (a1: Z) (ab: Z)
         (b0: Z) (b1: Z) (bb: Z)
         (expected: Z)
    Require
      second != 0 &&
      expected == a0 + a1 + ab + b0 + b1 + bb &&
      store(&(head->payload.lane[0]), a0) *
      store(&(head->payload.lane[1]), a1) *
      store(&(head->payload.bias), ab) *
      store(&(head->next), second) *
      store(&(((struct sample_link *)second)->payload.lane[0]), b0) *
      store(&(((struct sample_link *)second)->payload.lane[1]), b1) *
      store(&(((struct sample_link *)second)->payload.bias), bb) *
      store(&(((struct sample_link *)second)->next), 0)
    Ensure
      __return == expected &&
      store(&(head->payload.lane[0]), a0) *
      store(&(head->payload.lane[1]), a1) *
      store(&(head->payload.bias), ab) *
      store(&(head->next), second) *
      store(&(((struct sample_link *)second)->payload.lane[0]), b0) *
      store(&(((struct sample_link *)second)->payload.lane[1]), b1) *
      store(&(((struct sample_link *)second)->payload.bias), bb) *
      store(&(((struct sample_link *)second)->next), 0)
*/
{
    return recursive_payload_sum(head);
}
