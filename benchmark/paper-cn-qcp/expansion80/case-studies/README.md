# Case studies: mathematical oracles and stateful execution

This study contains seven detailed comparisons. Two mathematical-oracle cases
were replayed on 2026-10-13; three stateful cases use identified existing evidence;
two shared-task studies define the next experiments. Candidate designs are not
included in measured success counts. The industrial subject has its original
source and mutations frozen, but its QCP translation is pending.

## Comparison unit and verdicts

For each C test, the input must satisfy the entry domain, execution must finish,
and every generated safety, annotation and return obligation must be covered.
ATP runs first; a residual validity obligation can be proved or refuted by ITP.
Failure to prove either polarity gives UNKNOWN. A refuted abstract VC counts as
an execution failure only with the required admitted execution witness. Strong
negative tests require FAIL; weak negative tests allow UNKNOWN and are reported
separately. Instrumentation and parser errors are diagnostic outcomes.

VERINA and COINS already support mathematical proof. The comparison asks how
an oracle obtains its values and states, which boundaries it observes, and what
its negative evidence establishes. Neither project is credited with an absent
feature merely because its published benchmark evaluates another interface.

| System / pinned source | Native evaluation unit | Relevant oracle route | Extension required for this C study |
|---|---|---|---|
| Fulminate / CN testing | Instrumented C execution and logical heap assertions | Executable ownership and functional checks | An executable formulation when the original quantified assertion cannot be instrumented |
| VERINA `66b3ce50` | Lean program/specification tasks, positive and negative tests | Simplification, decision, Plausible, and proof routes; tri-valued scores | A C semantics/heap adapter and generated internal-boundary obligations |
| COINS `134339cd` | Rocq specification applied to trusted input/output examples | Instance proof checking; output mutants test acceptance | A C execution front end, heap-state materialization, and internal-boundary obligations |
| teSpec / binary `4b6a46f3` | Partially instantiated C execution with all original VCs | ATP followed by checked proofs of either polarity | Residual proofs and coverage/reachability evidence |

The VERINA repository pins Lean 4.18.0. Its `metrics.py` contains PASS/FAIL/UNKNOWN
and inverse property checks; some configurations accept Plausible's absence of a
counterexample as PASS. COINS's negative driver can accept an agent's decision
that a pair is rejected without a checked rejection proof. These routes must be
separated from certified rejection when comparing strong negative results.
No full VERINA or COINS agent run is reported here.

## 1. Least integer square root: preserve the original quantifier

**Program and property.** A C loop increments `r` and writes the result into a
cell. For input `n=13`, it returns/writes 4 after four iterations. The original
relation is `0 <= r` and, for every nonnegative integer `k`,
`r <= k <-> n <= k*k`. This expresses minimality rather than merely returning a
root above the input.

**Observed comparison.** The current CN instrumentation rejects the original
unbounded postcondition with an upper-bound inference diagnostic. A finite
formulation `0 <= r && n <= r*r && (r=0 || (r-1)^2<n)` instruments and executes
successfully. `paper/theory/LeastRootRewrite.v` proves equivalence. teSpec's ATP
result is UNKNOWN, then the independently checked original group of **26 VCs**
returns PASS. These include entry existence and safety. The 2026-10-13 replay
checks an existing candidate against freshly generated goals; it does not
measure fresh agent proof search. Address evaluation is the sole audited runtime
assumption.

**Relation to VERINA and COINS.** Either proof assistant can express the same
mathematical relation. A concrete pair `(13,4)` can be checked by an instance
proof. teSpec additionally connects that relation to the executed writes,
symbolic address, loop states, and safety obligations. The measured advantage
over the tested runtime route is retaining the original quantified assertion.
It is not an expressiveness separation from Lean or Rocq.

**Evidence:** [`../evidence/least-root-20261013/receipt.json`](../evidence/least-root-20261013/receipt.json),
[`../advantage-example.md`](../advantage-example.md).

## 2. Divisibility: existential success and universal rejection

