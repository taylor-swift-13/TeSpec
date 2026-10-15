int read (int *p)
/* --BEGIN-- */
/*@ requires take v1 = Owned<int>(p);
    ensures take v2 = Owned<int>(p);
@*/
/* --END-- */
{
  return *p;
}

int main(void) /*@ ensures return == 0i32; @*/ { int cell = 2147483647; read(&cell); return 0; }
