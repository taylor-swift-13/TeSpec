#include "verification_stdlib.h"
#include "verification_list.h"
#include "int_array_def.h"

struct matrix_leaf {
    int cells[2];
    int weight;
};

struct closed_matrix {
    struct matrix_leaf rows[2];
};

int closed_struct_array(struct closed_matrix *matrix, int delta)
/*@ With (row0: list Z) (row1: list Z)
         (weight0: Z) (weight1: Z) (expected: Z)
    Require
      Zlength(row0) == 2 &&
      Zlength(row1) == 2 &&
      expected ==
        Znth(0, row0, 0) + Znth(1, row0, 0) +
        Znth(0, row1, 0) + Znth(1, row1, 0) +
        2 * delta + weight0 + weight1 &&
      IntArray::full(&(matrix->rows[0].cells[0]), 2, row0) *
      store(&(matrix->rows[0].weight), weight0) *
      IntArray::full(&(matrix->rows[1].cells[0]), 2, row1) *
      store(&(matrix->rows[1].weight), weight1)
    Ensure
      __return == expected &&
      IntArray::full(
        &(matrix->rows[0].cells[0]), 2,
        cons(
          Znth(0, row0, 0),
          cons(Znth(1, row0, 0) + delta@pre + weight0, nil))) *
      store(&(matrix->rows[0].weight), weight0) *
      IntArray::full(
        &(matrix->rows[1].cells[0]), 2,
        cons(
          Znth(0, row1, 0),
          cons(Znth(1, row1, 0) + delta@pre + weight1, nil))) *
      store(&(matrix->rows[1].weight), weight1)
*/
{
    int index;
    int total = 0;
    for (index = 0; index < 2; ++index) {
        matrix->rows[index].cells[1] =
            matrix->rows[index].cells[1] +
            delta +
            matrix->rows[index].weight;
        total = total +
                matrix->rows[index].cells[0] +
                matrix->rows[index].cells[1];
    }
    return total;
}
