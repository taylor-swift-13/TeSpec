struct list { int data; struct list *next; };
/*@
datatype Items { Nil {}, Cons { integer Head, datatype Items Tail } }
predicate [rec] (datatype Items) Nodes(pointer p) {
  if (is_null(p)) { return Nil{}; }
  else {
    take h = RW<struct list>(p);
    take t = Nodes(h.next);
    return Cons { Head: h.data, Tail: t };
  }
}
function [rec] (integer) Length(datatype Items xs) {
  match xs {
    Nil {} => { 0 }
    Cons { Head: _, Tail: t } => { 1 + Length(t) }
  }
}
@*/
int sample(struct list *p)
/*@ requires take xs = Nodes(p); Length(xs) <= 100;
    ensures take ys = Nodes(p); ys == xs; return == Length(xs) + 1; @*/
{ /*@ unfold Length(xs); @*/ if (p == 0) { return 0; } return 1 + sample(p->next); }
int main(void)
/*@ ensures return == 0; @*/
{ struct list b = {2, 0}; struct list a = {1, &b}; sample(&a); return 0; }
