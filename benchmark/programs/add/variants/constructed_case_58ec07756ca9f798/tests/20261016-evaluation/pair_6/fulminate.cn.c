int add(int x, int y)
/*@ requires true; ensures true; @*/
{ return x+y; }

int main(void) /*@ ensures return == 0i32; @*/ { add(7, -3); return 0; }
