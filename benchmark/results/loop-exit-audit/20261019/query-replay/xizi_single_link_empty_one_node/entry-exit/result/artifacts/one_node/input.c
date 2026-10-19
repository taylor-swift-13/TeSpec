#include "verification_stdlib.h"
#include "verification_list.h"
#include "xizi_single_link_def.h"

int xizi_single_link_empty(SysSingleLinklistType *linklist)

/*@ __tespec_entry With l
    Require
      (linklist == (8192)) && (l == (cons(4096, nil))) &&
      xizi_sll_head(linklist, l)
    Ensure
      ((l == nil && __return == 1) ||
       (l != nil && __return == 0)) &&
      xizi_sll_head(linklist, l)
*/
/*@ With l
    Require
      xizi_sll_head(linklist, l)
    Ensure
      ((l == nil && __return == 1) ||
       (l != nil && __return == 0)) &&
      xizi_sll_head(linklist, l)
*/
{
    return linklist->node_next == (void *)0;
}
