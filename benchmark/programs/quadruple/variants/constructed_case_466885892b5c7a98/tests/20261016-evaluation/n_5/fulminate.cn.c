int quadruple(int n)
/*@ requires -536870912i32 <= n; n <= 536870911i32; ensures return == 0i32; @*/
{ int m = n+n; return m+m; }

int main(void) /*@ ensures return == 0i32; @*/ { quadruple(536870910); return 0; }
