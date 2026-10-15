void zero (int *p)
/* --BEGIN-- */
/*@ requires take u = Block<int>(p);
    ensures take v = Owned<int>(p);
            v == 0i32;
@*/
/* --END-- */
{
  *p = 0;
}

int main(void) /*@ ensures return == 0i32; @*/ { int cells[6]; zero(&cells[5]); return 0; }
