#include "verification_stdlib.h"
void inc(int *p)
/*@ With v Require 0<=v && v<100 && data_at(p,int,v) Ensure data_at(p,int,v+1) */
{ *p = *p + 1; }
void sample(int *p)
/*@ With v Require 0<=v && v<98 && data_at(p,int,v) Ensure data_at(p,int,v+3) */
{ inc(p); inc(p); }
int main(void)
/*@ Require emp Ensure __return == 0 */
{ int a = 3; sample(&a); return 0; }
