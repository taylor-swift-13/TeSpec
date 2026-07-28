#include "verification_stdlib.h"

int polymorphic_type(int n)
/*@ With {A :: *} (value: A)
    Require n == 5 && emp
    Ensure __return == 5 && emp
 */
{
  return n;
}
