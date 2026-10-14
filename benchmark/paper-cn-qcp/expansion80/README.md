# 80-program paired benchmark draft

2026-10-14 update: see `../package-audit.json` and `../review-20261014/` for the
current fixed-input audit and fresh replay. The paragraphs and appendices below
retain the earlier experimental receipts. The original target is still 80;
79 suites exist, and the production industrial allocator remains pending.
The three supplemental memory controls live separately in `../memory-controls/`.

This collection contains 80 active program subjects: 15 existing CN/QCP pairs
with replayed inputs, 63 manually translated CN/QCP source pairs in
`paired-drafts/`, one original Fulminate industrial pKVM buddy allocator, and
one existing QCP expressibility study. The allocator replaces `cn_zero`; that
retired draft remains available but is outside the active catalog. The new pairs have
the same C program body after removing contracts and ABI includes. Their
source snapshots, exact digests and proposed contract relation are in
`source-snapshots/`, `catalog.json` and the per-pair `draft.json` files.

The 63 active new pairs express the author's current judgment that both contracts
describe the same property. The current preparation contains **79 paired subjects
and 10,027 distinct reference-positive inputs**, with spec and implementation
mutations. Complete eight-group replays cover **78 subjects / 9,899 positive
inputs**: native32, native64 and Fulminate accept every reference input; QCP ATP
returns 6,667 PASS and 3,232 UNKNOWN. Across all variants, 9,800 strong expected
verdicts remain UNKNOWN, with no observed false PASS or missing result in these
complete groups. These counts are recorded in `coverage-status.json` and are
separate from the historical 15-pair comparison in `../cases/`.

Tree replay, residual proof completion, held-out admission and the industrial
CN/QCP translation remain open. The existing power study now has a separately
proved paired translation; the original industrial allocator is the sole subject
without a complete prepared CN/QCP pair. Artifact validation does not establish
end-to-end benchmark completion.

| Source family | Existing subjects | New sources | Pool total |
|---|---:|---:|---:|
| CN tutorial | 5 | 12 | 17 |
| QCP examples | 5 | 8 | 13 |
| CAV-Bench | 3 | 43 | 46 |
| teSpec mechanism controls | 3 | 0 | 3 |
| Fulminate industrial pKVM buddy allocator | 0 | 1 | 1 |
| **Total** | **16** | **64** | **80** |

The `category` field groups subjects by arithmetic, pointer ownership,
arrays, recursive lists, trees, strings, search/sort, and industrial allocation.
The 78 paired draft subjects have distinct normalized C bodies; repeated CN tutorial variants
with the same body were replaced before freezing this draft. The
categories follow the feature families described in Fulminate §5.2, with more
QCP and CAV coverage. The paper explicitly reports 75 CN tutorial exercises
combined into 54 programs, plus a VeriFast subset, a Verifiable C hashtable,
and a pKVM allocator; it does not give one additive total for all those
families. This pool's size must therefore not be presented as a measured
coverage win over Fulminate.

A draft enters the experimental denominator only after: (1) reviewing the
CN/QCP contract correspondence and ownership conditions; (2) preparing relevant
inputs and a separate native oracle; (3) checking parser acceptance, both
native ABIs and both tools with no handwritten CN checker; and (4) recording
PASS/FAIL/UNKNOWN/ERROR outcomes. This admission work is in progress for the new drafts. A draft is a proposed benchmark input, not a result.

## Industrial source and capability coverage

The pKVM candidate is described in
[`industrial/pkvm-buddy/candidate.json`](industrial/pkvm-buddy/candidate.json).
Its 2024 source revision includes the paper's original 8-page, two-allocation,
two-release witness and three original mutants: two specification mutants and
one implementation mutant. Original headers and licenses accompany the source.
No generated Fulminate code or tool implementation is included.

The buddy allocator is the production example in Fulminate §5.3. The newer
`cn-pKVM-hyp-allocator` used in the PLDI 2026 artifact is a different allocator
and is not substituted for it. The Verifiable C hashtable in §5.2 is a tutorial
example, not another industrial source.

[`selection-protocol.md`](selection-protocol.md) defines how the final 80
subjects will cover tool capabilities, admit positive inputs and mutation
witnesses, and measure ATP/ITP contributions. Current candidates are still
being revised to satisfy that protocol.

