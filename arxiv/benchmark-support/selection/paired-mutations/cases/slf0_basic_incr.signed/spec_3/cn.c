void incr(int *p)
/*@ requires take old = Owned<int>(p); old < MAXi32(); ensures true; @*/
{ int n = *p; int m = n+1; *p = m; }
