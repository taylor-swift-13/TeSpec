int read(int *p)
/*@ requires take old = Owned<int>(p); ensures take v = Owned<int>(p); v == old; return == 0i32; @*/
{ return *p; }
