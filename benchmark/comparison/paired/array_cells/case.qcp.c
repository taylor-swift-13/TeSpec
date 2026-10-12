#include "verification_stdlib.h"
int sample(int *p)
/*@ With x y Require 0 <= x && x <= 100 && 0 <= y && y <= 100 &&
    (data_at(p + 0, int, x) * data_at(p + 1, int, y))
    Ensure __return == x + y && (data_at(p + 0, int, x) * data_at(p + 1, int, x + y)) */
{ p[1] = p[0] + p[1]; return p[1]; }
int main(void)
/*@ Require emp Ensure __return == 0 */
{ int a[2] = {3, 5}; int r = sample(a); return 0; }
