#include "dll_shape_def.h"

/* Reduced first iteration from QCP dll_auto.c:iter. */
struct list *sample(struct list *l)
/*@ Require dlistrep_shape(l, 0)
    Ensure dlistrep_shape(__return, 0) */
{
    struct list *p = l;
    if (p) { p = p->next; }
    return l;
}
