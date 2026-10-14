#include "verification_stdlib.h"
#include "verification_list.h"
#include "int_array_def.h"
void flat_matrix_fill(int *a, int rows, int cols, int value)
/*@ With (l : list Z) Require 0 <= rows && rows <= 4 && 0 <= cols && cols <= 4 && Zlength(l) == rows*cols && IntArray::full(a,rows*cols,l) Ensure IntArray::full(a,rows*cols,repeat_Z(value,rows*cols)) */
{ int r; int c; for (r=0; r<rows; r++) { for (c=0; c<cols; c++) { a[r*cols+c] = 0; } } }
