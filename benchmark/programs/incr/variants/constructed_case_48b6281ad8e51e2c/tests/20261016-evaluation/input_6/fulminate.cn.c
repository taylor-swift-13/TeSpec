void incr(int *p)
/*@ requires take old = Owned<int>(p); old < MAXi32(); ensures true; @*/
{ int n = *p; int m = n+1; *p = m; }

int main(void) /*@ ensures return == 0i32; @*/ { int cell = 2147483646; incr(&cell); return 0; }
