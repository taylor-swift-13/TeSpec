# Local semantics

`FilterHeap::full` precisely owns the eight `X` cells, all eighteen `Filter`
fields, all three PID cells, and `global_prd`. The latter three components are
read-only and must be preserved. `definitions.v` indexes coefficients in the
same declaration order as `Filter`.

The domain excludes every signed-overflow case, so all displayed arithmetic is
mathematical integer arithmetic. `CandidateSFExact` fixes the reference result,
all eight final `X` cells, and the return. The candidate additionally requires
final `X[7]` to equal its initial value.
