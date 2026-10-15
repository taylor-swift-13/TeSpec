void incr(unsigned int *p)
/*@ requires take old = Owned<unsigned int>(p); ensures true; @*/
{ unsigned int n = *p; unsigned int m = n+1; *p = m; }

int main(void) /*@ ensures return == 0i32; @*/ { unsigned int cell = 4294967294u; incr(&cell); return 0; }
