# TeSpec two-axis concrete-probe workflow

This is a reusable evaluation workflow, not a source of labels.

1. Read the complete implementation, candidate specification, and referenced
   definitions before testing.
2. Analyze Sound (`spec behaviors subset implementation behaviors`) and
   Complete (`implementation behaviors subset spec behaviors`) independently.
3. Enumerate branch and representation boundaries admitted by `Require`.
   For floating-point code include ordinary in-range/out-of-range values and
   every admitted exceptional representation such as NaN and signed zero.
4. Use shell/compiler tools to create a temporary C harness when useful.
   Inspect return values and every observable heap field, including flags and
   floating-point bit patterns. Do not edit the supplied inputs.
5. For Complete, one concrete implementation execution rejected by any
   `Ensure` conjunct is enough to make the axis false.
6. For Sound, check whether existential outputs, numeric equivalence, omitted
   fields, or weak predicates admit an observable state the deterministic
   implementation cannot produce.
7. A passing finite test does not prove an axis. Combine concrete probes with
   direct reasoning over all branches. Treat tool errors as unresolved.
