#include "verification_stdlib.h"
#include "verification_list.h"
#include "int_array_def.h"

struct bundle_payload {
    int values[2];
    int tag;
};

struct bundle_snode {
    struct bundle_payload payload;
    struct bundle_snode *next;
};

struct bundle_dnode {
    struct bundle_dnode *previous;
    struct bundle_dnode *next;
    struct bundle_payload payload;
};

struct recursive_bundle {
    int totals[2];
    struct bundle_snode *single;
    struct bundle_dnode *doubly;
};

int bump_single_recursive(struct bundle_snode *node, int delta)
{
    if (node == (void *)0) {
        return 0;
    }
    node->payload.values[0] = node->payload.values[0] + delta;
    return node->payload.values[0] +
           bump_single_recursive(node->next, delta);
}

int bump_double_recursive(struct bundle_dnode *node, int delta)
{
    if (node == (void *)0) {
        return 0;
    }
    node->payload.values[0] = node->payload.values[0] + delta;
    return node->payload.values[0] +
           bump_double_recursive(node->next, delta);
}

int composite_recursive_bundle(struct recursive_bundle *bundle,
                               int single_delta,
                               int double_delta)
/*@ With (single_head: Z) (single_tail: Z)
         (double_head: Z) (double_tail: Z)
         (totals: list Z)
         (single_first: list Z) (single_second: list Z)
         (double_first: list Z) (double_second: list Z)
         (single_first_tag: Z) (single_second_tag: Z)
         (double_first_tag: Z) (double_second_tag: Z)
         (expected: Z)
    Require
      single_head != 0 && single_tail != 0 &&
      double_head != 0 && double_tail != 0 &&
      Zlength(totals) == 2 &&
      Zlength(single_first) == 2 &&
      Zlength(single_second) == 2 &&
      Zlength(double_first) == 2 &&
      Zlength(double_second) == 2 &&
      expected ==
        Znth(0, totals, 0) + Znth(1, totals, 0) +
        Znth(0, single_first, 0) + Znth(0, single_second, 0) +
        Znth(0, double_first, 0) + Znth(0, double_second, 0) +
        2 * single_delta + 2 * double_delta &&
      IntArray::full(&(bundle->totals[0]), 2, totals) *
      store(&(bundle->single), single_head) *
      store(&(bundle->doubly), double_head) *
      IntArray::full(
        &(((struct bundle_snode *)single_head)->payload.values[0]),
        2, single_first) *
      store(&(((struct bundle_snode *)single_head)->payload.tag),
            single_first_tag) *
      store(&(((struct bundle_snode *)single_head)->next), single_tail) *
      IntArray::full(
        &(((struct bundle_snode *)single_tail)->payload.values[0]),
        2, single_second) *
      store(&(((struct bundle_snode *)single_tail)->payload.tag),
            single_second_tag) *
      store(&(((struct bundle_snode *)single_tail)->next), 0) *
      store(&(((struct bundle_dnode *)double_head)->previous), 0) *
      store(&(((struct bundle_dnode *)double_head)->next), double_tail) *
      IntArray::full(
        &(((struct bundle_dnode *)double_head)->payload.values[0]),
        2, double_first) *
      store(&(((struct bundle_dnode *)double_head)->payload.tag),
            double_first_tag) *
      store(&(((struct bundle_dnode *)double_tail)->previous), double_head) *
      store(&(((struct bundle_dnode *)double_tail)->next), 0) *
      IntArray::full(
        &(((struct bundle_dnode *)double_tail)->payload.values[0]),
        2, double_second) *
      store(&(((struct bundle_dnode *)double_tail)->payload.tag),
            double_second_tag)
    Ensure
      __return == expected &&
      IntArray::full(
        &(bundle->totals[0]), 2,
        cons(
          Znth(0, totals, 0) +
          Znth(0, single_first, 0) +
          Znth(0, single_second, 0) +
          2 * single_delta@pre,
          cons(
            Znth(1, totals, 0) +
            Znth(0, double_first, 0) +
            Znth(0, double_second, 0) +
            2 * double_delta@pre,
            nil))) *
      store(&(bundle->single), single_head) *
      store(&(bundle->doubly), double_head) *
      IntArray::full(
        &(((struct bundle_snode *)single_head)->payload.values[0]),
        2,
        cons(Znth(0, single_first, 0) + single_delta@pre,
             cons(Znth(1, single_first, 0), nil))) *
      store(&(((struct bundle_snode *)single_head)->payload.tag),
            single_first_tag) *
      store(&(((struct bundle_snode *)single_head)->next), single_tail) *
      IntArray::full(
        &(((struct bundle_snode *)single_tail)->payload.values[0]),
        2,
        cons(Znth(0, single_second, 0) + single_delta@pre,
             cons(Znth(1, single_second, 0), nil))) *
      store(&(((struct bundle_snode *)single_tail)->payload.tag),
            single_second_tag) *
      store(&(((struct bundle_snode *)single_tail)->next), 0) *
      store(&(((struct bundle_dnode *)double_head)->previous), 0) *
      store(&(((struct bundle_dnode *)double_head)->next), double_tail) *
      IntArray::full(
        &(((struct bundle_dnode *)double_head)->payload.values[0]),
        2,
        cons(Znth(0, double_first, 0) + double_delta@pre,
             cons(Znth(1, double_first, 0), nil))) *
      store(&(((struct bundle_dnode *)double_head)->payload.tag),
            double_first_tag) *
      store(&(((struct bundle_dnode *)double_tail)->previous), double_head) *
      store(&(((struct bundle_dnode *)double_tail)->next), 0) *
      IntArray::full(
        &(((struct bundle_dnode *)double_tail)->payload.values[0]),
        2,
        cons(Znth(0, double_second, 0) + double_delta@pre,
             cons(Znth(1, double_second, 0), nil))) *
      store(&(((struct bundle_dnode *)double_tail)->payload.tag),
            double_second_tag)
*/
{
    bundle->totals[0] =
        bundle->totals[0] +
        bump_single_recursive(bundle->single, single_delta);
    bundle->totals[1] =
        bundle->totals[1] +
        bump_double_recursive(bundle->doubly, double_delta);
    return bundle->totals[0] + bundle->totals[1];
}
