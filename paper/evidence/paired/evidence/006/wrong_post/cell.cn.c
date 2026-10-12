void sample(int *p)
/*@ requires take v = RW<int>(p); 0 <= v; v < 98; ensures take w = RW<int>(p); w == v + 4; @*/
{ int i = 0; while (i < 3) /*@ inv take w = RW<int>(p); w == v + i; 0 <= i; i <= 3; {p} unchanged; @*/ { *p = *p + 1; i = i + 1; } }
int main(void)
/*@ ensures return == 0; @*/
{ int a = 3; sample(&a); return 0; }
