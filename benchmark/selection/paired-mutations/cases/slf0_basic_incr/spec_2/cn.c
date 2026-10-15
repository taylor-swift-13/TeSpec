void incr(unsigned int *p)
/*@ requires true; ensures true; @*/
{ unsigned int n = *p; unsigned int m = n+1; *p = m; }
