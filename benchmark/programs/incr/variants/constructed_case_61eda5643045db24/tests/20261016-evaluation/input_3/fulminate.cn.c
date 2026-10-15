void incr(int *p)
/*@ requires take old = Owned<int>(p); old < MAXi32(); ensures take v = Owned<int>(p); v == old + 1i32; @*/
{ int n = *p; int m = n+1; *p = m; }

int main(void) /*@ ensures return == 0i32; @*/ { int cell = 1; incr(&cell); return 0; }
