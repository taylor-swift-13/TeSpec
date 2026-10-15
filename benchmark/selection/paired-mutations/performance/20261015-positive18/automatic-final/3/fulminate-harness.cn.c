void zero(int *p)
/*@ requires take u = Block<int>(p); ensures take v = Owned<int>(p); v == 0i32; @*/
{ *p = 0; }

int main(void) /*@ ensures return == 0i32; @*/ {
int cell_0 = 7; zero(&cell_0);
return 0; }
