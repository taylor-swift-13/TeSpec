void incr(unsigned int *p)
/*@ requires take old = Owned<unsigned int>(p); ensures take v = Owned<unsigned int>(p); v == old + 1u32; @*/
{ unsigned int n = *p; unsigned int m = n+1; *p = m; }

int main(void) /*@ ensures return == 0i32; @*/ {
unsigned int cell_0 = 0U; incr(&cell_0);
unsigned int cell_1 = 1U; incr(&cell_1);
unsigned int cell_2 = 2U; incr(&cell_2);
unsigned int cell_3 = 4294967294U; incr(&cell_3);
unsigned int cell_4 = 4294967295U; incr(&cell_4);
return 0; }
