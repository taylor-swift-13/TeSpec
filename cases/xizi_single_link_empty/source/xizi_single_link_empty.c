#include "verification_stdlib.h"
#include "verification_list.h"
#include "xizi_single_link_def.h"

int xizi_single_link_empty(SysSingleLinklistType *linklist)
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
