#include "verification_stdlib.h"
void sample(int **pp)
/*@ With p v Require 0 <= v && v < 100 && (data_at(pp, int *, p) * data_at(p, int, v))
    Ensure data_at(pp, int *, p) * data_at(p, int, v + 2) */
{ int *p = *pp; *p = *p + 1; }
int main(void)
/*@ Require emp Ensure __return == 0 */
{ int x = 3; int *p = &x; sample(&p); return 0; }
