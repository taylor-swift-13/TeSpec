void zero(int *p)
/*@ requires take old = Owned<int>(p); ensures take v = Owned<int>(p); v == old; @*/
{ *p = 0; }

int main(void) /*@ ensures return == 0i32; @*/ { int cells[6]; cells[2]=0; zero(&cells[2]); return 0; }
