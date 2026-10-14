#include "verification_stdlib.h"
void step(int *p, int n)
/*@ With v Require 0 <= n && n <= 3 && 0 <= v && v + n <= 100 && data_at(p, int, v)
    Ensure exists w, v <= w && data_at(p, int, w) */
{ if (n > 0) { *p = *p + 1; step(p, n - 1); } }
void sample(int *p)
/*@ With v Require 0 <= v && v <= 97 && data_at(p, int, v)
    Ensure data_at(p, int, v + 3) */
{ step(p, 3); }
int main(void)
/*@ Require emp Ensure __return == 0 */
{ int x = 3; sample(&x); return 0; }
