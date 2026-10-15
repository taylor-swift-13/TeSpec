unsigned int quadruple(unsigned int n)
/*@ requires true; ensures return == 0u32; @*/
{ unsigned int m = n+n; return m+m; }

int main(void) /*@ ensures return == 0i32; @*/ { quadruple(1u); return 0; }
