#include "verification_stdlib.h"


int rand() /*@ Require emp Ensure 0 <= __return && __return <= 2147483647 && emp */;

unsigned int val_rand (unsigned int n)

/*@ __tespec_entry With n0 Require
      (n == (2)) && (n0 == (2)) && n == n0 && n0 > 0 && emp Ensure 0 <= __return && __return < n0 && emp */
/*@ With n0 Require n == n0 && n0 > 0 && emp Ensure 0 <= __return && __return < n0 && emp */
{
    return rand() % n;
}

unsigned int two_dice ()
/*@ Require emp Ensure 2 <= __return && __return <= 12 && emp */
{
  unsigned int n1 = val_rand (6);
  unsigned int n2 = val_rand (6);
  unsigned int s = n1 + n2;
  return s + 2;
}