The Fulminate comparison and size statement follow [Banerjee et al., POPL
2025, §5.2–5.3](https://www.cl.cam.ac.uk/~pes20/cn-testing-popl2025.pdf).


## Prepared inputs and new case studies (2026-10-13)

`prepare-scalar.py` prepares 12 subjects with independent Python models and
native C output checks. There are **1,508 distinct positive inputs**: 128 for
each of 11 subjects and exhaustive coverage of the resistor task's 100-input
finite domain. Every subject has independently witnessed specification and
implementation mutants. CN and QCP variants retain matched executable bodies.

`run-suites.py` replays these inputs with native 32/64-bit controls, Fulminate,
and teSpec ATP. `suites/replay-evidence.json` aggregates the latest matching
96 tool groups: zero false passes and zero missing results, with 366 strong
result mismatches, all UNKNOWN results in the quantified-divisibility ATP
runs. These mismatches are unfinished proof work, not confirmed negative
successes. The other 11 subjects match their input-specific expected verdicts.

The [seven detailed case studies](case-studies/README.md) compare Fulminate,
VERINA and COINS, including their existing proof capabilities. Fresh ITP replay
checks the least-root 26-VC group and two divisibility six-VC groups. Both
unbounded CN assertion formulations are compared with finite controls.
Shared COINS powers and VERINA squares have pinned source correspondence;
matched full baseline runs are still pending. Industrial translation and the
full 80-subject admission work remain incomplete.


## Array inputs and mutation replay (2026-10-13)

`prepare-arrays.py` adds eight subjects with **1,024 positive inputs**. At that stage, together
with the scalar suites, there were **20 prepared subjects and 2,532 distinct
positive inputs**. The array oracle checks whole final arrays, preserved source
arrays, and scalar return values. Inputs cover empty arrays when admitted,
singletons, repeated values, mixed signs, ordered/unordered data and int32
boundaries. Increment excludes INT_MAX; negate excludes INT_MIN. Two-array
subjects use disjoint initial blocks in both CN ownership maps and QCP lists.

`run-suites.py` now builds both scalar and array drivers. Native 32/64-bit
reference controls pass all 1,024 array inputs. Fulminate and teSpec ATP pass
all eight original suites. Fulminate's outcomes on both mutant types match
all independent witnesses. teSpec matches every first/last/copy/reverse-copy
mutant outcome, while **945 witnessed violations** in fill/increment/negate/rotate
remain UNKNOWN. There are zero false passes and zero missing final results.
These 945 outcomes satisfy only the weak negative criterion; strong completion
requires FAIL and is unfinished.

The initial array driver exposed a CN frontend crash on `(void)` casts around
void-returning calls. Direct discarded calls fix the driver; no subject body or
contract was changed. Failed initial build logs are retained outside the final
aggregate. This is a harness correction, not evidence that an array subject
is rejected by Fulminate.

`suites/array-replay-evidence.json` contains the latest 64 tool groups, frozen
suite identities and report hashes. `evidence/array-suite-20261013/` includes
compressed original QCP reports, matched CN drivers and instrumentation logs.
`collect-array-evidence.py` can regenerate an aggregate from ordered immutable
reports, with the latest row selected for each case/variant/tool.

Reproduce:

```sh
python3 benchmark/paper-cn-qcp/expansion80/prepare-arrays.py
python3 benchmark/paper-cn-qcp/expansion80/run-suites.py \
  --cases cav_array_first cav_array_last cav_array_fill_value \
  cav_array_increment cav_array_negate cav_copy_array cav_reverse_copy \
  cav_rotate_left_by_one --output /tmp/paired-arrays-fresh
```

The runner returns nonzero while strong expected outcomes remain UNKNOWN.
Draft counts and industrial pending status are preserved; preparation and
partial tool replay do not establish the final 80-subject completion gate.

`coverage-status.json` lists all 80 subjects and their remaining admission gates.
Historical smoke pairs are not counted as 128-input prepared suites.


## Unsigned owned cells and aliasing (2026-10-13)

`prepare-cells.py` adds five subjects: unsigned read, read/add over disjoint
cells, increment, inplace double, and transfer with identical pointers. Each
has 128 admitted positive inputs and both witnessed mutation kinds, giving
**25 prepared subjects and 3,172 positive inputs** across the active pool.
The native oracle checks return values and all owned final cells. Input generation
retains UINT_MAX where admitted, the half-width boundary, and the original
addition/increment/doubling bounds. Aliased transfer uses one actual native cell
for both pointer arguments and admits defined unsigned wrap across the full
uint32 range; its original contract adds no overflow restriction.

All five final paired suites match every expected verdict: 640 original inputs
pass both native ABIs, Fulminate and teSpec; every witnessed specification or
implementation violation receives FAIL. The add mutant survives six inputs and
the double mutant survives one; these executions correctly remain PASS. The
40 tool groups have zero false passes, missing results or strong mismatches.
`suites/cell-replay-evidence.json` retains identities and portable reports.

The first inplace-double run exposed a controller parsing defect: ordinary
comments between a declaration, contract and body hid the contract. The generic
scanner now handles block/line comments while preserving annotations, source
offsets and the original callable contract. Fifty parser/specialization tests
pass, and all 384 original/spec/impl QCP inputs pass the fresh expected-verdict
replay. Subject bodies and contracts are unchanged. Null test verdicts from
diagnostics now retain ERROR instead of being displayed as null.

```sh
python3 benchmark/paper-cn-qcp/expansion80/prepare-cells.py
python3 benchmark/paper-cn-qcp/expansion80/run-suites.py \
  --cases cn_read2 cn_add_read cn_slf0_basic_incr \
  cn_slf3_basic_inplace_double cn_slf9_basic_transfer_aliased \
  --output /tmp/paired-uint-cells-fresh
```

These five suites complete the current paired input replay; the final 80-subject
admission, larger structural/industrial coverage, held-out checks and unresolved
quantified strong negatives remain open.


## String lengths, characters and terminators (2026-10-13)

`prepare-strings.py` adds six 128-input suites: first character, last character,
length, equality, ASCII uppercase conversion and reverse copy. There are now
**31 prepared subjects and 3,940 positive inputs**. Bodies include signed-byte
boundaries -128/127, control characters, ASCII conversion boundaries, repetitions,
prefixes, unequal lengths and empty strings when admitted. The independent oracle
checks returned values and every final byte, including the zero terminator and
preserved source buffers. Native controls explicitly use signed char, matching
QCP's `store_char` resource range.

Five draft CN contracts used logical string lengths without declaring them.
They now declare `cn_ghost` parameters, with concrete lengths supplied by the
CN driver. Reverse copy already has a C length argument and needs no ghost
length; its QCP bind records that value only in `args`, not as a `With` binder.
The C signatures and executable bodies are preserved. The original undeclared
length diagnostic and a successful ghost-length smoke replay are archived.

In the current CN configuration, ghost-call extraction skips switch-label
bodies. Conditional input dispatch fixes this driver issue without changing
subjects, inputs or assertions. The final Fulminate result matches every original
and witnessed mutant outcome on all six suites. Both native ABIs pass all 768
reference inputs. teSpec matches all first/last/length/reverse outcomes; the
string-equality and uppercase-conversion groups retain **500 UNKNOWN expected
verdict mismatches**, including unresolved positive cases. There are no false
passes, missing final results or final parser/driver errors in these suites.

The 48 final tool groups and portable reports are in
`suites/string-replay-evidence.json` and `evidence/string-suite-20261013/`.
At the string-suite milestone, across 31 prepared suites, native32/native64 and Fulminate accept all 3,940
references; teSpec ATP reports 3,626 PASS and 314 UNKNOWN references. There are
1,811 expected-verdict mismatches across all variants, all UNKNOWN. These counts
are partial preparation/replay coverage, not completion of the 80-subject goal.

```sh
python3 benchmark/paper-cn-qcp/expansion80/prepare-strings.py
python3 benchmark/paper-cn-qcp/expansion80/run-suites.py \
  --cases cav_string_first_char cav_string_last_char cav_string_length \
  cav_string_equal cav_string_to_upper_ascii cav_string_reverse_copy \
  --output /tmp/paired-strings-fresh
python3 benchmark/paper-cn-qcp/expansion80/refresh-preparation.py
```

`refresh-preparation.py` reconstructs the full 80-subject progress report from
frozen suites and latest aggregates. It keeps final admission false until the
full protocol and capability coverage are independently established.


## Industrial operation-input preparation

`industrial/pkvm-buddy/prepare-traces.py` prepares 128 distinct complete traces
for the original eight-page allocator: the paper's two-allocation/two-release
trace, exhaustion/recovery, reference lifecycle, and seeded mixed-order traces across all eight pool-start alignment classes.
An independent Python buddy model checks alignment, containment, disjointness,
reference-count bounds, page conservation and final recovery at every step.
The model's missing-min mutation violates alignment on the paper trace; this
is **model evidence**, not a verdict on the original C mutant.

These industrial traces are separate from the 72 paired prepared suites.
Production-C admission, QCP translation and actual original-mutant replay are
pending. The model's chosen addresses are not ground truth: production replay
must adopt actual valid allocation choices. Client cleanup covers every handle
and releases its actual outstanding references, so preparation does not fix an
allocation policy.

Source review also found that the original `hyp_alloc_pages` postcondition
permits NULL and does not specify allocation completeness. Exhaustion/recovery
model expectations therefore cannot automatically label a candidate-contract
violation. Stronger functional properties need explicit matching CN/QCP
contracts. Original ownership-contract checks and extra functional-model checks
must be reported separately.


## Array queries and ordering checks (2026-10-13)

`prepare-array-queries.py` adds 12 subjects and **1,536 positive inputs**:
all-positive, all-zero, any-negative, membership, nonzero count, adjacent
equality, minimum, first minimum/maximum index, strict/non-strict ordering,
and setting every element to zero. Inputs cover empty domains when admitted,
singletons, repeated extrema and first-index ties, signed int32 boundaries
and seeded unordered data. Independent Python models check both return values
and complete final arrays, with native original and implementation-mutant
checks. Every subject has separately witnessed spec and implementation mutants.

Both native ABIs and Fulminate accept all 1,536 reference inputs. Fulminate's
mutant outcomes also match every input-specific oracle. teSpec ATP reports
631 PASS and 905 UNKNOWN reference results; across all variants this group
retains 2,502 strong expected-result mismatches, all UNKNOWN. There are no
false passes or missing final results. The latest 96 tool groups and portable
reports are in `suites/array-query-replay-evidence.json` and
`evidence/array-query-suite-20261013/`.

The nonzero-count QCP draft imported a missing Rocq definition. The supplied
`array_count_nonzero.v` defines the exact recursive count and proves its length
bound and invariance under reversal. `coqc` and independent `coqchk` accept
these lemmas without axioms. These mathematical checks do not complete the
C execution VCs; the fresh count-suite replay still reports UNKNOWN.

At the array-query milestone there were **43 prepared subjects and 5,476 positive inputs**.
Native32/native64 and Fulminate accept all references; teSpec ATP reports
4,257 PASS and 1,219 UNKNOWN references. All variants together retain 4,313
strong expected-result mismatches, all UNKNOWN, with zero false passes and
zero missing results. Final admission, held-out coverage, full ATP/ITP verdicts
and the remaining 37 subjects still require work.


## Further arithmetic and branch subjects (2026-10-13)

`prepare-more-scalars.py` adds eight subjects and **1,024 positive inputs**.
The [contract review](suites/more-scalar-contract-review.md) records matched
preconditions, postconditions, both mutations and defined arithmetic domains.
It distinguishes exact output models from the actual weaker `max3` and
`between` postconditions when labelling negatives. Signed additions include
full-range operands with representable sums; unsigned cases use uint32 controls
and literals. Triangular-sum inputs include the admitted boundary n=65535.

Both native ABIs and Fulminate pass all reference inputs, and Fulminate matches
all input-specific mutant expectations. teSpec ATP matches every expected
outcome in seven subjects. The triangular-sum suite has 120 UNKNOWN results in
each of its three variants, because those inputs exceed the 128-iteration
expansion budget. These are incomplete executions, with no final residual
postcondition VC emitted. Completion requires a finished execution or checked
loop reasoning; the input domain is not reduced to make the tool pass. The 64 groups, zero false passes and zero
missing results are archived in `suites/more-scalar-replay-evidence.json` and
`evidence/more-scalar-suite-20261013/`.

At the further-scalar milestone there were **51 prepared subjects and 6,500 positive inputs**. Both native
ABIs and Fulminate pass all references. teSpec ATP reports **5,161 PASS and
1,339 UNKNOWN references**, with 4,673 strong expected-result mismatches
across all variants, all UNKNOWN. Preparation of the remaining 29 subjects,
industrial C/QCP replay, full proof completion and final admission remain open.

```sh
python3 benchmark/paper-cn-qcp/expansion80/prepare-more-scalars.py
python3 benchmark/paper-cn-qcp/expansion80/run-suites.py \
  --cases cav_add_two cav_sum_to_n cn_add_1 cn_between \
  cn_slf2_basic_quadruple qcp_branch_destruct qcp_simple_arith_add \
  qcp_simple_arith_max3 --output /tmp/paired-more-scalars-fresh
```


## Indexed arrays, additional cells and byte initialization (2026-10-13)

`prepare-memory.py` adds five subjects with **640 positive inputs**. The
[contract review](suites/memory-contract-review.md) records indexed-read bounds,
distinct indices and non-overflowing uint32 sums, preservation of input memory,
write-only byte ownership, and the weaker `five_six` return/ownership contract.
The byte suite explicitly includes signed-char extrema in empty, singleton and
16-byte blocks. Initial-byte-only differences are not counted as distinct
paired inputs: all 128 byte fixtures have unique shared address/length/value
bindings. Both native ABIs and Fulminate pass every reference input;
Fulminate's full-suite mutation results match every independent witness and
survivor expectation.

teSpec ATP matches all expected outcomes for four subjects. For byte
initialization it reports 128 UNKNOWN results per variant, including empty
blocks. The preconditions are SAT and execution completes: the unresolved
return obligations involve `CharArray.full` and `repeat_Z`. This is separate
from the previous triangular-sum execution-limit diagnostic. Its 384 strong
expected-result mismatches remain open. Portable evidence for all 40 groups
is in `suites/memory-replay-evidence.json` and
`evidence/memory-suite-20261013-final/`.

At the memory-suite milestone there were **56 prepared subjects and 7,140 positive inputs**.
Native32/native64 and Fulminate pass all references; teSpec ATP reports
**5,673 PASS and 1,467 UNKNOWN references**. Across all variants there are
5,057 strong expected-result mismatches, all UNKNOWN, zero false passes and
zero missing results. Remaining preparation covers 24 subjects; full final
admission, proof completion and industrial C/QCP replay remain open.


## Sum, insertion sorting and sorted merge (2026-10-13)

`prepare-algorithms.py` adds three subjects with **384 positive inputs**. The
[contract review](suites/algorithm-contract-review.md) records defined partial
sums, sorted/permutation output semantics, unequal array lengths, disjoint
ownership, preserved source buffers and independently witnessed mutations.
Sorting/merge CN contracts use equivalent finite-support count checks and
adjacent ordering. Their earlier nested ordering syntax was rejected, and the
full-int32 count enumeration would require billions of value checks.
[Standalone Rocq theory](theory/README.md) proves the equivalent finite forms
and the pure merge characterization. `coqc` and `coqchk` pass without axioms.
Missing imported sorting/merge definitions are supplied with the fixtures.

Both native ABIs and Fulminate pass all 384 reference inputs and Fulminate
matches every mutant witness/survivor expectation. teSpec ATP matches every
expected sum outcome. Sorting and merge retain **694 UNKNOWN expected-result
mismatches**, including positive cases; their C VC proofs remain unfinished.
The 24 final tool groups have zero false passes and zero missing results:
`suites/algorithm-replay-evidence.json`, `evidence/algorithm-suite-20261013/`.

At the algorithm-suite milestone there were **59 prepared subjects and 7,524 positive inputs**.
Native32/native64 and Fulminate pass all references. teSpec ATP reports
**5,801 PASS and 1,723 UNKNOWN references**; all variants retain 5,751 strong
expected-result mismatches, all UNKNOWN. The remaining 21 subjects, industrial
translation/replay, held-out admission and proof completion remain open.


## Structure swap and strict-majority arrays (2026-10-13)

`prepare-struct-majority.py` adds two subjects and **256 positive inputs**.
[The contract review](suites/struct-majority-contract-review.md) records exact
field correspondence for the owned int32 pair and explicit occurrence-count
admission for the majority array. Both spec and implementation mutants run
on every input, including equal-field and zero-majority survivors.

The driver now allocates actual typed structures and checks every final field.
The majority fixture uses a separate loop-variable declaration in an explicit
compound scope in both languages: this preserves the original loop scope and
behavior while avoiding an invalid comma initializer generated by the tested
Fulminate frontend. Initial and normalized native controls pass the same 128
inputs on both ABIs; the receipt and original compiler diagnostic are retained.
Only corrected field mutations enter the final comparison.

Both native ABIs and Fulminate pass all reference inputs. Fulminate matches
every mutation witness/survivor expectation. teSpec ATP reports UNKNOWN for
all 768 executions: the imported-predicate preconditions require proof, while
execution completes. These are 768 strong expected-result mismatches, with no
false passes or missing results. The final 16 groups and diagnostics are in
`suites/struct-majority-replay-evidence.json` and
`evidence/struct-majority-suite-20261013/`.

At the structure/majority milestone there were **61 prepared subjects and 7,780 positive inputs**.
Native32/native64 and Fulminate pass all references; teSpec ATP reports
**5,801 PASS and 1,979 UNKNOWN references**. All variants together retain
6,519 strong expected-result mismatches, all UNKNOWN. The remaining 19
subjects, checked ITP admission/proofs, held-out review and industrial C/QCP
translation/replay remain unfinished.


## Returned-array interface, recursion and expanded historical pairs (2026-10-13)

`prepare-interfaces.py` adds GCD and pointer-returning sorting, with **256
positive inputs**. GCD includes zero, all sign combinations, int32 boundaries
and Fibonacci inputs with up to 44 Euclidean iterations. Its abs helper has
actual matched C code, and previously missing Zgcd/Zabs bindings now import
standard Rocq gcd/absolute value. Independent kernel checks accept the bindings,
base lemma and gcd invariants for both modulo and signed remainder without
axioms. The [interface review](suites/interface-contract-review.md) records
these repairs separately from C proof completion. Sorting controls check the
actual returned pointer, all output elements and a separate length cell.

Both native ABIs and Fulminate pass all references and Fulminate matches every
mutant witness/survivor expectation. ATP refutes all 128 false output-length
mutations, while the other groups retain **640 UNKNOWN expected-verdict
mismatches**. The final 16 groups and portable reports are in
`suites/interface-replay-evidence.json` and `evidence/interface-suite-20261013/`.

`prepare-existing-simple.py` expands six historical pairs—abs, disjoint-cell
swap, point transpose, indexed array swap, preserved sum and sum-then-zero—
with **768 positive inputs**. It preserves the original source fixture bytes
and historical smoke results. The [review](suites/existing-simple-contract-review.md)
records guards, typed memory, complete output models and both mutations. Array
lengths include the admitted boundary 99. Native controls and Fulminate match
all reference/mutant expectations; ATP matches five full suites. Zeroing sum
retains **135 UNKNOWN results**, comprising 128 references and seven surviving
implementation mutations. All true violations in this six-subject group are
refuted by ATP. Its final 48 groups are in
`suites/existing-simple-replay-evidence.json`,
`evidence/existing-simple-suite-20261013/`.

At the interface/historical milestone there were **69 prepared subjects and 8,804 positive inputs**.
Native32/native64 and Fulminate pass all references; teSpec ATP reports
**6,441 PASS and 2,363 UNKNOWN references**. All variants retain 7,294 strong
expected-result mismatches, all UNKNOWN; there are zero false passes and
zero missing final results. The remaining 11 subjects include recursive heap
programs, binary search, least root, the power expressibility pair and the
industrial allocator. Final admission, held-out review and checked ATP/ITP
completion remain unfinished.


## Membership-based binary search, reversal and exhaustive least root (2026-10-13)

`prepare-search-root.py` adds three subjects and **357 positive inputs**:
128 each for search/reversal and all 101 least-root cell contents admitted by
the original 0..100 precondition. The [review](suites/search-root-contract-review.md)
records exact contracts, both mutations, survivors and independent oracles.
Search native controls accept any valid matching index; 20 results differ from
the representative first match and pass. Reversal checks every output element.
Root checks both returned value and cell, using integer isqrt as the oracle.

Root CN uses the equivalent finite arithmetic monitor, with its exact rewrite
and proof hash recorded. The QCP mathematical assertion remains unchanged.
Fresh `coqc`/`coqchk` replay accepts the equivalence without axioms; this is
contract correspondence, not C VC proof completion. The historical fixtures
and small smoke results remain unchanged.

Both native ABIs and Fulminate pass every original input, and Fulminate matches
all mutant expectations. ATP matches reversal completely and rejects all 101
incorrect root writes. It retains 384 search UNKNOWNs from precondition proof
work and 202 root UNKNOWNs from original/false-spec VCs. The final 24 groups
have 586 strong mismatches, all UNKNOWN, zero false passes and zero missing
results: `suites/search-root-replay-evidence.json`,
`evidence/search-root-suite-20261013/`.

The current total is **72 prepared subjects and 9,161 positive inputs**.
Native32/native64 and Fulminate pass all references; teSpec ATP reports
**6,569 PASS and 2,592 UNKNOWN references**. Across all variants there are
7,880 strong expected-result mismatches, all UNKNOWN. Eight subjects remain:
six recursive heap programs, the power expressibility pair and the industrial
allocator. Full final admission, held-out review and checked proof completion
remain open.


### Owned list suites (2026-10-13, replay pending)

The prepared pool now contains **76 subjects and 9,673 distinct positive inputs**.
Four additional suites cover recursive and iterative length, reversal and append.
Their 512 inputs use actual typed C nodes, including empty lists, repeated values,
int32 boundary data, and lists of lengths up to 32. Append owns two disjoint lists.
The native oracle checks return values and every original node's data and next
pointer. QCP bindings describe the same input sequences and normalized addresses.

All 512 specification mutations violate the original executions. Implementation
mutations have 467 violating inputs; the other 45 are contract-preserving inputs
and retain expected PASS. The integrity validator independently checks graph
ownership, acyclicity, logical-list bindings, reference snapshots and these labels.
The new tool runs are pending; the aggregate replay counts above still cover 72
subjects. Full 80-subject admission and strong-negative completion remain open.


The separate `suites/list-native-control-evidence.json` freezes the completed
three iterative-list control runs: 384 positive inputs pass both native ABIs
and Fulminate; Fulminate rejects 384 spec and 339 impl violations, and accepts
all 45 contract-preserving mutant inputs. Portable drivers, build diagnostics
and every Fulminate input diagnostic are archived and checked by the validator.
These 15 tool groups are separate from the complete eight-groups-per-subject
replay aggregates until QCP finishes.


### Weak helper and owned-tree preparation (2026-10-13)

The prepared pool contains **78 subjects and 9,899 distinct positive inputs**.
The weak recursive-helper suite exhausts all 98 admitted initial cell values
0..97. Its spec mutation demands +4 instead of +3. Its implementation mutation
removes the increment: every helper monotonicity contract still holds, while
the top-level +3 contract fails. Native32/native64 and Fulminate/teSpec ATP all
match the complete reference and mutation expectations (98 positive calls and
196 witnessed violations per contract tool). The host shared-library oracle
binds its own symbols with `-Bsymbolic` to prevent libc `step` interposition.
Executable ABI controls are separate from that library oracle.

The owned-tree suite has 128 inputs, with empty, left/right chains, balanced
and random shapes through the original 100-node upper bound, and int32
key/value boundaries. CN Tree/Nodes/Size and QCP tree/store_tree/tree_size bind
the same concrete owned graph. The oracle checks the node count and preservation
of every original field and link. The spec mutation shifts size by one; the
implementation omits the right subtree. The latter has 83 violating inputs
and 45 surviving inputs. All tree input bindings and labels are independently
checked. Tree and list complete tool replays remain pending.

Complete eight-tool-group replay aggregates currently cover 73 subjects and
9,259 positive inputs: native32/native64/Fulminate references all PASS;
teSpec ATP references are 6,667 PASS and 2,592 UNKNOWN. Strong expected-result
mismatches remain 7,880, all UNKNOWN; false PASS and missing results remain zero.
Power's original existential contract translation and the original industrial
allocator production admission are still unprepared. Full 80-subject admission,
held-out evaluation and residual proof completion remain open.


### Proved power-contract translation (2026-10-13)

The prepared pool now contains **79 subjects and 10,027 distinct positive inputs**.
`contract-translations/cav_simple_power/` adds a CN contract while preserving the
original C body, input domain and unbounded QCP existential postcondition.
The earlier historical expressibility case and its outside-paired-denominator
role remain unchanged. The new translation is a separate benchmark artifact.

`theory/PowerSearchRewrite.v` proves bounded search exactly represents powers,
that every admitted positive int32 power has a witness exponent at most 31,
and that its integer-valued CN encoding is equivalent to the original QCP
nonzero-result contract. Compilation and `coqchk` succeed with no assumptions;
source hashes and logs are frozen in `evidence/power-contract-theory-20261013`.
Search stops when the current power exceeds x. Every evaluated multiplication
therefore has p<=x, so the original x*n<=INT_MAX precondition also bounds p*n.
Base 1 and exponent zero are included. This is a proved equivalent mathematical
contract, not an additional executable C search checker.

The independent input oracle divides x repeatedly by n. The 128-input suite
contains 52 powers and 76 non-powers, int32 boundaries and adjacent values.
Native32/native64 and Fulminate accept all references. Fulminate rejects all
128 spec mutations and all 52 violating implementation mutations, while its
76 surviving implementation executions pass. teSpec ATP reports UNKNOWN on
all 384 reference/spec/impl executions with residual proof obligations; ITP
completion remains required. The complete replay is archived separately in
`suites/power-replay-evidence.json`.

Complete replay aggregates now cover 74 subjects and 9,387 positive inputs.
Native32/native64/Fulminate references all pass. ATP references have 6,667 PASS
and 2,720 UNKNOWN; all variants retain 8,264 expected-result mismatches, all
UNKNOWN. There are zero false PASS and zero missing results in these aggregates.
List and tree replay jobs remain separate until complete. The original industrial
allocator remains the only subject without a prepared paired input suite.
Full 80-subject admission, held-out evaluation and residual proof completion are
still open.


### Original industrial C native replay (2026-10-13)

`industrial/pkvm-buddy/run-native.py` executes the frozen allocator bodies on all
128 industrial traces in both 32-bit and 64-bit native controls. The client
initializer maps actual pages at PFNs 4096..4103 with Linux MAP_FIXED_NOREPLACE,
keeps hyp_physvirt_offset=0, and allocates the complete vmemmap prefix and pool.
This avoids the original driver's out-of-object vmemmap base construction and
retains the original allocation precondition that the offset is nonnegative.
The snapshot's declared BSD flsl dependency is implemented by a portable bit
position helper; the allocator source files are unchanged. The 64-bit build
matches the allocator's production pointer width; 32-bit is an extra control.

All 128 reference traces pass each ABI. The independent oracle follows the C
allocator's actual block choice instead of requiring the model's chosen address.
It checks block alignment and containment, live/free disjointness, every metadata
cell, intrusive free-list backlinks, refcount bounds, zeroed allocated bytes,
page conservation and final recovery. Allocation completeness is a separate
supplemental check, because the original postcondition permits NULL.

The original missing-min implementation mutation fails the owned-state oracle
on all 128 traces in each ABI. Every first failure is in the initialization
post-state: its free partition contains an unaligned or out-of-pool block.
An interrupted native run is classified FAIL only when an observed state already
provides that violation; an exit code alone is insufficient. Portable reports
retain all native snapshots and their checked oracle states. The integrity
validator replays those snapshots and separately checks the initial geometric
violation for each mutant trace.

Evidence is frozen in `evidence/pkvm-native-20261013`. This is original industrial
C execution evidence, not a Fulminate/QCP contract-tool result. Both original
specification mutations and the QCP translation remain pending. The industrial
subject is still excluded from the 79 prepared paired suites and from complete
paired tool aggregates; full 80-subject completion remains false.


The original historical industrial driver currently stops before execution with
an installed-Fulminate parser diagnostic around hyp_pool (`typedef_name`: LNAME
where TYPE is expected). This is an instrumentation error, not a specification
violation. Frozen source hashes and diagnostics are in
`evidence/pkvm-fulminate-original-probe-20261013`; compatible paired contracts
are still needed for the industrial contract-tool experiment.


### Industrial compatibility candidate and completed length replay

`industrial/pkvm-buddy/migrate-cn.py` reproducibly prepares a compatibility
candidate while checking that all 25 frozen files retain identical C tokens.
The candidate qualifies struct tags, adds old builtin-name aliases, expands
access-list entries and joins 144 adjacent annotation groups. It also adapts
the standalone memset specification's parameter types to the current frontend.
The immutable candidate diff and diagnostics are archived in
`evidence/pkvm-cn-migration-20261013`. Parsing advances through the historical
specifications, then typechecking rejects an integer-to-u64 cast. Fixed-width
arithmetic still needs a verified representation translation; the candidate
is not an admitted CN/QCP pair or a successful runtime check.

Complete eight-tool-group results are now frozen for both list-length suites
in `suites/list-length-replay-evidence.json`: 256 references pass native32,
native64 and Fulminate. Fulminate rejects 256 spec mutations and 255 violating
implementation inputs, and accepts the single empty-list survivor. ATP reports
UNKNOWN on all 768 reference/spec/impl executions. Reverse, append and tree
replays remain pending.

Complete aggregates cover **76 subjects and 9,643 positive inputs**; native32,
native64 and Fulminate references all PASS. ATP references have 6,667 PASS and
2,976 UNKNOWN. All variants retain 9,032 expected-result mismatches, all UNKNOWN,
with zero false PASS and zero missing results. The prepared paired pool remains
79 subjects / 10,027 positives, plus 128 separately checked industrial native
traces. Full 80-subject paired admission and proof completion remain open.


### Integer-cast semantics for industrial migration

`theory/IndustrialIntegerCasts.v` now proves unsigned casts are identity inside
bounds, signed-int32-to-byte truncation agrees with direct byte truncation,
and the wrapped address-difference identity used by copy_alloc_id. It also
checks that unsigned underflow 0-1 equals UINT64_MAX. Compilation and coqchk
succeed without assumptions; receipts are in
`evidence/pkvm-integer-cast-theory-20261013`. These are arithmetic identities,
not a proof of pointer provenance or of the full allocator contract translation.

The frozen first syntax candidate uses `migrate-cn-syntax.py`; its evidence and
C-token correspondence remain independently reproducible. The current
`migrate-cn.py` additionally replaces the fixed enum PAGE_SHIFT cast by 12u64,
using the source's PAGE_SHIFT=12 definition and the checked constant-cast lemma.
Its next probe advances to an unsupported pointer-to-u64 cast. The source diff,
typechecking diagnostic and normalized-file hashes are frozen separately in
`evidence/pkvm-cn-migration-enum-20261013`. No cast was silently removed and
no successful contract-tool verdict is claimed for either candidate.


### Original extracted-page spec-mutation witnesses

`extraction-observer.c` uses read-only compiler function-exit hooks to capture
original `__hyp_extract_page` post-states before the caller sets refcount=1.
All 128 reference traces still pass the original independent owned-state oracle
on both ABIs. Each ABI captures 1,311 successful extraction exits, with at least
one witness per trace. The original bug3 mutation replaces Hyp_pool_ex1 by
Hyp_pool: its unexcluded free-root guard includes the extracted refcount-zero
root, whose zeroed prev/next fields cannot equal the nonnull pool list header
or point to a physical address inside the strictly positive pool range.

`theory/IndustrialExtractedPage.v` proves the necessary previous-link condition
false and refutes its universally guarded pool clause, with arbitrary remaining
conjuncts. Coqc/coqchk accept the proofs without assumptions. Actual per-call
pre-states, helper-exit fields, raw normal operation states and proof logs are
frozen in `evidence/pkvm-extraction-witness-20261013`. The validator independently
checks that witnesses correspond to actual successful calls with admitted free
roots, and replays every reference operation state. This establishes concrete
negative-input evidence for the original spec mutation and its necessary pure
condition; it is not a complete generated-VC or CN/QCP contract-tool verdict.
Both original specification mutations now have independently checked necessary-condition
witnesses. Full generated-VC results and the QCP industrial translation remain pending.

The complete list-reverse replay is now archived separately: 128 references
pass native32/native64/Fulminate; Fulminate rejects all 128 spec and 114 impl
violations, and accepts 14 surviving short-list inputs. ATP reports UNKNOWN on
all 384 calls. Complete paired aggregates cover **77 subjects and 9,771 positives**:
ATP references are 6,667 PASS / 3,104 UNKNOWN; all variants retain 9,416 expected
verdict mismatches, all UNKNOWN, with zero false PASS and missing results.
Append and tree jobs remain pending. The prepared paired pool remains 79/80,
10,027 positives; industrial native traces remain separate from paired admission.


### Original ownership-guard spec-mutation witnesses

The original bug1 removes the order!=255 guard that excludes pages subsumed
by a larger free block. Frozen native initialization states supply 128 witnessed
traces on each ABI. Across them, 629 subsumed-page headers per ABI overlap
the parent block's owned zero region. Actual compiler layout probes establish
8-byte headers on native32 and 16-byte headers on native64.

`theory/IndustrialOwnershipGuard.v` proves that a shared byte refutes disjoint
footprints and that the mutated guard includes the subsumed page. Coqc/coqchk
accept both proofs without assumptions. Evidence and layout/proof logs are in
`evidence/pkvm-ownership-witness-20261013`. The validator recomputes each
interval from the original native state and checks both memberships. This is
a necessary separation-condition witness, not a complete typed heap bridge
or a generated CN/QCP contract-tool verdict.


### Mutation witnesses and surviving inputs

`coverage-status.json` now records each subject's witnessed violations and
satisfying survivors separately for specification and implementation mutations.
Across the 79 prepared suites (10,027 reference-positive inputs), spec mutations
have 7,927 witnessed violations and 2,100 survivors; impl mutations have 7,667
witnessed violations and 2,360 survivors. These counts describe independently
established expectations, not achieved tool verdicts. Industrial traces remain
separate until the original contract pair is admitted.

A witnessed violation requires FAIL under the strong standard. UNKNOWN is
accepted only in a separately reported weak-negative result. A satisfying
survivor requires PASS: an applied mutation alone does not establish a negative
input. `refresh-preparation.py` derives the per-subject counts from suite labels,
and the validator checks both the per-subject and aggregate counts against the
validated input records.


### Completed list-append replay

`list-append-replay-evidence.json` archives all eight groups for 128 inputs.
Native32/native64/Fulminate accept every reference input. Fulminate rejects
128 specification violations and 98 implementation violations, and accepts
the 30 satisfying implementation survivors. ATP leaves all 384 calls UNKNOWN.
The immutable portable reports and instrumented-client logs are in
`evidence/list-append-suite-20261013`.

Complete paired aggregates now cover **78 subjects / 9,899 positive inputs**.
Native32/native64/Fulminate references all pass; ATP references are 6,667 PASS
and 3,232 UNKNOWN. Across all variants, 9,800 expected-verdict mismatches remain,
all UNKNOWN, with zero false PASS or missing results. The tree replay and full
industrial CN/QCP translation remain pending; preparation remains 79/80 paired
subjects and 10,027 positives. These aggregates cover ATP, not completed ITP.


### Empty-list precondition certificate

The admitted list-reverse input `input_000` (null pointer, empty logical list)
finishes execution with safety/return VCs VALID but ATP leaves its entry
satisfiability obligation UNKNOWN. A concrete empty-heap witness proves that
entry condition; the certificate also proves the other two original VCs.
Coqc/coqchk accept the complete three-goal group, with only the audited runtime
address interpretation parameter `CNotation.eval_addr_expr`. Sources, coverage,
assumption audit and compressed kernel logs are frozen in
`evidence/list-empty-vc-proof-20261013`. This is one checked original VC group;
it does not change the ATP aggregates or establish all nonempty list cases.
The whole-run certificate controller independently replayed the same complete
VC group and merged this input to PASS, with precondition SAT and completed
execution. Its selected automatic input and final report are archived beside
the proof. The validator checks that selection against the immutable full-suite
ATP report and checks the generated-source and original-goal digests.


### Address arithmetic migration and an executable integer limit

`theory/IndustrialAddressArithmetic.v` proves eight numeric consequences of
the original address functions: signed casts preserve unsigned residues;
physical/virtual conversion roundtrips preserve the wrapped address; metadata
indices match ordinary integer subtraction in the stated nonnegative range;
and wrapped remainders agree only when the element size divides 2^64. A
3-byte counterexample shows why wrap cannot be removed for arbitrary sizes.
Coqc/coqchk accept the proofs without assumptions; receipts and logs are in
`evidence/pkvm-address-theory-20261013`. Allocation identity and pointer
provenance are separate obligations and remain unproved by these identities.

The numeric `address-arithmetic.cn.h` compatibility candidate typechecks, but
its called-contract executable probe encounters an integer representation
limit in the installed Fulminate runtime. `cn_integer` stores `int64_t val`;
the generated C literal 2^64 is truncated to zero, and an actually executed
modulo expression raises SIGFPE. Evidence is in
`evidence/pkvm-address-cn-probe-20261013`. This is RUNTIME_ERROR, not FAIL
or a successful contract translation. The probe uses a called function: an
annotation on main alone does not exercise these postcondition assertions.
Full industrial admission remains pending.


### Original bitvector compatibility candidate

`prepare-cn-bv.py` preserves all original numeric types, casts, builtin names
and allocator C tokens. It adapts the struct tag, access clauses and adjacent
annotation fragments. The independently pinned April 2026 CN now parses,
typechecks and generates the original bitvector assertions. Its generated C
does not compile: inline functions reference missing return temporaries /
epilogue labels, and a lemma collides with the logical function named
`page_size_of_order`. The diff, regenerated-file hashes and diagnostics are in
`evidence/pkvm-cn-bv-compatibility-20261013`. This is a compilation error,
not an allocator result.

An independent switch build uses upstream revision
`720f556d821284afe67e0a4842def65ada74f255` (2026-09-11), immediately before
`8ebf627e2` made integers the default. It retains the upstream bitvector mode
and uses its pinned Cerberus dependency. Build work is outside teSpec, in
`/home/yangfp/tespec-baselines/cn-bv-20260911`, with opam switch
`tespec-cn-bv-20260911`; the current integer-mode baseline is unchanged.
This historical compatibility experiment has no successful result yet and
is separate from all measured 78-subject integer-mode aggregates.


### Portable scalar reports and residual classification

The first 12-subject scalar replay now has portable original QCP reports and
Fulminate client/build logs in `evidence/scalar-suite-20261013-portable`. The
collector checked the exact current fixture sources before archiving; its
1,508 positives, 96 groups and 366 UNKNOWN mismatches are unchanged. All
complete 78-subject ATP groups now have portable detailed reports.

`diagnose-residuals.py` reads these immutable reports and derives
`residual-diagnostics.json`. Across 29,697 original/spec/impl ATP calls, it
records 9,558 PASS, 10,339 FAIL and 9,800 UNKNOWN. Of the UNKNOWN calls,
9,440 completed execution: 6,368 report residual VC proof requirements and
3,072 report entry-satisfiability proof requirements. The remaining 360 calls
hit the loop-unroll limit (120 per variant of `cav_sum_to_n`) and did not
complete execution. These are separate barriers; an ITP proof of a completed
VC group does not complete a truncated execution.

Phase counts can overlap for an input. The diagnostic also counts individual
UNKNOWN obligations separately from input outcomes. The validator reconstructs
the diagnostic from the immutable archives and verifies its source hashes.
This classification records pending work and does not upgrade any result.


### Configurable execution limits and sum-loop replay

`run-suites.py` now accepts generic `--loop-unroll-limit` and
`--call-depth-limit` options, recording both limits in replay provenance.
The defaults remain 128, so previous comparisons retain their configuration.
The original `cav_sum_to_n` input `input_008` (n=153), previously truncated at
128, completes at limit 256 and obtains ATP PASS / entry SAT with the same
source and executor binary. Its raw report is archived in
`evidence/sum-loop-limit-pilot-20261013`. The validator compares the old and
new source, binary, input and execution-limit records.

A fresh full-domain replay uses limit 65,536 for all 128 inputs and all three
variants, without changing contracts, C bodies or expected labels. Its results
are pending and do not yet replace the archived 128-limit aggregates.

The independent September BV tool and its exact Cerberus dependency now build
successfully. The initial network transfer failed; recovery used the same
`b9aeedcb4dd438763b0eef7f95ac19e93875d7de` commit already present in the local
upstream cache. The original BV compatibility candidate reaches an undeclared
legacy `xor_uf` name in this version. Its tool/binary identity, successful build
logs and probe diagnostic are frozen in `evidence/pkvm-cn-bv-september-20261013`.
Builtin-name adaptation remains a next compatibility step; no allocator test
result or paired industrial admission is claimed.


### Industrial builtin adaptation and original proof-side lemmas

The September BV candidate now defines legacy xor/fls aliases, rewrites the
four base-two power calls to shifts, and renames only the lemma named
`page_size_of_order` and its apply sites to avoid a C name collision. All
allocator C tokens and original numeric casts are retained.
`IndustrialPowerShift.v` proves the shift/power equivalence and unsigned range;
coqc/coqchk pass without assumptions. A separate BSD `flsl` ABI shim supplies
the Linux linker dependency, matching the existing native adapter.

The full-check reference now compiles, links and executes, stopping at a
`page_group_ok_easy` precondition ownership assertion. A separate diagnostic
with `--without-lemma-checks` completes the original 2+2 test with exit zero.
That diagnostic is excluded from benchmark success counts; it does not
establish full obligation coverage or eliminate the original client's pointer
provenance question. Logs and the candidate diff are frozen in
`evidence/pkvm-cn-bv-builtins-20261013`.

The same upstream revision also supplies five original Coq sources, now frozen
in `source-snapshots/fulminate/pkvm-buddy-coq`. All five compile unchanged
with Coq 8.20. `InstOK` implements the entire 12-lemma exported interface;
coqchk accepts it and the assumption audit reports all 12 closed under the
global context. Evidence is in `evidence/pkvm-original-coq-20261013`. This
covers the original pure logical lemmas. The two heap-resource conversion
lemmas, runtime ownership-frame correspondence, full QCP translation and
industrial end-to-end admission remain open.

### Industrial ABI alignment audit

`industrial/pkvm-buddy/audit-qcp-abi.py` probes the original allocator's compiler
layout and a nonzero integer's byte encoding on both native ABIs. The frozen
report is `evidence/pkvm-qcp-abi-20261013/report.json`. QCP's current
`CommonAssertion.store_ptr` uses four bytes and `merge_int` encodes the most
significant byte first. The observed native32 and native64 executions use the
least significant byte first; their two-pointer headers occupy 8 and 16 bytes,
respectively. Native32 matches the model's pointer/header sizes, while native64
does not. An explicit representation correspondence is required for byte-level
contracts; equal numeric pointer values do not establish equal byte resources.
Zero-filled headers alone cannot test the nonzero encoding distinction.

The original `struct_list_head_to_bytes` and `bytes_to_struct_list_head` lemmas
still need full typed-resource proofs, including validity and alignment. The
12 upstream pure lemmas already checked by Rocq do not prove these conversions.
Industrial admission must use a common ABI and prove the encoding bridge;
64-bit native results remain separate from the present 32-bit QCP heap model.

### QCP 32-bit header resource prerequisites

`theory/IndustrialHeaderResources32.v` works in the actual `naive_C_Rules`
separation logic. It proves that two stored pointers imply ownership of two
four-byte uninitialized regions, that four zero bytes encode a NULL pointer
when the address is valid, and that a zero-filled eight-byte header implies
two NULL pointer fields when both field addresses are valid. These proofs
retain heap ownership; they are stronger than pure interval overlap arguments.
The first and third proofs depend on the runtime library's functional
extensionality axiom; the single-word proof has no assumptions. The resource
lemmas still require connection to the original CN `Owned<struct list_head>`
and quantified `Byte`/`ByteV` predicates, plus the page remainder and provenance.
They neither establish that bridge nor admit the 64-bit industrial pair.

### Original Fulminate industrial test construction

The frozen upstream `run.sh` at revision
`66afeefe9556bc32b8b027d5b7f62bc3a7069703` preprocesses the client, calls
`cn instrument` with `--with-ownership-checking`, compiles the decorated C,
and runs the executable. It does not explicitly disable lemma checks or pin
the instrumenter's version. The original client initializes eight pages,
allocates two order-zero pages, then releases both. The three original mutants
are two specification mutations (the root ownership guard and the extraction
postcondition) and one implementation mutation (the smaller-address selection
during coalescing). Their source identities and the exact original script are
recorded in `evidence/pkvm-upstream-methodology-20261013/`.

Our 128 industrial traces extend this client-input coverage. Their labels use
independent observed-state oracles; the original source mutation alone does not
label every input FAIL. A runtime invocation with lemma checks disabled remains
a diagnostic and is excluded from primary comparison counts. A build or
instrumentation error is recorded separately from a witnessed contract failure.

### Preserve page resources during header conversion

`theory/IndustrialPageResources32.v` adds a heap-owning zero-byte interval and
proves its prefix/suffix split for arbitrary lengths. Its eight-byte prefix
converts to the previously checked zero header. The final theorem converts
`8 + remaining` zero bytes into two stored NULL pointers and all `remaining`
bytes beginning at offset eight, under explicit validity of both field
addresses. It does not discard the page remainder. The proof uses the actual
QCP separation logic with its functional and propositional extensionality
assumptions. CN quantified-resource correspondence, allocation provenance,
field-layout correspondence and full industrial execution remain open.

### Typed zero-page resource candidate

`theory/IndustrialTypedPage32.v` introduces candidate QCP counterparts of the
original `Byte` and `ByteV` resource layer using `undef_store_char` and
`store_char`. Its zero-page interval owns initialized character cells together
with their address-validity conditions. A checked prefix/suffix split retains
those conditions on the remainder. The header conversion uses the original C
field order, `next` at offset zero and `prev` at offset four. All remaining
cells retain typed resources in the final postcondition, rather than only raw
byte ownership. The proof explicitly requires validity of both pointer-field
addresses. Functional and propositional extensionality are its runtime-library
assumptions. This is a candidate resource-layer translation: the original
quantified absolute-address predicates, allocation provenance, order-to-length
mapping, guarded branches and full pool predicates still require correspondence
proofs before admitting the industrial CN/QCP pair.

### Page-order and address side conditions

`theory/IndustrialPageDomain32.v` proves, without assumptions, that admitted
orders 0 through 10 give page lengths between 4096 and 4194304, that the
original wrapped shift equals this mathematical length, and that an eight-byte
header leaves a nonnegative remainder. It also derives both pointer-field
validity conditions from page alignment, a nonnegative address and the 32-bit
address-range bound. These are explicit hypotheses to be discharged by the
industrial caller translation, rather than assumed by a resource lemma.

The original `page_add_to_list` contract requires `order < 11` before applying
`bytes_to_struct_list_head`; the standalone original lemma declares only `u8
order`. A checked numeric counterexample at order 52 gives zero wrapped page
length, so the u8 type alone does not justify the header conversion. The frozen
original source is preserved. The candidate translation must retain the
caller's admitted-order restriction and establish alignment/address bounds.
This counterexample is not a full original heap-lemma refutation or an admitted
industrial negative test. The complete CN quantified-resource correspondence
and industrial execution remain open.

### Original industrial field layout and padding

The compiler probe `industrial/pkvm-buddy/probe-layout.py` records field offsets,
field sizes, structure alignments and uncovered padding intervals for both ABIs.
The complete logs and report are in `evidence/pkvm-layout-20261013/`. `list_head`
is 8/16 bytes with next at offset zero and prev at offset 4/8. `hyp_page` is
four bytes on both ABIs: refcount at offset zero, order at two, flags at three.
`hyp_pool` is 108/200 bytes. Its free-area array occupies 88/176 bytes; range
start/end occupy the next two eight-byte fields; max_order occupies one byte.
The trailing padding intervals are [105,108) and [193,200), respectively.

The pool translation must account for this padding when establishing its
correspondence with original structure ownership. A predicate listing only
visible field resources does not establish ownership of the complete compiler
object. The report verifies native layout, not the QCP field-address mapping
or CN padding semantics; those correspondence obligations remain open.

### Guarded page predicates and wrapped arithmetic

`theory/IndustrialGuardedPages32.v` combines the resource and domain proofs in
candidate `Page32`, `ZeroPage32`, `AllocatorPageZeroPart32` and guarded allocator
page predicates. Both the original page-size shift and subtraction of header
size use u64 wrapping. The zero-page-to-allocator-page conversion requires
admitted order/alignment/address bounds only when the guard is true. A false
guard consumes no page resources and gives the original default NULL links.
The theorem preserves every typed zero byte after the header. Another theorem
forgets byte values to obtain the uninitialized page resources for either
guard. This combined result still requires the original CN absolute-address
quantifier and pointer-provenance bridge; it does not admit the complete
industrial allocator or the 64-bit pair.

### Industrial object-resource candidates

`theory/IndustrialObjects32.v` defines candidate resources for the original
`hyp_page` and `hyp_pool` structures at the measured 32-bit offsets. Metadata
contains a two-byte unsigned refcount and one-byte unsigned order/flags. The
pool contains exactly 11 two-pointer list heads, two unsigned 64-bit range
fields, an unsigned-byte max_order, and all three trailing padding bytes as
uninitialized byte resources. It retains these padding resources even though
the C program does not read them. Heap-based range proofs recover the original
field-type bounds; an arithmetic proof establishes that distinct free-area
cells do not overlap. Field-type bounds do not establish the stronger
`max_order <= 11` pool invariant, which remains an explicit pure obligation.

This object layer and its measured layout are prerequisites for translating
`Hyp_pool`, `Hyp_pool_ex1` and `Hyp_pool_ex2`. The vmemmap/free-list invariants,
CN structure-ownership and padding semantics, QCP field-address mapping and
pointer provenance still require correspondence proofs. No full pool
translation or industrial paired admission is claimed.


### Explicit list-layout proof prototype

`layout-profiles/list32` prepares standard 32-bit list contracts with explicit
field offsets, preserving C bodies and input bindings. Conditional Coq
correspondence covers arbitrary list lengths; no layout axioms are added to the
original abstract predicate. Diagnostics and model proofs are archived in
`evidence/list-layout-theory32-20261013`.

For `qcp_list_reverse/input_001` (one node with `INT_MIN`), the experimental
reference reaches PASS with four original VCs checked, including entry SAT.
The implementation mutation survives this input and reaches PASS with five
checked VCs. The wrong specification's complete return VC is refuted in Coq,
including both branches of its disjunction. Its execution verdict stays
UNKNOWN until a checked reachability witness establishes a violation from the
original entry state. These results do not change frozen ATP totals or admit
all list subjects. The new explicit runtime definitions are a separate
representation profile, and the CN/QCP ownership correspondence remains open.


### Sparse graph entry certificates

`theory/SparseByteWitness.v` constructs an initialized byte heap from any finite
list of cells with distinct addresses. `theory/DistinctAddressCheck.v` proves
soundness of an executable uniqueness check. These proofs support noncontiguous
and unordered node addresses. The generic `layout-profiles/list32/prepare-entry-proof.py`
generator checks the original suite/report bindings and emits an original entry
SAT certificate for acyclic owned list graphs, including multiple disjoint heads
and empty lists. It does not assign an execution verdict. Separate entry proofs
are not counted as complete execution VC groups or full-suite admission.

The full-input experimental list-layout run covers all 128 bindings of each of
`cn_list_length`, `qcp_list_length`, `qcp_list_reverse` and `qcp_list_append`, for
each of the reference, spec mutation and implementation mutation variants. This
is an independent experimental denominator of 512 inputs and 1,536 variant
executions; pending executions are not completed results or changes to the frozen
ATP aggregate.


### Preserve list unfold guards

The first explicit layout profile's nonempty left-unfold rule forgot the
predicate's non-NULL condition. Its field expansion admits NULL-address heaps
in the QCP model, producing spurious branches and extra return VCs even for
correct programs. `ListUnfoldGuard32.v` proves this distinction with a concrete
heap witness, and proves the guarded rule equivalent to the predicate definition.
`layout-profiles/list32-guarded` retains the missing condition without changing
C bodies, input bindings or mathematical contracts; the earlier profile remains
frozen. The guarded two-node `cn_list_length/input_002` has a complete ten-VC
certificate and controller result PASS with entry SAT, archived in
`evidence/list-unfold-guard32-20261013`.

The complete-proof generator uses one generic tactic schema for original safety,
return and partial-solve obligations, combined with the generic entry heap
witness. Its output still needs assumption auditing and kernel replay. A fresh
128-input reference proof run is in progress; generation is not a completed
result. Guarded profile runs have their own experimental denominator and do not
replace frozen ATP totals or establish full list/industrial CN-QCP admission.
