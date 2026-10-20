#include "verification_stdlib.h"

int read (int *p)

/*@ __tespec_entry With v Require
      (p == (4096)) && (v == (-1)) && data_at(p, int, v) Ensure exists w, data_at(p, int, w) */
/*@ With v Require data_at(p, int, v) Ensure exists w, data_at(p, int, w) */
{
  return *p;
}
