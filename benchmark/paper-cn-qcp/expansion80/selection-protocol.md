# Selection and evaluation of the final 80 subjects

Historical protocol for this frozen batch. The current
[selection policy](../../selection/README.md) supersedes the fixed total and
candidate-replacement rules below: all pinned CN/Fulminate examples are mandatory;
QCP/CAV additions are selected by category and experiment question. Existing
inputs, outcomes and proofs retain their original identities.

The final collection must contain 80 executable subjects with reviewed CN/QCP
contracts and shared logical inputs. Count distinct program subjects, not
seeds, mutant versions, functions extracted without context, or client traces.
The industrial buddy allocator is one subject with multiple operation traces.
The current expressibility study cannot enter the paired denominator until a
corresponding executable CN contract exists; otherwise replace its paired slot
and retain the study separately.

## Capability coverage

| Capability | Required subjects and obligations | Evidence of a benefit |
|---|---|---|
| Ownership and heap structure | Lists, trees, queues, aliasing, disjoint regions and iterated ownership | Correct checks of ownership transfer; malformed ownership mutants are detected |
| Loops, recursion and calls | Shape and value invariants, recursive predicates, weak and strong callee contracts | End-to-end outcomes include intermediate and callee obligations |
| Arithmetic and logical definitions | Alignment, nonlinear relations, inductive definitions and quantified properties | An ATP UNKNOWN becomes VALID or INVALID through a checked ITP proof |
| Preconditions | Satisfiable, inconsistent and undecided entry conditions | No PASS from an infeasible input; input rejection is reported separately from an implementation counterexample |
| Industrial integration | Original pKVM buddy allocator with initialization, splitting, allocation, reference counts, release and coalescing | Complete operation traces and original spec/impl bug witnesses with aligned ownership contracts |
| Routine controls | Scalar branches and simple arrays handled by ATP and both baseline tools | Establish common coverage, correctness and normal-path overhead |

The existing pool has many scalar and array cases and few recursive structures.
Replace redundant easy candidates with distinct upstream structural subjects.
For the final pool, at least 32 subjects must exercise structural ownership,
recursion, cross-function contracts, or industrial lifecycle obligations. At
least 16 must contain reviewed candidate obligations involving inductive,
quantified or nonlinear properties. Tags may overlap. These are selection
requirements; they do not predict an ATP failure or an ITP success.

Freeze source hashes, aligned contracts, seeds, budgets and mutants before the
comparison. Preserve failures and UNKNOWN outcomes when updating the tool.
Selection is based on semantic features and source provenance. Record any
replacement and its reason in the catalog.

## Positive inputs

Prepare at least 128 distinct admitted logical inputs or operation traces per
subject where its domain has that many states. For smaller finite domains,
enumerate the complete domain and report the actual count. Parameterless
programs and tiny finite domains must not be padded with duplicated seeds.
Include boundaries, small exhaustive cases and deterministic random cases;
reserve independently generated seeds for the final evaluation.

Check preconditions independently, including ownership, arithmetic ranges,
termination assumptions and each operation in stateful traces. Represent the
same logical values and heap shapes in both tools, recording any ABI mapping.
Use a separate native functional oracle; the CN baseline uses its generated
contract checks. An invalid input is not a negative implementation test.

## Negative inputs

Provide both spec mutations and implementation mutations for each subject,
with witnesses and expected violated obligations. For spec mutations preserve
the C body; for implementation mutations preserve the contract and use the
same mutant C body on both sides. Keep upstream bug witnesses where available.
Do not count compile failures, equivalent mutants or nonviolating executions
as confirmed negatives. Record a witness for each admitted negative and retain
mutation survivors in the report.

Correct reference inputs require PASS. Confirmed negative witnesses require
FAIL for the strong criterion; UNKNOWN is accepted only by the separately
reported weak criterion. A false PASS on a confirmed negative is an error.

## Demonstrating ATP and ITP contributions

Run the same frozen cases with ATP alone and ATP followed by ITP, using the
same limits. Record the original VC, ATP outcome, proof direction and kernel
check. ITP proves the VC for VALID or its negation for INVALID; an Agent's
judgement and an unproved statement are not verdict evidence. If neither
direction is proved, the obligation remains UNKNOWN.

For entry conditions report SAT/UNSAT/UNKNOWN; for other VCs report
VALID/INVALID/UNKNOWN. Aggregate to PASS/FAIL/UNKNOWN with FAIL dominating
UNKNOWN when any checked failure exists. Preserve execution errors separately
and never treat them as semantic refutations.

Report per source family and capability: reference PASS rate, spec-mutant and
impl-mutant FAIL rates, survivors, UNKNOWN, errors, false PASS, runtime and
checked proofs. Report how many ATP-UNKNOWN obligations ITP resolves in each
direction. Keep baseline unsupported cases visible with concrete reasons;
report comparable-subset results and complete-pool coverage separately.

## Current admission status

The active catalog has 80 subjects. Only the 15 existing pairs carry replayed
paired inputs. The new pairs require semantic review and expanded input suites.
The pKVM source and its original mutants are frozen; QCP translation, shared
inputs, independent lifecycle oracle and paired execution remain pending.
No final 80-subject result or demonstrated capability advantage is claimed.
