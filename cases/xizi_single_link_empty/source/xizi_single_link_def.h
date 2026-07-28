typedef struct SingleLinklistNode
{
    struct SingleLinklistNode *node_next;
} SysSingleLinklistType;

/*@ Extern Coq (xizi_sll : Z -> list Z -> Assertion)
               (xizi_sllseg : Z -> Z -> list Z -> Assertion)
               (xizi_sll_to_target : Z -> Z -> list Z -> Assertion)
               (xizi_sll_not_target : Z -> Z -> list Z -> Assertion)
               (xizi_sll_head : Z -> list Z -> Assertion)
               (xizi_sll_node : Z -> Assertion)
               (xizi_sll_first_value : list Z -> Z)
               (xizi_sll_tail_value : list Z -> Z -> Z)
               (xizi_sll_next_value : list Z -> Z -> Z)
               (In : {A} -> A -> list A -> Prop)
               (not : Prop -> Prop)
 */
/*@ Import Coq From QCIPLib.xizi.xizi_single_link_common Require Import xizi_single_link_lib */
/*@ include strategies "xizi_single_link.strategies" */
