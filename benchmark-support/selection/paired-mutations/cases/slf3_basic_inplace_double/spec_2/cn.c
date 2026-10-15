void inplace_double(int *p)
/*@ requires true; ensures true; @*/
{ int n = *p; int m = n+n; *p = m; }
