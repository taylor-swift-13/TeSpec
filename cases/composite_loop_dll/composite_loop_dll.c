struct meter_payload {
    int readings[2];
    int delta;
};

struct meter_node {
    struct meter_node *previous;
    struct meter_node *following;
    struct meter_payload meter;
};

void apply_meter_delta(struct meter_node *node)
{
    node->meter.readings[0] =
        node->meter.readings[0] + node->meter.delta;
}

int composite_loop_dll(struct meter_node *head)
/*@ With (tail: Z)
         (h0: Z) (h1: Z) (hd: Z)
         (t0: Z) (t1: Z) (td: Z)
         (expected: Z)
    Require
      tail != 0 &&
      expected == h0 + hd + t0 + td &&
      store(&(head->previous), 0) *
      store(&(head->following), tail) *
      store(&(head->meter.readings[0]), h0) *
      store(&(head->meter.readings[1]), h1) *
      store(&(head->meter.delta), hd) *
      store(&(((struct meter_node *)tail)->previous), head) *
      store(&(((struct meter_node *)tail)->following), 0) *
      store(&(((struct meter_node *)tail)->meter.readings[0]), t0) *
      store(&(((struct meter_node *)tail)->meter.readings[1]), t1) *
      store(&(((struct meter_node *)tail)->meter.delta), td)
    Ensure
      __return == expected &&
      store(&(head->previous), 0) *
      store(&(head->following), tail) *
      store(&(head->meter.readings[0]), h0 + hd) *
      store(&(head->meter.readings[1]), h1) *
      store(&(head->meter.delta), hd) *
      store(&(((struct meter_node *)tail)->previous), head@pre) *
      store(&(((struct meter_node *)tail)->following), 0) *
      store(&(((struct meter_node *)tail)->meter.readings[0]), t0 + td) *
      store(&(((struct meter_node *)tail)->meter.readings[1]), t1) *
      store(&(((struct meter_node *)tail)->meter.delta), td)
*/
{
    struct meter_node *cursor = head;
    int total = 0;
    while (cursor != (void *)0) {
        apply_meter_delta(cursor);
        total = total + cursor->meter.readings[0];
        cursor = cursor->following;
    }
    return total;
}
