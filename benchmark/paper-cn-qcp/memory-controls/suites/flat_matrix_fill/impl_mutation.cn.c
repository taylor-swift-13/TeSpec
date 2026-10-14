void flat_matrix_fill(int *a, int rows, int cols, int value)
/*@ requires 0 <= rows; rows <= 4; 0 <= cols; cols <= 4; take A = each(integer i; 0 <= i && i < rows*cols) {RW<int>(array_shift<int>(a,i))}; ensures take B = each(integer i; 0 <= i && i < rows*cols) {RW<int>(array_shift<int>(a,i))}; each(integer i; 0 <= i && i < rows*cols) {B[i] == value}; @*/
{ int r; int c; for (r=0; r<rows; r++) { for (c=0; c<cols; c++) { a[r*cols+c] = 0; } } }
