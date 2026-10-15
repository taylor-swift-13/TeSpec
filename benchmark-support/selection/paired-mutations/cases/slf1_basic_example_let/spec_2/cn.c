unsigned int example_let(unsigned int n)
/*@ requires true; ensures return == 0u32; @*/
{ unsigned int a = n+1; unsigned int b = n-1; return a+b; }
