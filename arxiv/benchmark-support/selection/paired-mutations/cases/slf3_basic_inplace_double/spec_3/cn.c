void inplace_double(int *p)
/*@ requires take old = Owned<int>(p); -1073741824i32 <= old; old <= 1073741823i32; ensures true; @*/
{ int n = *p; int m = n+n; *p = m; }
