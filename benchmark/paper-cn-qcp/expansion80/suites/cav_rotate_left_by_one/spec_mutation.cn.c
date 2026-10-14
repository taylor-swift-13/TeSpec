void rotate_left_by_one(int n, int *a)
/*@ requires 1 <= n; take A = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; ensures take B = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; each(integer i; 0 <= i && i < n-1) {B[i] == A[i+1]}; B[n-1] == A[0] + 1; @*/
{
    int i;
    int first = a[0];

    for (i = 0; i < n - 1; ++i) {
        a[i] = a[i + 1];
    }
    a[n - 1] = first;
}
