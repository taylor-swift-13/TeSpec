void swap (unsigned int *p, unsigned int *q)
/* --BEGIN-- */
/*@ requires take v = Owned<unsigned int>(p);
             take w = Owned<unsigned int>(q);
    ensures  take v2 = Owned<unsigned int>(p);
             take w2 = Owned<unsigned int>(q);
             v2 == w && w2 == v;
@*/
/* --END-- */
{
  unsigned int m = *p;
  unsigned int n = *q;
  *p = n;
  *q = m;
}

int main(void) /*@ ensures return == 0i32; @*/ { unsigned int a=2147483647u; unsigned int b=2147483648u; swap(&a,&b); return 0; }
