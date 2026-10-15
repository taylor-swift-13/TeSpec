void zero(int *p)
/*@ requires take u = Block<int>(p); ensures take v = Owned<int>(p); v == 0i32; @*/
{ *p = 0; }

int main(void) /*@ ensures return == 0i32; @*/ { int cells[6]; zero(&cells[2]); return 0; }
