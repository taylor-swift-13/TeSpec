#include "verification_stdlib.h"

int read (int *p)
/*@ With v Require data_at(p, int, v) Ensure exists w, data_at(p, int, w) */
{
  return *p;
}
