#include "verification_stdlib.h"
#include "int_array_def.h"

typedef long long int64;

int64 square_first(int64 *p)
/*@ With (xs: list Z) (index: Z) (fallback: Z) (expected: Z)
    Require
      Zlength(xs) == 1 &&
      store(&(p[0]), Znth(index, xs, fallback))
    Ensure
      __return == expected &&
      store(&(p[0]), Znth(index, xs, fallback))
*/
{
  int64 value = p[0];
  return value * value;
}
