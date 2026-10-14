#include "verification_stdlib.h"
#include "sll_def.h"
struct list *append(struct list *x, struct list *y)
/*@ With (xs: list Z) (ys: list Z) Require sll(x,xs) * sll(y,ys) Ensure sll(__return,app(xs,ys)) */
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
    t -> next = (void *)0;
    return x;
  }
}
