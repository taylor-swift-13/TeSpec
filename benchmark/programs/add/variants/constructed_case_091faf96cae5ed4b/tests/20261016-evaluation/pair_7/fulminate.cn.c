int add(int x, int y)
/*@ requires let sum = (i64)x + (i64)y; -2147483648i64 <= sum; sum <= 2147483647i64; ensures return == (i32)sum; @*/
{ return y; }

int main(void) /*@ ensures return == 0i32; @*/ { add(-7, 3); return 0; }
