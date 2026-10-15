#include "verification_stdlib.h"
int read(int *p) /*@ With v Require data_at(p,int,v) Ensure data_at(p,int,v) && __return == v */ { return *p; }
