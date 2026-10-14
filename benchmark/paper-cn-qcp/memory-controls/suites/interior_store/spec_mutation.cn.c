void interior_store(int *a, int *cursor, int n, int k, int value)
/*@ requires 1 <= n; n <= 16; 0 <= k; k < n; cursor == array_shift<int>(a,k); take A = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; ensures take B = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; each(integer i; 0 <= i && i < n) {B[i] == (i == k ? value + 1 : A[i])}; @*/
{ *cursor = value; }
