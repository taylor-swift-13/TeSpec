struct tree { int key; int value; struct tree *left; struct tree *right; };
/*@
datatype Tree { TreeLeaf {}, TreeNode { integer Key, integer Value, datatype Tree Left, datatype Tree Right } }
predicate [rec] (datatype Tree) Nodes(pointer p) {
  if (is_null(p)) { return TreeLeaf{}; }
  else {
    take h = RW<struct tree>(p);
    take l = Nodes(h.left);
    take r = Nodes(h.right);
    assert(0 <= Size(l));
    assert(0 <= Size(r));
    return TreeNode { Key: h.key, Value: h.value, Left: l, Right: r };
  }
}
function [rec] (integer) Size(datatype Tree t) {
  match t {
    TreeLeaf {} => { 0 }
    TreeNode { Key: _, Value: _, Left: l, Right: r } => { 1 + Size(l) + Size(r) }
  }
}
@*/
int sample(struct tree *p)
/*@ requires take t = Nodes(p); 0 <= Size(t); Size(t) <= 100;
    ensures take u = Nodes(p); u == t; return == Size(t) + 1; @*/
{ /*@ unfold Size(t); @*/ if (p == 0) { return 0; } return 1 + sample(p->left) + sample(p->right); }
