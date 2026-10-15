int read(int *p)
/*@ requires take old = Owned<int>(p); ensures take v = Owned<int>(p); v == old; return == old; @*/
{ return 0; }

int main(void) /*@ ensures return == 0i32; @*/ { int cell = 0; read(&cell); return 0; }
