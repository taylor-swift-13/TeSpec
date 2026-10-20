#include "verification_stdlib.h"
int read (int *p)

/*@ __tespec_entry With v Require
      (p == (4096)) && (v == (0)) && data_at(p,int,v) Ensure emp */
/*@ With v Require data_at(p,int,v) Ensure emp */
{
  return *p;
}
