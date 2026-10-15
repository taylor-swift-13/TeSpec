void zero(int *p)
/*@ requires take old = Owned<int>(p); ensures take v = Owned<int>(p); v == old; @*/
{ *p = 0; }

int main(void) /*@ ensures return == 0i32; @*/ { int cells[6]; cells[5]=2147483647; zero(&cells[5]); return 0; }
