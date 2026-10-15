void incr(int *p)
/*@ requires true; ensures true; @*/
{ int n = *p; int m = n+1; *p = m; }
