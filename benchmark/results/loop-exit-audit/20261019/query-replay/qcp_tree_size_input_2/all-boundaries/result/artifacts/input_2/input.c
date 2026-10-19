#include "verification_stdlib.h"
struct tree { int key; int value; struct tree *left; struct tree *right; };
/*@ Extern Coq (tree :: *) */
/*@ Extern Coq (partial_tree :: *) */
/*@ Extern Coq (mapping :: *) */
/*@ Extern Coq Record result {
  pt : partial_tree;
  k : Z;
  v : Z;
  l_tree : tree;
} */
/*@ Extern Coq (Bst::store_map : Z -> mapping -> Assertion)
               (store_tree : Z -> tree -> Assertion)
               (store_ptb: Z -> Z -> partial_tree -> Assertion)
               (store_pt: Z -> Z -> partial_tree -> Assertion)
               (empty: tree)
               (empty_partial_tree: partial_tree)
               (combine_tree: partial_tree -> tree -> tree)
               (make_tree: tree -> Z -> Z -> tree -> tree)
               (tree_pre_merge : tree -> tree -> tree)
               (tree_delete: Z -> tree -> tree)
               (find_pre: tree -> Z -> Z -> tree -> result)
               (tree_delete': Z -> tree -> tree)
               (map_delete: Z -> mapping -> mapping) 
               (tree_insert: Z -> Z -> tree -> tree)
               (map_insert: Z -> Z -> mapping -> mapping)
               */ 

/*@ Import Coq Require Import SimpleC.EE.QCP_demos_human.bst_lib */
/*@ Import Coq Import get_right_most*/

/*@ include strategies "QCP_demos_human/bst.strategies"*/
/*@ include strategies "QCP_demos_human/teSpec_tree_size.strategies"*/
/*@ Extern Coq (tree_size : tree -> Z) */
/*@ Import Coq Require Import TreeMeasure */
int sample(struct tree *p)

/*@ __tespec_entry With (t : tree) Require
      (p == (4096)) && (t == (make_tree(make_tree(empty,1,10,empty),2,20,make_tree(empty,3,30,empty)))) && 0 <= tree_size(t) && tree_size(t) <= 100 && store_tree(p, t)
    Ensure __return == tree_size(t) && store_tree(p@pre, t) */
/*@ With (t : tree) Require 0 <= tree_size(t) && tree_size(t) <= 100 && store_tree(p, t)
    Ensure __return == tree_size(t) && store_tree(p@pre, t) */
{ if (p == 0) { return 0; } return 1 + sample(p->left) + sample(p->right); }
