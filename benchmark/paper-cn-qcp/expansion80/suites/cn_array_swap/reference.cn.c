void array_swap (int *p, int n, int i, int j)
/*@ requires take A = each(integer k; 0 <= k && k < n) { RW<int>(array_shift<int>(p,k)) }; 0 <= i && i < n; 0 <= j && j < n; j != i; ensures take B = each(integer k; 0 <= k && k < n) { RW<int>(array_shift<int>(p,k)) }; B == A[i: A[j], j: A[i]]; @*/
{

  
  

  int tmp = p[i];

  
  

  p[i] = p[j];
  p[j] = tmp;
}
