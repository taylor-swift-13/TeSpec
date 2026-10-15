int read(int *p)
/*@ requires true; ensures true; @*/
{ return *p; }

int main(void) /*@ ensures return == 0i32; @*/ { read((int*)0); return 0; }
