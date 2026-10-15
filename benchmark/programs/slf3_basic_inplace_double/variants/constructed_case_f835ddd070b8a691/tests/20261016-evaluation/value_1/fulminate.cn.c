void inplace_double(int *p)
/*@ requires true; ensures true; @*/
{ int n = *p; int m = n+n; *p = m; }

int main(void) /*@ ensures return == 0i32; @*/ { int cell = 7; inplace_double(&cell); return 0; }
