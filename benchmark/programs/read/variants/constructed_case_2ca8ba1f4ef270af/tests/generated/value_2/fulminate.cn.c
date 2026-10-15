int read(int *p)
/*@ requires true; ensures true; @*/
{ return *p; }

int main(void) /*@ ensures return == 0i32; @*/ { int cell = 0; read(&cell); return 0; }
