# Struct-field swap and strict-majority correspondence

Each subject has 128 unique shared inputs, a native return/whole-memory model,
a witnessed spec mutant and a witnessed implementation mutant. Both languages
use matching C bodies and input bindings. Implementation mutants retain every
annotation; specification mutants retain executable code.

## Owned structure with two int32 fields

CN owns `RW<struct int_pair>` at p, storing original fields a=x, b=y. The QCP
`store_int_pair(p,x,y)` definition owns exactly the corresponding a/b field
cells. The reference postcondition is a=y, b=x. Inputs cover equal and unequal
fields, both int32 extrema, mixed signs and seeded full-range values. Native
controls instantiate an actual structure, rather than separate cells pretending
to have a structure layout; both ABIs execute it independently.

The spec mutant requires a=x, b=x in **both** languages. A rewrite to a=x, b=y
would be a different contract and is excluded. The C mutant writes b from the
already-updated a field, resulting in a=y, b=y. Equal input fields are survivors
and expect PASS; the 124 unequal field inputs witness both mutations.

The CN draft contained QCP-only import/strategy directives; those are removed
from CN while the QCP fixture retains them. The replay driver now supports
structured native storage and checks every final field. The QCP tutorial
interface path is passed through the suite's recorded include directory.

## Majority element of a preserved array

Both preconditions require a nonempty int32 array with a strict majority:
an element occurring more than half its length. CN uses its recursive Count
and MaxCount; the QCP library defines `IsMajorityElement(m,l)` as
`2 * count m l > length l`. The reference returns that unique majority and
preserves the whole array. Generation counts occurrences independently before
admission, rather than assuming that Boyer-Moore always returns a valid majority.

Inputs have singleton, odd/even and larger arrays, barely strict majorities,
uniform arrays, minorities in different positions, int32 extrema and seeded
full-range values. The spec mutant requires the returned value NOT to be a
strict majority; it violates all 128 reference runs. The C mutant returns zero.
Zero-majority inputs survive (7); the other 121 inputs are violation witnesses.
Vote arithmetic and loop increments stay representable for the original
precondition's numsSize<=50000.

The current Fulminate frontend emits an invalid comma initializer for a C
`for (int i=0; ...)` declaration. Both paired fixtures now use an explicit
compound scope containing `int i; for (i=0; ...)`, preserving initialization,
lexical scope, loop body and observable behavior. Native controls execute both
the initial and rewritten body with identical 128 inputs on both ABIs; the
normalization receipt retains that comparison and the original compiler log.
No generated checker or Fulminate implementation was patched.

## Current outcome

Both native ABIs pass all reference cases. Fulminate matches every original,
spec-mutant and implementation-mutant expectation. teSpec ATP reports UNKNOWN
for all 768 executions: the imported predicate precondition requires proof;
the symbolic execution itself completes. Mathematical/native admission checks
are not substituted for the missing checked ITP satisfiability evidence.
The final denominator uses only the corrected contracts and driver runs in
`suites/struct-majority-replay-evidence.json`; earlier diagnostics remain external.
