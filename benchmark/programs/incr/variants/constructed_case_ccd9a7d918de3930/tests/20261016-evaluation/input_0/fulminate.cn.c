void incr(unsigned int *p)
/*@ requires take old = Owned<unsigned int>(p); ensures take v = Owned<unsigned int>(p); v == old + 1u32; @*/
{ *p = 0; }

int main(void) /*@ ensures return == 0i32; @*/ { unsigned int cell = 0u; incr(&cell); return 0; }
