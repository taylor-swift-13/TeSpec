void inplace_double(int *p)
/*@ requires take old = Owned<int>(p); -1073741824i32 <= old; old <= 1073741823i32; ensures take v = Owned<int>(p); v == old + old; @*/
{ *p = *p + 2; }

int main(void) /*@ ensures return == 0i32; @*/ { int cell = 5; inplace_double(&cell); return 0; }
