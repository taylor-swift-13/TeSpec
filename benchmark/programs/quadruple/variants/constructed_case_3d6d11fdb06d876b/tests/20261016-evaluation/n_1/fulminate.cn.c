int quadruple(int n)
/*@ requires -536870912i32 <= n; n <= 536870911i32; ensures return == 4i32 * n; @*/
{ int m = n+n; return m+m; }

int main(void) /*@ ensures return == 0i32; @*/ { quadruple(-1); return 0; }
