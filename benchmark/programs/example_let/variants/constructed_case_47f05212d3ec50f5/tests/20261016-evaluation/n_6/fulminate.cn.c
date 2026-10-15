unsigned int example_let(unsigned int n)
/*@ requires true; ensures return == 2u32 * n; @*/
{ return 0; }

int main(void) /*@ ensures return == 0i32; @*/ { example_let(4294967294u); return 0; }
