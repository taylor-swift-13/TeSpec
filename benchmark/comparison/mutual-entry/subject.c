#include "verification_stdlib.h"
void second(int *p, int n);
void first(int *p, int n)
/*@ original With v
    Require 0 <= n && n <= 4 && 0 <= v && v + 2 * n <= 100 && data_at(p, int, v)
    Ensure data_at(p, int, v + n + n / 2) */
{ if (n > 0) { *p = *p + 1; second(p, n - 1); } }
void second(int *p, int n)
/*@ With v
    Require 0 <= n && n <= 4 && 0 <= v && v + 2 * n <= 100 && data_at(p, int, v)
    Ensure data_at(p, int, v + n + (n + 1) / 2) */
{ if (n > 0) { *p = *p + 2; first(p, n - 1); } }
