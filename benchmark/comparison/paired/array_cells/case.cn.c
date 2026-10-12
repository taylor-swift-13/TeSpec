int sample(int *p)
/*@ requires take x = RW<int>(p); take y = RW<int>(array_shift(p, 1));
    0 <= x; x <= 100; 0 <= y; y <= 100;
    ensures take a = RW<int>(p); take b = RW<int>(array_shift(p, 1));
    a == x; b == x + y; return == x + y; @*/
{ p[1] = p[0] + p[1]; return p[1]; }
int main(void)
/*@ ensures return == 0; @*/
{ int a[2] = {3, 5}; int r = sample(a); return 0; }
