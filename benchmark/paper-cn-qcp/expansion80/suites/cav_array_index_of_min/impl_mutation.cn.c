int array_index_of_min(int n, int *a)
/*@ requires 1 <= n; take A = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; ensures take B = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; B == A; 0 <= return; return < n; each(integer j; 0 <= j && j < n) {A[return] <= A[j]}; each(integer j; 0 <= j && j < return) {A[j] > A[return]}; @*/
{
    int idx = 0;
    int i = 1;

    while (i < n) {
        if (a[i] <= a[idx]) {
            idx = i;
        }
        i++;
    }

    return idx;
}
