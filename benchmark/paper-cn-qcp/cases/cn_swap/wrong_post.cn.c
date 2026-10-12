void swap (unsigned int *p, unsigned int *q)
/*@ requires take P = RW<unsigned int>(p); take Q = RW<unsigned int>(q); ensures take P_post = RW<unsigned int>(p); take Q_post = RW<unsigned int>(q); P_post == P && Q_post == Q; @*/
{
  unsigned int m = *p;
  unsigned int n = *q;
  *p = n;
  *q = m;
}
