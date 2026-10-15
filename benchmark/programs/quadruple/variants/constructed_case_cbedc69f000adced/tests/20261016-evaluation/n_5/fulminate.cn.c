unsigned int quadruple(unsigned int n)
/*@ requires true; ensures return == 4u32 * n; @*/
{ return 0; }

int main(void) /*@ ensures return == 0i32; @*/ { quadruple(3221225472u); return 0; }
