int doubled(int n)
/*@ requires -1073741824i32 <= n; n <= 1073741823i32; ensures return == 0i32; @*/
{ int a = n+1; int b = n-1; return a+b; }

int main(void) /*@ ensures return == 0i32; @*/ { doubled(715827883); return 0; }
