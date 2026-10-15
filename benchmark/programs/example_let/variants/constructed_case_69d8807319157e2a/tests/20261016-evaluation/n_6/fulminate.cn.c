int doubled(int n)
/*@ requires -1073741824i32 <= n; n <= 1073741823i32; ensures return == 2i32 * n; @*/
{ return 0; }

int main(void) /*@ ensures return == 0i32; @*/ { doubled(715827882); return 0; }
