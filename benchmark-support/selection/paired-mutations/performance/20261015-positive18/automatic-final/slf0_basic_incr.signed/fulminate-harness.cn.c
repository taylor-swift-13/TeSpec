void incr(int *p)
/*@ requires take old = Owned<int>(p); old < MAXi32(); ensures take v = Owned<int>(p); v == old + 1i32; @*/
{ int n = *p; int m = n+1; *p = m; }

int main(void) /*@ ensures return == 0i32; @*/ {
int cell_0 = (-2147483647-1); incr(&cell_0);
int cell_1 = -1; incr(&cell_1);
int cell_2 = 0; incr(&cell_2);
int cell_3 = 1; incr(&cell_3);
int cell_4 = 2147483646; incr(&cell_4);
return 0; }
