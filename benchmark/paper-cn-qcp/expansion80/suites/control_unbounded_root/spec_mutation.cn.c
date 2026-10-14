int root_cell(int *p)
/*@ requires take x = RW<int>(p); 0 <= x && x <= 100; ensures take y = RW<int>(p); y == return; 0 <= return+1; x <= (return+1)*(return+1); return+1 == 0 || return*return < x; @*/
{
    int n = *p;
    int r = 0;
    while (r * r < n)
    
    { r = r + 1; }
    *p = r;
    return r;
}
