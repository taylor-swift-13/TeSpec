#include "verification_stdlib.h"

int doubled (int n)

/*@ __tespec_entry Require
      (n == (-715827883)) && -2147483648 <= n-1 && n+1 <= 2147483647 && -2147483648 <= 2*n && 2*n <= 2147483647 && emp Ensure __return == 2*n && emp */
/*@ Require -2147483648 <= n-1 && n+1 <= 2147483647 && -2147483648 <= 2*n && 2*n <= 2147483647 && emp Ensure __return == 2*n && emp */
{
  int a = n+1;
  int b = n-1;
  return a+b;
}
