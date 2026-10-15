int add(int x, int y)
/*@ requires true; ensures true; @*/
{ return x+y; }

int main(void) /*@ ensures return == 0i32; @*/ { add((-2147483647-1), 0); return 0; }
