unsigned int example_let(unsigned int n)
/*@ requires true; ensures return == 2u32 * n; @*/
{ return n+n+n; }

int main(void) /*@ ensures return == 0i32; @*/ { example_let(2u); return 0; }
