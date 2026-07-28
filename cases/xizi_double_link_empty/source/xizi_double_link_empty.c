#include "xizi_double_link_def.h"




int xizi_double_link_empty(const DoubleLinklistType *linklist)
/*@ With (nodes: list Z)
    Require linklist != 0 &&
            xizi_dll(linklist, nodes)
    Ensure ((__return == 1 && nodes == nil) ||
            (__return == 0 && nodes != nil)) &&
           xizi_dll(linklist@pre, nodes)
*/
{
    
    return linklist->node_next == linklist;
}
