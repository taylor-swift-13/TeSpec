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


void incr_first(unsigned int *p, unsigned int *q)
/*@ requires take n1 = Owned(p);
             take m1 = Owned(q);
    ensures  take n2 = Owned(p);
             take m2 = Owned(q);
             n2 == n1 + 1u32;
             m2 == m1;
@*/
{
  incr(p);
}


void incr_first_(unsigned int *p, unsigned int *q)
/*@ requires take n1 = Owned(p);
    ensures  take n2 = Owned(p);
             n2 == n1 + 1u32;
@*/
{
  incr(p);
}

int main(void) /*@ ensures return == 0i32; @*/ { unsigned int a = 1u; unsigned int b = 0u; incr_first(&a, &b); return 0; }
