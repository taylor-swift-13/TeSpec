void inplace_double(int *p)
/*@ requires take old = Owned<int>(p); -1073741824i32 <= old; old <= 1073741823i32; ensures take v = Owned<int>(p); v == old + old; @*/
{ int n = *p; int m = n+n; *p = m; }

int main(void) /*@ ensures return == 0i32; @*/ {
int cell_0 = -1073741824; inplace_double(&cell_0);
int cell_1 = -1; inplace_double(&cell_1);
int cell_2 = 0; inplace_double(&cell_2);
int cell_3 = 1; inplace_double(&cell_3);
int cell_4 = 1073741823; inplace_double(&cell_4);
return 0; }
