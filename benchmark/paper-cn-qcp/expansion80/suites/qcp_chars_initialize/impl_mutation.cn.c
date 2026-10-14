



void chars_initialize(char *a, int n, char m)
/*@ requires 0 <= n; n < 2147483647; take A = each(integer i; 0 <= i && i < n) {W<char>(array_shift<char>(a,i))}; ensures take B = each(integer i; 0 <= i && i < n) {RW<char>(array_shift<char>(a,i))}; each(integer i; 0 <= i && i < n) {B[i] == m}; @*/
{
  int i;
  
  for (i = 0; i < n; i++)
  {
    a[i] = 0;
  }
}