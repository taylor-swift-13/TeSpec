int read(int *p)
/*@ requires take old = Owned<int>(p); ensures return == old; @*/
{ return *p; }

int main(void) /*@ ensures return == 0i32; @*/ { int cell = 2147483647; read(&cell); return 0; }
