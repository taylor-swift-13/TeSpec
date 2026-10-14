int binary_search(int n, int *a, int target)
/*@ requires 0 <= n; n <= MAXi32(); take A = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; each(integer k; 0 <= k && k < n*n) {k/n > mod(k,n) || A[k/n] <= A[mod(k,n)]}; ensures take B = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; B == A; each(integer i; 0 <= i && i < n) {return != -1 || A[i] == target}; return == -1 || (0 <= return && return < n && A[return] == target); @*/
{
    int left = 0;
    int right = n - 1;
    int mid;

    while (left <= right) {
        mid = left + (right - left) / 2;
        if (a[mid] == target) {
            return mid;
        }
        if (a[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return -1;
}
