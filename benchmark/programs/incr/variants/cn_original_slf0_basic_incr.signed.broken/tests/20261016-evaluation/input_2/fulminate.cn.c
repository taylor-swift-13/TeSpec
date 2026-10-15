void incr (int *p)
/*@ requires take u = Block<int>(p); 
    ensures take v = Owned<int>(p); 
@*/
{
  *p = *p+1;
}

int main(void) /*@ ensures return == 0i32; @*/ { int cell; incr(&cell); return 0; }
