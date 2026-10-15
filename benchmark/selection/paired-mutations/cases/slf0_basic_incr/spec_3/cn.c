void incr(unsigned int *p)
/*@ requires take old = Owned<unsigned int>(p); ensures true; @*/
{ unsigned int n = *p; unsigned int m = n+1; *p = m; }
