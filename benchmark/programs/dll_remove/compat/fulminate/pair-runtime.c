/* Link implementations for the original external allocation contracts. */
#include <stdlib.h>
#include <cn-executable/utils.h>
#include "node_and_int.h"

struct node_and_int *malloc_node_and_int(void) {
    struct node_and_int *pair = cn_malloc(sizeof *pair);
    if (pair == NULL) abort();
    return pair;
}

void free_node_and_int(struct node_and_int *pair) {
    cn_free_sized(pair, sizeof *pair);
}
