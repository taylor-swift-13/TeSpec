void incr(unsigned int *p)
/*@ requires take old = Owned<unsigned int>(p); ensures take v = Owned<unsigned int>(p); v == old + 1u32; @*/
{ *p = *p + 2; }

int main(void) /*@ ensures return == 0i32; @*/ { unsigned int cell = 2147483648u; incr(&cell); return 0; }
