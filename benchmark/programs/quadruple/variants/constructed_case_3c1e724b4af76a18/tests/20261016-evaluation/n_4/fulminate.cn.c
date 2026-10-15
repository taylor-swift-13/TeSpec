int quadruple(int n)
/*@ requires -536870912i32 <= n; n <= 536870911i32; ensures return == 4i32 * n; @*/
{ return 0; }

int main(void) /*@ ensures return == 0i32; @*/ { quadruple(5); return 0; }
