unsigned int example_let(unsigned int n)
/*@ requires true; ensures return == n; @*/
{ unsigned int a = n+1; unsigned int b = n-1; return a+b; }

int main(void) /*@ ensures return == 0i32; @*/ { example_let(4294967294u); return 0; }
