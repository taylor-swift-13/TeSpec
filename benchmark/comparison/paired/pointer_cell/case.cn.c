void sample(int **pp)
/*@ requires take p = RW<int*>(pp); take v = RW<int>(p); 0 <= v; v < 100;
    ensures take q = RW<int*>(pp); q == p; take w = RW<int>(p); w == v + 1; @*/
{ int *p = *pp; *p = *p + 1; }
int main(void)
/*@ ensures return == 0; @*/
{ int x = 3; int *p = &x; sample(&p); return 0; }
