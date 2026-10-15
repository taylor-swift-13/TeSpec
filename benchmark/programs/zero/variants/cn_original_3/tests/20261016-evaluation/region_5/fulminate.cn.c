void zero (int *p)
/* --BEGIN-- */
/*@ requires take v1 = Block<int>(p);
    ensures take v2 = Owned<int>(p);
@*/
/* --END-- */
{
  *p = 0;
}

int main(void) /*@ ensures return == 0i32; @*/ { int cells[6]; zero(&cells[5]); return 0; }
