# Mechanized semantic core

The eleven modules compile with Coq 8.20.1 using only the standard library.
The current replay checks 88 principal theorems with closed global contexts.

`InstanceChecking.v` contains the generic execution argument.
It proves:

- strengthening a typed partial binding shrinks its initial-state domain;
- universal correctness transfers to stronger bindings, while nonemptiness
  remains a separate obligation;
- a finite symbolic tree whose obligations are proved covers safe, terminating
  executions from every represented state;
- every reachable state is safe and every terminal state satisfies the postcondition;
- accepted certificates exclude reachable safety/postcondition counterexamples;
- a violating model yields an execution counterexample when every represented
  model is reachable from the initial instance;
- a refutable VC over an overapproximation can coexist with valid executions,
  so VC refutation alone cannot be promoted to a confirmed execution failure;
- checked boundaries retain their input assertion and establish the annotation;
- unfinished nodes cannot have a certificate;
- joint formula/term rewriting preserves observed values;
- existential projection alone can preserve a closed assertion while changing
  its externally observed return value.

The tree has explicit obligations for all-successor coverage, progress,
normalization equivalence and terminal correctness. They are premises that a
concrete executor must justify. The Coq file does not encode C's operational
semantics, sac's AST substitutions, stack allocation or its SMT translation.
Those implementation correspondence obligations remain open research work.
No claim of whole-executor verification follows from the generic theorem.

`CallFrames.v` isolates scalar-cell call semantics in 13 principal theorems.
Call entry copies evaluated argument values into fresh parameter cells and saves
the caller environment. Pointer values retain their referents, including aliases.
Assignments to parameter cells are distinct from writes through their pointers.
Return restores the caller environment, preserves shared writes and the returned
value, and retires callee storage. Nested calls restore the outer invocation's
parameters; returning a local address does not revive its retired storage.
Locations are logical identities, not concrete C addresses. This reference
fragment assumes evaluated, converted arguments and stack-only fresh allocation;
C evaluation order, aggregate layout/copying and dynamic allocation require
additional correspondence proofs.

`LeastRootRewrite.v` proves that the unbounded characterization of a least
integer square root is equivalent to a finite arithmetic formula. It supports
the direct-assertion versus rewritten-monitor comparison in
`benchmark/comparison/proof-oriented/least-root`. Thus a failed translation of
the original assertion is distinguished from impossibility of testing an
equivalent property.

`LayoutBridge.v` gives a computational address interpretation for resolved
aggregate members: a field address is its base plus its byte offset, and a
nested path accumulates offsets. Its 18 theorems establish interval bounds,
containment, alignment, nonzero addresses from positive bases, and byte-domain
disjointness, including arbitrary-depth paths inside disjoint enclosing fields.
Object and field layouts are explicit parameters. The inherited-alignment
theorem requires the field alignment to divide the enclosing object alignment;
unions do not satisfy pairwise field disjointness merely by being well formed.
For positive widths, byte-domain disjointness is equivalent to the interval
ordering disjunction emitted by the contradiction checker. Two positive-width
cells with the same base necessarily overlap, regardless of their contents.
No QCP address axioms are used. Connecting these records to sac layout metadata
and generated VCs, and constructing QCP typed-cell heap witnesses, remain
implementation correspondence obligations. Separate controller certificates
establish selected list, tree and queue instances on both target widths;
they do not establish whole-frontend refinement.

`PreconditionOracle.v` connects the emitted initial VC
`exists eta, ~ (forall h, R eta h -> False)` to satisfiability. A heap witness
implies this VC constructively. The converse states excluded middle as an
explicit theorem premise, with no added global axiom. Refuting the initial VC
is constructively equivalent to emptiness of the whole initial domain. A
counterexample shows why refuting just one disjunct is insufficient. These four
principal statements are closed; the assertion interpretation remains a
parameter. Source, logs and hashes for all five modules are archived in
`benchmark/comparison/proof-audit/precondition-polarity-theory`.

`AffineOffsets.v` adds eight closed statements for common-base cancellation
in integer comparisons and byte-interval disjointness. Typed offsets retain
index times element size. Overlapping offsets still refute disjointness, and
framing the rewritten constraint with another proposition preserves the whole
query. The implementation retains opaque fields and different bases; these
lemmas justify the integer rewrite and do not establish a C implementation
refinement. The six-module replay and new execution evidence are archived in
`benchmark/comparison/proof-audit/offset-normalization`.

Run the replay script from the repository root:

`HeapObservation.v` proves nine statements for auxiliary observations with an
exact local-storage frame. The generic cell type can distinguish initialized,
uninitialized and typed resources. A mask partitions the heap into framed
stack cells and the remaining visible component. Its disjoint decomposition
and uniqueness establish that a lifted assertion checks exactly that visible
component; stack cells and user cells remain owned. An unmentioned visible
cell prevents an empty-heap observation from passing. Two further statements
cover existential observations with witness-dependent frames and establish
the sufficiency of a checked chosen witness. The mask's connection
to C metadata remains a separate refinement obligation. Evidence, including
the first failed proof attempt, is in
`benchmark/comparison/proof-audit/boundary-local-frame`. The extended replay is
in `benchmark/comparison/proof-audit/boundary-local-alias`.

```sh
python3 paper/scripts/check-theory.py --output /tmp/tespec-theory-replay
```

It compiles in a fresh output directory, independently checks the resulting
library with `coqchk`, and records commands, hashes and logs. `Print Assumptions`
for the principal theorems must report a closed global context. The development
contains no admitted proofs or added axioms.


`ClosedListEquality.v` proves five statements for finite integer-list equality:
true/false reflection, instantiated append/reverse comparisons, unequal lengths,
and preservation of an owned-heap observation. This is a denotation-level
contract. The executor's closure checks, integer decoding, constructor identity
and budget behavior still require implementation refinement. The complete
8-module/66-statement replay is archived in
`benchmark/comparison/proof-audit/list-expression-normalization`.

`WitnessInhabitance.v` adds seven closed statements for typed existential
witnesses: unused binders require an inhabited witness type; an empty type
refutes the assertion; self-equality preserves the quantifier for every type;
and integer/list witnesses admit elimination via zero/nil. The nonemptiness
theorem accounts separately for witness existence and heap existence. The
9-module/73-statement replay is archived in
`benchmark/comparison/proof-audit/nominal-existentials`.

`DefinitionNormalization.v` adds seven closed statements for budgeted, licensed
rewrites of joint state/value observations. Stepwise equivalence implies
preservation of observations, initial nonemptiness, obligation validity and
countermodels. Zero budget and blocked reduction retain their input; independent
normalization runs compose. Rewrite licensing is an explicit hypothesis, so
these results do not certify the parser or the executor implementation. The
10-module/80-statement replay is archived in
`benchmark/comparison/proof-audit/definition-normalization-theory`.

The shared-base difference update adds two closed integer statements to
AffineOffsets.v (ten in that module). Exact typed pointer differences use
Z.quot and a nonzero element size. The ten-module/82-statement replay is
archived in proof-audit/shared-base-and-sublist/theory. This extends the
arithmetic denotation lemmas, not the C implementation-refinement claim.

`ObservationTrace.v` adds six closed statements for erasure, lifting, exact observation inventory, membership, satisfaction after discharge, and equality of projected execution sets. The current eleven-module replay combines these with the ten-statement `AffineOffsets.v`; its report is in `paper/evidence/theory-review-20261012/`. The older 86-statement archive predates the two shared-base difference lemmas.
