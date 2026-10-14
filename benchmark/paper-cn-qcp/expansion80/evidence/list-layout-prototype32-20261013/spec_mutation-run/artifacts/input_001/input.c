#include "verification_stdlib.h"
#include "sll_layout32_def.h"
struct list *reverse(struct list *p)

/*@ __tespec_entry With (xs: list Z) Require
      (p == (4096)) && (xs == (cons(-2147483648, nil))) && sll32(p,xs) Ensure sll32(__return,app(rev(xs),cons(0,nil))) */
/*@ With (xs: list Z) Require sll32(p,xs) Ensure sll32(__return,app(rev(xs),cons(0,nil))) */
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
