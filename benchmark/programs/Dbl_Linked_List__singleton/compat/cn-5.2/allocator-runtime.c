/* Execution support only: use the installed Fulminate allocation APIs. */
#include <stdlib.h>
#include <cn-executable/utils.h>
#include "Dbl_Linked_List/c_types.h"
#include "list_c_types.h"

struct node *malloc_node(void) {
    struct node *p = cn_malloc(sizeof *p);
    if (!p) abort();
    return p;
}
void free_node(struct node *p) { cn_free_sized(p, sizeof *p); }
struct int_list *mallocIntList(void) {
    struct int_list *p = cn_malloc(sizeof *p);
    if (!p) abort();
    return p;
}
void freeIntList(struct int_list *p) { cn_free_sized(p, sizeof *p); }
