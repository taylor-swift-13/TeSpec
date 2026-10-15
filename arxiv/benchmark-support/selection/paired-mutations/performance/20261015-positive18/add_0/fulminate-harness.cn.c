int add(int x, int y)
/*@ requires let sum = (i64)x + (i64)y; -2147483648i64 <= sum; sum <= 2147483647i64; ensures return == (i32)sum; @*/
{ return x+y; }

int main(void) /*@ ensures return == 0i32; @*/ {
add((-2147483647-1),0);
add(2147483647,0);
add(2147483646,1);
add(-2147483647,-1);
add(0,0);
add(5,-3);
return 0; }
