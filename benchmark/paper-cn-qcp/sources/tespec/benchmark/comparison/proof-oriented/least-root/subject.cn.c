int root_cell(int *p)
/*@ requires take x = RW<int>(p); 0 <= x && x <= 100;
    ensures take y = RW<int>(p); y == return; 0 <= return;
      each (integer k; 0 <= k) { (return <= k) == (x <= k * k) };
@*/
{
    int n = *p;
    int r = 0;
    while (r * r < n)
    /*@ inv take y = RW<int>(p); y == x; n == x;
        0 <= r && r <= 10 && (r == 0 || (r - 1) * (r - 1) < n); @*/
    { r = r + 1; }
    *p = r;
    return r;
}
int main(void)
/*@ requires true; ensures return == 0; @*/
{ int cell = 13; root_cell(&cell); return 0; }
