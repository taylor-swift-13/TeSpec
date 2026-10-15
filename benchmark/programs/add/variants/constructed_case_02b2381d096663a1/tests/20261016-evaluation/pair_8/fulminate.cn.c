int add(int x, int y)
/*@ requires let sum = (i64)x + (i64)y; -2147483648i64 <= sum; sum <= 2147483647i64; ensures (i64)return == (i64)x - (i64)y; @*/
{ return x+y; }

int main(void) /*@ ensures return == 0i32; @*/ { add(2147483647, 0); return 0; }
