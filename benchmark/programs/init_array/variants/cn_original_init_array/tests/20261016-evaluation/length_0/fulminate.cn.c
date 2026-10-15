void init_array (char *p, unsigned int n)
/*@ requires take a1 = each(u32 i; 0u32 <= i && i < n) { Owned<char>( array_shift<char>(p, i)) };
    ensures  take a2 = each(u32 i; 0u32 <= i && i < n) { Owned<char>( array_shift<char>(p, i)) };
@*/
{
  unsigned int j;
  j = 0;

  while (j < n)
/* --BEGIN-- */
  /*@ inv take ai = each(u32 i; 0u32 <= i && i < n) { Owned<char>( array_shift<char>(p, i)) };
          {p} unchanged; {n} unchanged;
  @*/
/* --END-- */
  {
/* --BEGIN-- */
    /*@ extract Owned<char>, j; @*/
/* --END-- */
    p[j] = 0;
    j++;
  }
}

int main(void) /*@ ensures return == 0i32; @*/ { char cells[1] = {0}; init_array(cells,0u); return 0; }
