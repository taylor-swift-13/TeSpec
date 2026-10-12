void sample(int *p, int *q)
/*@ requires p == q; take v = RW<int>(p); 0 <= v; v < 100;
    ensures take w = RW<int>(p); w == v + 4; @*/
{ *p = *p + 1; *q = *q + 2; }
int main(void)
/*@ ensures return == 0; @*/
{ int x = 3; sample(&x, &x); return 0; }
