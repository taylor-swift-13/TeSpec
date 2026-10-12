#include "verification_stdlib.h"
void sample(int *p, int *q)
/*@ With v Require p == q && 0 <= v && v < 100 && data_at(p, int, v)
    Ensure data_at(p, int, v + 3) */
{ *p = *p + 1; *q = *q + 2; }
int main(void)
/*@ Require emp Ensure __return == 0 */
{ int x = 3; sample(&x, &x); return 0; }
