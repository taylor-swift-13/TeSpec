unsigned int quadruple(unsigned int n)
/*@ requires true; ensures return == 4u32 * n; @*/
{ return n+n+n; }

int main(void) /*@ ensures return == 0i32; @*/ { quadruple(2147483648u); return 0; }
