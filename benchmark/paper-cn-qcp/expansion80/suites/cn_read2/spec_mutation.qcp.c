#include "verification_stdlib.h"
unsigned int read (unsigned int *p)
/*@ With P Require data_at(p, unsigned int, P) Ensure __return == P + 1 && data_at(p, unsigned int, P) */
{
  return *p;
}
