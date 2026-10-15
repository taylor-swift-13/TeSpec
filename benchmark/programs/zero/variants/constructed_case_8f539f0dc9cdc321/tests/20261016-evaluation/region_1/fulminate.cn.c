void zero(int *p)
/*@ requires true; ensures true; @*/
{ *p = 0; }

int main(void) /*@ ensures return == 0i32; @*/ { int cells[6]; zero(&cells[1]); return 0; }
