#include "verification_stdlib.h"
#include "int_array_def.h"
void array_reverse_in_place(int n, int *a)
/*@ With (l:list Z) Require 0 <= n && IntArray::full(a,n,l) Ensure IntArray::full(a,n,rev(l)) */
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
