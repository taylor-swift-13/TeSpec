void array_reverse_in_place(int n, int *a)
/*@ requires 0 <= n; take A = each(integer k; 0 <= k && k < n) {RW<int>(array_shift<int>(a,k))}; ensures take B = each(integer k; 0 <= k && k < n) {RW<int>(array_shift<int>(a,k))}; each(integer k; 0 <= k && k < n) {B[k] == A[k]}; @*/
{
    int left = 0;
    int right = n - 1;

    while (left < right) {
        int tmp = a[left];
        a[left] = a[right];
        a[right] = tmp;
        left++;
        right--;
    }
}
