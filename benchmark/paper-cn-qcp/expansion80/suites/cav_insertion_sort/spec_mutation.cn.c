/*@
function [rec] (integer) Count(map<integer,integer> a, integer n, integer v) { if(n <= 0) {0} else { if(a[n-1] == v) {1 + Count(a,n-1,v)} else {Count(a,n-1,v)} } }
@*/
void insertion_sort(int n, int *a)
/*@ requires 0 <= n; n <= 2147483647; take A = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; ensures take B = each(integer i; 0 <= i && i < n) {RW<int>(array_shift<int>(a,i))}; B == A; @*/
{
    int i;
    int j;
    int key;

    for (i = 1; i < n; ++i) {
        key = a[i];
        j = i - 1;
        while (j >= 0 && a[j] > key) {
            a[j + 1] = a[j];
            j--;
        }
        a[j + 1] = key;
    }
}
