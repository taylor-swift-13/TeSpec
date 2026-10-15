// #include "slf0_basic_incr.c"

void incr (unsigned int *p)
/* --BEGIN-- */
/*@ requires take n1 = Owned<unsigned int>(p);
    ensures take n2 = Owned<unsigned int>(p);
            n2 == n1 + 1u32;
@*/
/* --END-- */
{
  unsigned int n = *p;
  unsigned int m = n+1;
  *p = m;
}



void incr_two (unsigned int *p, unsigned int *q)
/*@ requires take n1 = Owned(p);
             ptr_eq(q,p);
    ensures take n2 = Owned(p);
            n2 == n1 + 2u32;
@*/
{
  incr(p);
  incr(q);
}



void aliased_call (unsigned int *p)
/*@ requires take n1 = Owned(p);
    ensures  take n2 = Owned(p);
             n2 == n1 + 2u32;
@*/
{
  incr_two(p, p);
}


int main(void) /*@ ensures return == 0i32; @*/ { unsigned int a=4294967294u; aliased_call(&a); return 0; }
