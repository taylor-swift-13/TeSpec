# Historical simple pairs expanded to full input suites

These six subjects reuse the existing CN/QCP fixture bytes in `../cases/`.
The original 15-pair historical smoke experiment is preserved; these 768-input
runs are a separate experiment with both mutation kinds and native oracles.

| Subject | Shared original contract/admission | Spec mutation | C mutation |
|---|---|---|---|
| cn_abs | int32 x>INT_MIN; return mathematical absolute value | absolute value+1 on both sign branches | return x in the negative branch |
| cn_swap | own two disjoint uint32 cells P/Q; exchange values | require both final cells to equal original P | final q gets original Q |
| cn_transpose | own a point with two uint32 fields x/y; exchange fields | require both final fields to equal original x | final y gets original y |
| cn_array_swap | own n int32 cells, distinct valid i/j; exchange exactly those elements | require the whole array unchanged | write zero at j |
| qcp_array_sum | own/preserve 0<n<100 int32 cells, every value 0..99; return their sum | require sum+1 | subtract instead of adding |
| qcp_array_sum_zero | same admission; return original sum and zero the entire array | require sum+1, retaining zeroing | subtract instead of adding |

Every suite contains 128 distinct paired input bindings. Arrays include lengths
1 where admitted, 2/3/4/8/16 and the boundary 99; swaps start at length 2.
Samples include mixed values, repetitions, equal exchanged values, both int32
extrema for copying, full uint32 field/cell values and seeded arbitrary data.
Partial sums are at most 9801, and mutated subtraction remains representable.
Typed native storage checks every final cell/field/element, including unchanged
regions. The native model treats a structure as an actual structure.

Spec and implementation mutants are executed on the full original input suite.
Equal-value swaps/transposes are valid survivors. Array swaps can be unchanged
when exchanged values match, and zero replacements can already be correct.
These executions expect PASS; the independent final-state comparison labels
only actual contract violations as negative.

Native32/native64 and Fulminate accept every reference input; all Fulminate
mutant outcomes match the independent expectations. ATP matches all expected
outcomes in five subjects. Zeroing sum retains 135 UNKNOWN results: 128
reference executions and seven implementation survivors. Its false-sum
specification and other implementation violations are refuted. The `zeros`
function has an actual definition in the imported AUXLib.ListLib, so these
remaining UNKNOWNs are proof work rather than an undeclared mathematical name.

The final 48 tool groups, zero false passes and zero missing results are in
`suites/existing-simple-replay-evidence.json` and
`evidence/existing-simple-suite-20261013/`. Final admission and held-out review
are tracked separately from the historic small smoke result.
