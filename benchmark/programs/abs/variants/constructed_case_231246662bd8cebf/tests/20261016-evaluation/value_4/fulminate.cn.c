int abs(int x)
/*@ requires MINi32() < x; ensures return == ((x >= 0i32) ? x : (0i32-x)); @*/
{ return x; }

int main(void) /*@ ensures return == 0i32; @*/ { abs(1); return 0; }
