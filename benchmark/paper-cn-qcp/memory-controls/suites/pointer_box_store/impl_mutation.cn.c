struct pointer_box { int *ptr; };
void pointer_box_store(struct pointer_box *box, int *target, int value)
/*@ requires take B = RW<struct pointer_box>(box); B.ptr == target; take T = RW<int>(target); ensures take B2 = RW<struct pointer_box>(box); B2 == B; take T2 = RW<int>(target); T2 == value; @*/
{ *(box->ptr) = 0; }