**Program and property.** `is_multiple(a,b)` returns 1 iff `a % b == 0`, with
`b>0`. Its QCP postcondition explicitly distinguishes
`r=1 /\ exists q:Z, a=q*b` and `r=0 /\ forall q:Z, a!=q*b`.
The two replayed inputs are `(6,3)` and `(7,3)`.

**Observed comparison.** ATP leaves both inputs UNKNOWN. Checked ITP completion
returns PASS for both entire original groups, **six VCs per input**. A witness
`q=2` proves the first; integer arithmetic proves `forall q, 7 != 3*q` for the
second. The first case uses full kernel replay and the second checked dependency
reuse. These are positive execution tests, even though one branch proves a
universal nonexistence fact.

The finite CN contract uses `mod(a,b)=0`. Adding its equivalent unbounded
universal consequence makes the tested instrumenter reject the assertion with
a lower-bound inference diagnostic; the finite version passes both calls.
[`divisibility/theory/DivisibilityRewrite.v`](divisibility/theory/DivisibilityRewrite.v)
proves both the quantified/finite relation and redundancy of the added clause,
with no axioms; standalone `coqchk` succeeds. The CN spelling retains a finite
base clause and adds the quantified consequence: it is an equivalent assertion
comparison, not an identical syntactic encoding of QCP's existential branch.

**Why this case is useful.** It separates a genuinely false execution contract
from a correct contract that requires universal reasoning. It also prevents the
mistake of calling a correct `false` classifier output a negative test.
VERINA inverse tests and COINS instantiated proofs can address the same pure
relation; teSpec checks the complete C execution group supplying the result.

**Evidence:** [`divisibility/evidence/receipt.json`](divisibility/evidence/receipt.json),
[`divisibility/subject.qcp.c`](divisibility/subject.qcp.c).
The larger 128-input divisibility suite still needs full ITP completion; these
two certificates do not complete that suite.

## 3. COINS HumanEval/76: powers without enumerating the specification

**Shared task.** COINS defines `result=true <-> exists k:nat, x=n^k`.
The existing QCP subject `p076_is_simple_power` uses precisely this relation
with `r!=0` as the Boolean adapter. Its bounded C implementation maintains a
current power and exponent and tests powers in a loop. COINS's unconstrained
integer precondition is narrowed to `x>=1`, `n>=1`, and `x*n<=INT_MAX` for defined
signed C execution. The narrowing must be reported, not silently imposed on
COINS's task.

**Cases to compare.** Include `(1,4)`, `(8,2)`, `(3,2)`, `(3,1)`, and adjacent
powers; cover exponent zero and the `n=1` branch. Use implementation mutants
that skip the initial power or change multiplication, and specification mutants
that exclude exponent zero or allow a non-power. Independently record which
inputs actually expose each mutant. A wrong result such as `(8,2,false)` is a
strong negative only after proving the original relation rejects it.

**Expected distinction to test.** COINS already proves an instantiated relation
on an externally supplied pair. teSpec should derive that pair from the C loop
and retain overflow and intermediate-state obligations. Fulminate needs an
executable power check or a justified finite exponent bound on this C domain.
A [checked pure-specification control](shared-oracle-controls/README.md)
accepts all six original examples and proves rejection of two wrong outputs.
It uses the matching relation in a standalone Rocq module, not the COINS agent.
No original-quantifier runtime rejection or complete C proof-group success is
claimed for this task yet; it remains the catalog's expressibility study.

