int add(int x, int y)
/*@ requires let sum = (i64)x + (i64)y; -2147483648i64 <= sum; sum <= 2147483647i64; ensures return == x; @*/
{ return x+y; }

int main(void) /*@ ensures return == 0i32; @*/ { add(1, 1); return 0; }
