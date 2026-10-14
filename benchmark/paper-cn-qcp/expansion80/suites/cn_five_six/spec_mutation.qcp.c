#include "verification_stdlib.h"
unsigned int five_six(unsigned int *p, unsigned int *q) 
/*@ With P Q Require data_at(p, unsigned int, P) * data_at(q, unsigned int, Q) Ensure __return == 6 && exists P1 Q1, data_at(p, unsigned int, P1) * data_at(q, unsigned int, Q1) */
{
	*p = 5;
	*q = 6;
	return *p;
}
