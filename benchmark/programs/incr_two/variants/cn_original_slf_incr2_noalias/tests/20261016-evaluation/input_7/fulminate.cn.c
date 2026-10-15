void incr2a (unsigned int *p, unsigned int *q)
/*@ requires take pv = Owned<unsigned int>(p);
             take qv = Owned<unsigned int>(q);
    ensures take pv_ = Owned<unsigned int>(p);
            take qv_ = Owned<unsigned int>(q);
            pv_ == pv + 1u32;
            qv_ == qv + 1u32;
@*/
{
  unsigned int n = *p;
  unsigned int m = n+1;
  *p = m;
  n = *q;
  m = n+1;
  *q = m;
}

int main(void) /*@ ensures return == 0i32; @*/ { unsigned int a=4294967294u; unsigned int b=4294967293u; incr2a(&a,&b); return 0; }
