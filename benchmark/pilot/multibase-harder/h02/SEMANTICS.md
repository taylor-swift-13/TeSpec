# h02 semantic contract

`GridHeap::full(grid,rows,audit,r,c)` owns one non-null `Grid`, including
every cell in its nested array, all three audit cells, and the two dimension
fields.  `rows` is the three outer rows in C traversal order and `audit` is the
three-element audit array.  The final two logical arguments are the concrete
dimension-field values.  A post-state occurrence therefore preserves
dimensions precisely but otherwise exposes all cells supplied in its logical
lists.

`GridArithmeticSafe` excludes signed overflow in both programs, including the
mutant's `bias+1` and `bias-1`, every per-cell update, every row sum, and the
running total.  It adds no equality constraints between cells.  Function-
local variables are not observable; the complete final `Grid` and return are.

The helpers have ordinary C call semantics.  The nested-list and summary
predicates used by the candidate are defined in `definitions.v`.
