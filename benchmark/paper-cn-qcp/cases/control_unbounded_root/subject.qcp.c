#include "verification_stdlib.h"
/*@ Extern Coq (least_root: Z -> Z -> Prop) */
/*@ Import Coq Require Import RootSpec */
int root_cell(int *p)
/*@ With x Require 0 <= x && x <= 100 && data_at(p,int,x) Ensure exists r, r == __return && least_root(x,r) && data_at(p,int,r) */
{
    int n = *p;
    int r = 0;
    while (r * r < n)
    
    { r = r + 1; }
    *p = r;
    return r;
}
