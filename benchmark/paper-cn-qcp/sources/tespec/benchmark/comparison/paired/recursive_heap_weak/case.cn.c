void step(int *p, int n)
/*@ requires take v = RW<int>(p); 0 <= n; n <= 3; 0 <= v; v + n <= 100;
    ensures take w = RW<int>(p); v <= w; @*/
{ if (n > 0) { *p = *p + 1; step(p, n - 1); } }
void sample(int *p)
/*@ requires take v = RW<int>(p); 0 <= v; v <= 97;
    ensures take w = RW<int>(p); w == v + 3; @*/
{ step(p, 3); }
int main(void)
/*@ ensures return == 0; @*/
{ int x = 3; sample(&x); return 0; }
