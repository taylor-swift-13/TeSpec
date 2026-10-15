unsigned int array_read_two (unsigned int *p, int n, int i, int j)
/* --BEGIN-- */
/*@ requires take a1 = each(i32 k; 0i32 <= k && k < n) { Owned<unsigned int>(array_shift<unsigned int>(p,k)) };
             0i32 <= i && i < n;
             0i32 <= j && j < n;
             j != i;
    ensures take a2 = each(i32 k; 0i32 <= k && k < n) { Owned<unsigned int>(array_shift<unsigned int>(p,k)) };
            a1 == a2;
            return == a1[i] + a1[j];
@*/
/* --END-- */
{
/* --BEGIN-- */
  /*@ extract Owned<unsigned int>, i; @*/
/* --END-- */
  unsigned int tmp1 = p[i];
/* --BEGIN-- */
  /*@ extract Owned<unsigned int>, j; @*/
/* --END-- */
  unsigned int tmp2 = p[j];
  return (tmp1 + tmp2);
}

int main(void) /*@ ensures return == 0i32; @*/ { unsigned int cells[2] = {1u, 2u}; array_read_two(cells, 2, 1, 0); return 0; }
