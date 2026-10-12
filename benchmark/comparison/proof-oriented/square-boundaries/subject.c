#include "verification_stdlib.h"
/*@ Import Coq Require Import SquareRelation */
/*@ Extern Coq (is_square : Z -> Prop) */
void next_square(int *p, int k)
/*@ With n
    Require 0 <= k && k < 10 && n == k * k && data_at(p, int, n)
    Ensure exists v, is_square(v) && data_at(p, int, v)
*/
{ *p = *p + 2 * k + 1; }
int square_loop(int *p)
/*@ With n
    Require n == 0 && data_at(p, int, n)
    Ensure __return == 9 && is_square(__return) && data_at(p, int, __return)
*/
{
    int i = 0;
    /*@ Inv 0 <= i && i <= 3 && is_square(i * i) && data_at(p, int, i * i) */
    while (i < 3) {
        next_square(p, i);
        i = i + 1;
        /*@ Assert is_square(i * i) && data_at(p, int, i * i) */
    }
    return *p;
}
