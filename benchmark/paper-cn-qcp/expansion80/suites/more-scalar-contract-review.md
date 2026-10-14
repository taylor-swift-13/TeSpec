# Additional scalar correspondence and mutation review

The eight subjects below retain the original executable bodies. CN and QCP
spec mutants change one corresponding postcondition formula; implementation
mutants preserve every annotation. This review is mathematical correspondence
and concrete witness preparation, separate from final benchmark admission.

| Subject | Admitted input | Shared original postcondition | Spec mutation | Implementation mutation |
|---|---|---|---|---|
| cn_add_1 | signed int32 x/y, mathematical x+y in int32 | return=x+y | return=x+y+1 | return x |
| cav_add_two | signed int32 a/b, mathematical a+b in int32 | return=a+b | return=a+b+1 | return a |
| qcp_simple_arith_add | x/y in 0..100 | return=x+y | return=x+y+1 | assign z=x |
| qcp_simple_arith_max3 | signed int32 x/y/z | return>=x and return>=y and return>=z | require return>x as well as other bounds | replace both return-z sites with return x |
| qcp_branch_destruct | signed int32 x<50 and signed int32 y | return=1 iff x=y; otherwise return=0 | require 0 in equality branch | return x!=y |
| cav_sum_to_n | n in 0..65535 | return=n(n+1)/2 | require triangular sum+1 | add i-1 in each iteration |
| cn_between | uint32 p<=q | p<=return<=q | require p<return<=q | return 0 |
| cn_slf2_basic_quadruple | uint32 n with 4n<=UINT_MAX | return=4n | require 4n+1 | return the intermediate 2n |

For `max3` and `between`, the original contracts are weaker than the precise
native reference output. A mutant is a negative only when its observed return
violates the actual bounds. In particular a different value inside [p,q] is
valid for `between`. The generator uses the postcondition predicates to label
mutation violations; disagreement with an exact output model alone is not FAIL.

The triangular-sum bound includes n=65535 and excludes n=65536. Every original
partial sum stays in int32, and loop increment remains defined. The mutation
only decreases the total. The unsigned quadruple mutation is also in range.
Signed additions preserve full-range operand tests while excluding overflow.
Boundary samples and seeded random samples are distinct; every subject has
128 admitted positives and at least one independent witness for both mutation
kinds. Large loop inputs may exceed ATP's 128-iteration expansion limit and
must remain UNKNOWN until execution completes or checked loop reasoning
establishes the remaining execution and obligations.
