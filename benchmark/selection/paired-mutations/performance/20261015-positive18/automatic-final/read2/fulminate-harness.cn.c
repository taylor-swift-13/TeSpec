int read(int *p)
/*@ requires take old = Owned<int>(p); ensures take v = Owned<int>(p); v == old; return == old; @*/
{ return *p; }

int main(void) /*@ ensures return == 0i32; @*/ {
int cell_0 = (-2147483647-1); read(&cell_0);
int cell_1 = -1; read(&cell_1);
int cell_2 = 0; read(&cell_2);
int cell_3 = 1; read(&cell_3);
int cell_4 = 2147483647; read(&cell_4);
return 0; }
