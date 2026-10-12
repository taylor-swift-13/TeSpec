void inc(int *p)
/*@ requires take v = RW<int>(p); 0 <= v; v < 100; ensures take w = RW<int>(p); w == v + 1; @*/
{ *p = *p + 1; }
void sample(int *p)
/*@ requires take v = RW<int>(p); 0 <= v; v < 98; ensures take w = RW<int>(p); w == v + 2; @*/
{ inc(p); inc(p); }
int main(void)
/*@ ensures return == 0; @*/
{ int a = 3; sample(&a); return 0; }
