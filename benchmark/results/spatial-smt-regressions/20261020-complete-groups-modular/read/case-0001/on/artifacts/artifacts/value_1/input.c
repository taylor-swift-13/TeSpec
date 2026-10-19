#include "verification_stdlib.h"

int read (int *p)

/*@ __tespec_entry With v Require
      (p == (4096)) && (v == (-1)) && data_at(p, int, v) Ensure __return == v && data_at(p, int, v) */
/*@ With v Require data_at(p, int, v) Ensure __return == v && data_at(p, int, v) */
{
  return *p;
}
