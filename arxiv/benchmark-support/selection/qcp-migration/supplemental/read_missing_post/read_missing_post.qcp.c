#include "verification_stdlib.h"
int read (int *p)
/*@ With v Require data_at(p,int,v) Ensure emp */
{
  return *p;
}
