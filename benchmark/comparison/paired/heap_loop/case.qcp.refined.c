#include "verification_stdlib.h"
void sample(int *p)
/*@ With v p0 Require p == p0 && 0<=v && v<98 && data_at(p,int,v) Ensure data_at(p,int,v+3) */
{ int i = 0; /*@ Inv p == p0 && 0<=i && i<=3 && data_at(p,int,v+i) */ while (i < 3) { *p = *p + 1; i = i + 1; } }
int main(void)
/*@ Require emp Ensure __return == 0 */
{ int a = 3; sample(&a); return 0; }
