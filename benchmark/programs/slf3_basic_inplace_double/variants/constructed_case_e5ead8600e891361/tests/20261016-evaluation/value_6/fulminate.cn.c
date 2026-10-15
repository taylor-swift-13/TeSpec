void inplace_double(int *p)
/*@ requires take old = Owned<int>(p); -1073741824i32 <= old; old <= 1073741823i32; ensures take v = Owned<int>(p); v == old; @*/
{ int n = *p; int m = n+n; *p = m; }

int main(void) /*@ ensures return == 0i32; @*/ { int cell = 1073741822; inplace_double(&cell); return 0; }
