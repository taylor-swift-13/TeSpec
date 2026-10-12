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
int length(struct list *p)
/*@ requires take xs = Nodes(p); Length(xs) <= 2147483647; ensures take ys = Nodes(p); ys == xs; return == Length(xs); @*/
{
   int n = 0;
   
   while (p) {
      
      n++;
      p = p -> next;
   }
   return n;
}
