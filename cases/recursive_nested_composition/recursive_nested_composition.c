#include "verification_stdlib.h"
#include "verification_list.h"
#include "int_array_def.h"

struct nested_inner {
    int values[2];
    int tag;
    struct nested_inner *previous;
    struct nested_inner *next;
};

struct nested_outer {
    struct nested_inner *children;
    struct nested_outer *next;
};

/* The address lists make every cell read by the concrete test explicit.
   The predicate definitions themselves remain recursive and independent of
   any particular list length or heap address. */
/*@ Let nested_dll(
        p : Z,
        nodes : list Z,
        previous : Z,
        rows : list (list Z)) =
      p == 0 && nodes == nil && rows == nil && emp ||
      exists rest_nodes row rest_rows first second tag,
        p != 0 &&
        nodes == cons(p, rest_nodes) &&
        rows == cons(row, rest_rows) &&
        row == cons(first, cons(second, cons(tag, nil))) &&
        IntArray::full(field_addr(p, nested_inner, values), 2,
                       cons(first, cons(second, nil))) *
        data_at(field_addr(p, nested_inner, tag), int, tag) *
        data_at(field_addr(p, nested_inner, previous),
                struct nested_inner *, previous) *
        data_at(field_addr(p, nested_inner, next),
                struct nested_inner *, Znth(0, rest_nodes, 0)) *
        nested_dll(Znth(0, rest_nodes, 0),
                   rest_nodes, p, rest_rows)
 */

/*@ Let nested_outer_chain(
        p : Z,
        nodes : list Z,
        child_nodes : list (list Z),
        groups : list (list (list Z))) =
      p == 0 && nodes == nil && child_nodes == nil &&
        groups == nil && emp ||
      exists rest_nodes inner_nodes rest_child_nodes
             rows rest_groups,
        p != 0 &&
        nodes == cons(p, rest_nodes) &&
        child_nodes == cons(inner_nodes, rest_child_nodes) &&
        groups == cons(rows, rest_groups) &&
        data_at(field_addr(p, nested_outer, children),
                struct nested_inner *, Znth(0, inner_nodes, 0)) *
        data_at(field_addr(p, nested_outer, next),
                struct nested_outer *, Znth(0, rest_nodes, 0)) *
        nested_dll(Znth(0, inner_nodes, 0),
                   inner_nodes, 0, rows) *
        nested_outer_chain(Znth(0, rest_nodes, 0),
                           rest_nodes, rest_child_nodes, rest_groups)
 */

int bump_nested_dll(struct nested_inner *node, int delta)
{
    if (node == (void *)0) {
        return 0;
    }
    node->values[0] = node->values[0] + delta;
    return node->values[0] + bump_nested_dll(node->next, delta);
}

int bump_nested_outer(struct nested_outer *node, int delta)
{
    if (node == (void *)0) {
        return 0;
    }
    return bump_nested_dll(node->children, delta) +
           bump_nested_outer(node->next, delta);
}

int recursive_nested_composition(struct nested_outer *root, int delta)
/*@ With (outer_nodes: list Z)
         (inner_nodes: list (list Z))
         (before: list (list (list Z)))
         (after: list (list (list Z)))
         (expected: Z)
    Require
      root == Znth(0, outer_nodes, 0) &&
      nested_outer_chain(root, outer_nodes, inner_nodes, before)
    Ensure
      __return == expected &&
      nested_outer_chain(root@pre, outer_nodes, inner_nodes, after)
 */
{
    return bump_nested_outer(root, delta);
}
