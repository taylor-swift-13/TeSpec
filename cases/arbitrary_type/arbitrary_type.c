#include "verification_stdlib.h"

int arbitrary_type(int n)
/*@ With (value: option Z)
    Require n == 5 && value == Some(9) && emp
    Ensure __return == n@pre && value == Some(9) && emp
 */
{
  return n;
}
