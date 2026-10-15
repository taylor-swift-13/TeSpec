void zero(int *p)
/*@ requires take u = Block<int>(p); ensures take v = Owned<int>(p); v == 0i32; @*/
{ }
