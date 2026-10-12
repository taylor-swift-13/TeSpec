
void sample(int *p, int *q)
/*@ requires take x = RW<int>(p); take y = RW<int>(q); ensures take a = RW<int>(p); take b = RW<int>(q); a == y; b == x; @*/
{ int t = *p; *p = *q; *q = t; }
int main(void)
/*@ ensures return == 0; @*/
{ int a = 3; int b = 5; sample(&a, &b); return 0; }
