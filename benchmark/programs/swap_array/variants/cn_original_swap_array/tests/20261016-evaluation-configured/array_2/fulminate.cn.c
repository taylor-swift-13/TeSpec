void swap_array (int *p, int n, int i, int j)
/* --BEGIN-- */
/*@ requires take a1 = each(i32 k; 0i32 <= k && k < n) { Owned<int>(array_shift<int>(p,k)) };
             0i32 <= i && i < n;
             0i32 <= j && j < n;
             j != i;
    ensures take a2 = each(i32 k; 0i32 <= k && k < n) { Owned<int>(array_shift<int>(p,k)) };
            a2 == a1[i: a1[j], j: a1[i]];
@*/
/* --END-- */
{
/* --BEGIN-- */
  /*@ extract Owned<int>, i; @*/
/* --END-- */
  int tmp = p[i];
/* --BEGIN-- */
  /*@ extract Owned<int>, j; @*/
/* --END-- */
  p[i] = p[j];
  p[j] = tmp;
}

int main(void) /*@ ensures return == 0i32; @*/ { int cells[2] = {-2147483648, 2147483647}; swap_array(cells,2,0,1); return 0; }
