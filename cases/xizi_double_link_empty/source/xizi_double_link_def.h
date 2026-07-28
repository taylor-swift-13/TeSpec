#ifndef XIZI_DOUBLE_LINK_DEF_H
#define XIZI_DOUBLE_LINK_DEF_H

#ifndef NONE
#define NONE ((void *)0)
#endif

typedef struct SysDoubleLinklistNode
{
    struct SysDoubleLinklistNode *node_next;
    struct SysDoubleLinklistNode *node_prev;
} DoubleLinklistType;

/*@ Extern Coq (xizi_dll : Z -> list Z -> Assertion)
               (xizi_dllseg : Z -> Z -> Z -> Z -> list Z -> Assertion)
 */
/*@ Import Coq From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_lib */
/*@ include strategies "xizi_double_link.strategies" */

#endif
