unsigned int quadruple(unsigned int n)
/*@ requires true; ensures return == (4u32 * n) + 1u32; @*/
{ unsigned int m = n+n; return m+m; }

int main(void) /*@ ensures return == 0i32; @*/ { quadruple(1073741824u); return 0; }
