int read (int *p)
/*@ requires take v1 = Owned<int>(p); @*/
{
  return *p;
}

int main(void) /*@ ensures return == 0i32; @*/ { int cell = (-2147483647-1); read(&cell); return 0; }
