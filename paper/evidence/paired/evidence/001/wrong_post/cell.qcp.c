#include "verification_stdlib.h"

void sample(int *p, int *q)
/*@ With x y Require data_at(p,int,x) * data_at(q,int,y) Ensure data_at(p,int,y + 1) * data_at(q,int,x) */
{ int t = *p; *p = *q; *q = t; }
int main(void)
/*@ Require emp Ensure __return == 0 */
{ int a = 3; int b = 5; sample(&a, &b); return 0; }
