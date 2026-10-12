#include "verification_stdlib.h"
struct pair { int x; int y; };
void sample(struct pair *p)
/*@ With x y Require 0<=x && x<100 && (data_at(&(p->x),int,x) * data_at(&(p->y),int,y)) Ensure data_at(&(p->x),int,x+2) * data_at(&(p->y),int,y) */
{ p->x = p->x + 1; }
int main(void)
/*@ Require emp Ensure __return == 0 */
{ struct pair a = {3, 5}; sample(&a); return 0; }
