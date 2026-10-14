#include "verification_stdlib.h"
#include "sll_layout32_def.h"
struct list *append(struct list *x, struct list *y)
/*@ With (xs: list Z) (ys: list Z) Require sll32(x,xs) * sll32(y,ys) Ensure sll32(__return,app(app(xs,ys),cons(0,nil))) */
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
