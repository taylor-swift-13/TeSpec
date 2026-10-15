int abs(int x)
/*@ requires MINi32() < x; ensures return == 0i32-x; @*/
{ if (x >= 0) { return x; } else { return -x; } }

int main(void) /*@ ensures return == 0i32; @*/ { abs(0); return 0; }
