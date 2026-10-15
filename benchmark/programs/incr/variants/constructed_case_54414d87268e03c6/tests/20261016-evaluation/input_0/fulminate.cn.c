void incr(int *p)
/*@ requires true; ensures true; @*/
{ int n = *p; int m = n+1; *p = m; }

int main(void) /*@ ensures return == 0i32; @*/ { int cell = 0; incr(&cell); return 0; }
