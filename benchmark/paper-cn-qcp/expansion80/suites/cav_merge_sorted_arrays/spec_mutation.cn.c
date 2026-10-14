/*@
function [rec] (integer) Count(map<integer,integer> a, integer n, integer v) { if(n <= 0) {0} else { if(a[n-1] == v) {1 + Count(a,n-1,v)} else {Count(a,n-1,v)} } }
@*/
void merge_sorted_arrays(int n, int *a, int m, int *b, int *out)
/*@ requires 0 <= n; 0 <= m; n+m <= 2147483647; take A = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; take B = each(integer i; 0 <= i && i < m) {RW<int>(array_shift<int>(b,i))}; take O = each(integer i; 0 <= i && i < n+m) {RW<int>(array_shift<int>(out,i))}; each(integer i; 0 <= i && i < n-1) {A[i] <= A[i+1]}; each(integer i; 0 <= i && i < m-1) {B[i] <= B[i+1]}; ensures take A2 = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; take B2 = each(integer i; 0 <= i && i < m) {RW<int>(array_shift<int>(b,i))}; take O2 = each(integer i; 0 <= i && i < n+m) {RW<int>(array_shift<int>(out,i))}; A2 == A; B2 == B; O2 == O; @*/
{
    int i = 0;
    int j = 0;
    int k = 0;

    while (i < n && j < m) {
        if (a[i] <= b[j]) {
            out[k] = a[i];
            i++;
        } else {
            out[k] = b[j];
            j++;
        }
        k++;
    }

    while (i < n) {
        out[k] = a[i];
        i++;
        k++;
    }

    while (j < m) {
        out[k] = b[j];
        j++;
        k++;
    }
}