**Sources:** [`../../expressibility/cav_simple_power/subject.qcp.c`](../../expressibility/cav_simple_power/subject.qcp.c),
[COINS original task](https://github.com/taylor-swift-13/Coins/blob/134339cd7a419dfd6a42a0d36ed88f8fd5bbdd41/spec/human/input/76.v).

## 4. VERINA basic/48: perfect-square classification in a C domain

**Shared task.** VERINA's `isPerfectSquare` has postcondition
`result <-> exists i:Nat, i*i=n`. Its task includes a Lean implementation and
soundness/completeness proofs. This is a particularly useful control: the
baseline already proves the mathematical property, so a comparison can measure
execution integration rather than crediting teSpec with the quantifier alone.

**C adaptation and inputs.** A reviewed C counterpart should preserve the
existential relation while avoiding overflow in the search. Test `0,1,2,3,4`,
values on both sides of squares, and the chosen signed-width boundary. A loop
with signed `i*i` must either prove its bound before multiplication or use a
wider checked representation; an overflow-prone port is not a valid baseline.
Mutation `i*i=n` to `i*i<=n` changes the specification; replacing equality in
the implementation changes behavior. Both need independently established
witnesses, including nonsquares.

**Comparison endpoints.** Run VERINA's original task with pinned Lean 4.18.0,
then CN/Fulminate and teSpec on the reviewed C pair. Report the domain bridge,
residual VCs and both proof polarities. C safety and writes, if included, are
extra obligations; they cannot be treated as costs of VERINA's pure task.
A [Lean semantic control](shared-oracle-controls/README.md) checks five correct
outputs and proves rejection of two wrong outputs, using the original existential
relation. It uses Lean 4.34.0 and standard core axioms, not VERINA's pinned 4.18.0
pipeline. The source comparison is complete, but the C adaptation and matched
tool runs are pending. No VERINA win/loss row is recorded.

**Source:** [VERINA original task and proofs](https://github.com/sunblaze-ucb/verina/blob/66b3ce5014edafb20cb26b87c681e7f31847249f/datasets/verina/verina_basic_48/task.lean).

## 5. Intermediate assertion mutation with identical final output

**Program.** Keep the least-root loop and return contract unchanged. Just before
writing the cell, replace `LeastRoot(n,r)` by `LeastRoot(n,r-1)`. Both executions
still iterate four times, visit five invariant states, and write/return 4.
An output-only comparison of the two programs sees identical behavior.

**Existing evidence.** The positive 27-VC group is checked. In the mutated group,
the negation of the complete assertion VC is checked and the other 26 VCs are
proved. The archive records **VC_REFUTED**, with admitted execution-counterexample
evidence **NOT_ESTABLISHED**. Its overall negative result cannot be upgraded to
FAIL. The CN intermediate translation has unresolved placement diagnostics and
is excluded from a valid paired comparison.

**Relation to other tools.** Fulminate supports intermediate assertions; this
study must use a correctly placed assertion, not a failing harness. VERINA and
COINS can reason about an internal state if that state and its reachability are
provided. Their published input/output task interface alone does not create
this boundary. teSpec's contribution is to generate the boundary from C
execution and tie the checked formula to that execution. The pending witness
certificate is also a direct test of teSpec's strong-negative standard.

**Evidence:** [`../../../comparison/proof-audit/intermediate-quantifier-pair/README.md`](../../../comparison/proof-audit/intermediate-quantifier-pair/README.md).

## 6. Recursive heap updates with a weak helper summary

**Program.** A recursive helper increments a cell initially containing 3,
three times. Its exact return is 6. Replace the helper's precise postcondition
by an existential final value bounded below by the starting value; keep the
helper body and caller's exact contract fixed.

**Existing comparison.** In the archived probe, teSpec and Fulminate execute the
body and preserve the exact result. Modular CN verification and the unmodified
QCP verifier leave the stronger caller goal unresolved when given the weak
summary. This is one program with two contract configurations. A weak summary
is not inherently false and is not counted as a negative mutation.

**Relation to VERINA/COINS.** A trusted pair `(3,6)` is enough for a pure relation
check, but it omits aliasing, ownership and the writes supplying 6. A meaningful
shared stateful task must encode the initial/final heap and frame, plus the
recursive transition. teSpec and Fulminate already have execution connections;
Lean/Rocq can express the required model when explicitly supplied. This case
tests the dependence of an instance result on a modular summary.

**Evidence:** [`../../../comparison/paired/recursive_heap_weak/case.qcp.c`](../../../comparison/paired/recursive_heap_weak/case.qcp.c),
`paper/sections/evaluation.tex`, archived paired reports.

## 7. Fulminate's industrial pKVM buddy allocator

**Production origin.** Use the allocator from Fulminate's original case study,
revision `66afeefe9556bc32b8b027d5b7f62bc3a7069703`, rather than the distinct newer
hyp allocator. This is one subject; different client traces are inputs.
The paper witness initializes eight 4096-byte pages, allocates two order-zero
blocks, then releases both.

**Original negative programs.** The artifact includes a pool-ownership guard
mutation, a missing `p=min(p,buddy)` coalescing update, and an incorrect extraction
postcondition that omits the extracted-page exception. The first and third
change specifications; the second changes executable behavior. All are retained
with original source hashes. Native32/native64 reject the missing-min mutation
on all 128 traces: its initialization post-state contains an unaligned or
out-of-pool free block. Read-only extraction-exit observations supply an original
spec-mutation witness in every trace, with 1,311 helper exits per ABI. A checked
Coq proof refutes a necessary previous-link clause of the unexcluded pool
postcondition: the extracted zero-refcount root has cleared links, while the
pool header and physical range are nonzero. For the ownership-guard mutation,
every initialization trace contains a subsumed page newly included by the
mutated guard. Its required list header overlaps its parent block's owned zero
region: 629 overlapping headers per ABI. A kernel-checked Coq proof refutes
this necessary separation condition. Matched contract-tool replay remains pending.

**Functional criteria beyond a return code.** Allocated blocks must be aligned,
contained, and disjoint; split/coalesce must preserve managed bytes; reference
counts and exhaustion/recovery must agree with an independent buddy model.
The 128 complete traces cover mixed orders, exhaustion, release and reallocation.
Both native ABIs pass the reference checks, including zeroed returned bytes,
metadata, free-list backlinks and final recovery. The oracle follows actual
legal allocation choices. Allocation-completeness checks are supplemental,
because the original allocation postcondition permits NULL.

**Fair comparison.** Fulminate's published industrial evaluation supplies the
direct execution baseline. The installed version currently requires a compatible
translation of the old annotations. VERINA/COINS need an explicit trace and heap
encoding for the same properties. teSpec still needs the full QCP translation
and paired contract-tool verdicts. The native-state witnesses and necessary-clause
proofs are separate evidence from complete generated-VC results.

**Evidence:** [`../industrial/pkvm-buddy/candidate.json`](../industrial/pkvm-buddy/candidate.json),
[native replay](../evidence/pkvm-native-20261013/receipt.json),
[extraction witnesses and proof](../evidence/pkvm-extraction-witness-20261013/receipt.json),
[ownership-guard witnesses and proof](../evidence/pkvm-ownership-witness-20261013/receipt.json),
[original artifact](https://github.com/rems-project/CN-pKVM-buddy-allocator-case-study).

## Additional shared-task candidates

Prioritize COINS HumanEval/31 primality, /96 bounded-prime enumeration, and /10
shortest palindrome. Their specifications contain, respectively, number-theoretic
classification, list soundness/completeness/order, and quantified minimality.
VERINA basic/28 and advanced/72 supply primality/factor tasks. These can extend
coverage beyond scalar equality, but must pass contract review and native C
safety checks before admission. A quantified formula may have an efficient
finite equivalent; always include that control when available.

## Sources and reproducibility

- [Fulminate paper](https://www.cl.cam.ac.uk/~pes20/cn-testing-popl2025.pdf),
  original C instrumentation and industrial case study.
- [VERINA paper](https://arxiv.org/pdf/2505.23135),
  [pinned metric implementation](https://github.com/sunblaze-ucb/verina/blob/66b3ce5014edafb20cb26b87c681e7f31847249f/src/verina/benchmark/metrics.py).
- [COINS paper](https://arxiv.org/html/2608.13077v1),
  [pinned negative driver](https://github.com/taylor-swift-13/Coins/blob/134339cd7a419dfd6a42a0d36ed88f8fd5bbdd41/src/negative_proof.py).

`comparison-sources.json` records exact revisions and file hashes. The two new
math cases retain reports, original goals, proof receipts and compressed kernel
logs. Fresh proof construction, full agent throughput and a matched VERINA/COINS
run are separate unfinished measurements.
