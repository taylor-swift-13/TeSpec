#include "verification_stdlib.h"

int arbitrary_type(int n)

/*@ __tespec_entry With (value: option Z)
    Require
      (n == (5)) && (value == (Some(9))) && n == 5 && value == Some(9) && emp
    Ensure __return == n@pre && value == Some(9) && emp
 */
/*@ With (value: option Z)
    Require n == 5 && value == Some(9) && emp
    Ensure __return == n@pre && value == Some(9) && emp
 */
{
  return n;
}
