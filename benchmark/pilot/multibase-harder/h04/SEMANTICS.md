# h04 semantic contract

`FloatBatchHeap::full(samples,count,inputs,lowers,uppers,outputs,flags)` owns
the complete `count`-element `Sample` array.  The five logical lists have
length `count` and describe the corresponding fields in index order.  Inputs
and bounds are read-only across a post-state occurrence; output and flag
fields are supplied by its final two lists.  Every field, including double
bit patterns and flags, is observable.

The benchmark uses IEEE-754 binary64 with ordinary C comparisons:

- `FNaN p` denotes a quiet NaN with payload `p`; returning the input preserves
  that payload and bit pattern;
- `FNegZero` and `FPosZero` denote the two signed zeros;
- `FFinite z` denotes the exactly representable nonzero integral value `z`;
- lower and upper bounds are exactly representable finite integers.

`BatchDomain` permits NaNs and either signed zero as well as its finite values.
It requires ordered bounds but does not require an input to be ordered with
them.  No infinities occur.  `BatchCounterSafe` supplies valid memory and
excludes counter wrap.

The model predicates in `definitions.v` define numeric equality, mathematical
clamping, and the returned number of clipped finite values.  `NumericEq`
follows C numeric equality for the two zeros, whereas heap observation still
distinguishes their bit patterns.  Helper calls have ordinary C semantics.
