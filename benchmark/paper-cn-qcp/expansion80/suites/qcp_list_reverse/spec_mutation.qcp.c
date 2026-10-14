#include "verification_stdlib.h"
#include "sll_def.h"
struct list *reverse(struct list *p)
/*@ With (xs: list Z) Require sll(p,xs) Ensure sll(__return,app(rev(xs),cons(0,nil))) */
{
   struct list * w = (void *) 0, * v = p;
   
   while (v) {
      
      struct list * t = v -> next;
      v -> next = w;
      w = v;
      v = t;
   }
   return w;
}
