#include "verification_stdlib.h"
#include "verification_list.h"
#include "int_array_def.h"
void interior_store(int *a, int *cursor, int n, int k, int value)
/*@ With (l : list Z) Require 1 <= n && n <= 16 && 0 <= k && k < n && cursor == a + k && Zlength(l) == n && IntArray::full(a,n,l) Ensure IntArray::full(a,n,replace_Znth(k,value,l)) */
{ *cursor = 0; }
