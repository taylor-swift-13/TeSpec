int read(int *p)
/*@ requires take old = Owned<int>(p); ensures return == old; @*/
{ return *p; }
