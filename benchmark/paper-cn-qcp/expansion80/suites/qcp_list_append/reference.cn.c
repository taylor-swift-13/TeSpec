struct list { int data; struct list *next; };
/*@
datatype Items { Nil {}, Cons { integer Head, datatype Items Tail } }
predicate [rec] (datatype Items) Nodes(pointer p) {
 if (is_null(p)) { return Nil{}; }
 else { take h = RW<struct list>(p); take t = Nodes(h.next); return Cons{Head:h.data,Tail:t}; }
}
function [rec] (integer) Length(datatype Items xs) {
 match xs { Nil{} => {0} Cons{Head:_,Tail:t} => {1+Length(t)} }
}
function [rec] (datatype Items) Append(datatype Items xs, datatype Items ys) {
 match xs { Nil{} => {ys} Cons{Head:h,Tail:t} => {Cons{Head:h,Tail:Append(t,ys)}} }
}
function [rec] (datatype Items) Reverse(datatype Items xs) {
 match xs { Nil{} => {Nil{}} Cons{Head:h,Tail:t} => {Append(Reverse(t),Cons{Head:h,Tail:Nil{}})} }
}
@*/
struct list *append(struct list *x, struct list *y)
/*@ requires take xs = Nodes(x); take ys = Nodes(y); ensures take zs = Nodes(return); zs == Append(xs,ys); @*/
{
  struct list *t, *u;
  if (x == (void *)0) {
    return y;
  } else {
    
    t = x;
    u = t -> next;
    
    while (u != (void *)0) {
      
      t = u;
      u = t -> next;
    }
    t -> next = y;
    return x;
  }
}
