#include "verification_stdlib.h"
#include "verification_list.h"
#include "int_array_def.h"
struct pointer_box { int *ptr; };
void pointer_box_store(struct pointer_box *box, int *target, int value)
/*@ With (old : Z) Require data_at(&(box->ptr), int *, target) * data_at(target, int, old) Ensure data_at(&(box->ptr), int *, target) * data_at(target, int, value + 1) */
{ *(box->ptr) = value; }
