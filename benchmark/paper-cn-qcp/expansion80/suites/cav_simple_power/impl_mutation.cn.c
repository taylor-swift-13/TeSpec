/*@
function [rec] (integer) PowerSearch(integer x, integer n, integer p, integer fuel) {
  if (p == x) { 1 }
  else { if (p > x || fuel <= 0) { 0 }
         else { PowerSearch(x,n,p*n,fuel-1) } }
}
@*/
int p076_is_simple_power(int x, int n)
/*@ requires 1 <= x; x <= 2147483647; 1 <= n; n <= 2147483647; x*n <= 2147483647;
    ensures (return != 0) == (PowerSearch(x,n,1,31) != 0); @*/
{
    int p=1,count=0;
    
    while (p<=x && count<100)
    {
        if (p==x) return 0;
        p=p*n;count+=1;
    }
    return 0;
}
