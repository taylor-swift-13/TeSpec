# Proof-backed specification instance testing: study protocol

Status: ICSE comparison design revised on 2026-10-16. The current task is
paper development; new comparative runs are not claimed here. Existing probes
and proof replays remain historical evidence. The design below selects the
comparisons needed to test the method's contribution.

## Research question and semantic object

A test supplies a typed partial substitution θ for the logical inputs of a C
contract `{R} c {E}`. The input denotes the entire set `⟦R[θ]⟧`, including symbolic
addresses and unbound data. The test establishes nonemptiness of this set and
checks the selected obligations for its program behaviors. Native execution and
a runtime interpretation of every specification predicate are unnecessary.

The study distinguishes three claims:

1. **Logical expressiveness:** which original assertions can be retained in a
   well-formed residual proof obligation without replacing them by a monitor?
2. **Implemented program coverage:** which C constructs and heap operations can
   each released tool process under its documented memory model?
3. **Practical checking power:** which matched instances receive justified
   success or violation results within the same resource budget?

## Baseline selection for ICSE (2026-10-16)

The comparison should answer three questions: what is gained over runtime
checking, what is gained over simply specializing an existing verifier, and
what is gained over proving the specification directly on supplied examples.
An independent symbolic-execution baseline adds evidence beyond the QCP family.

| Comparison | Priority and role | Scientific question | Initial scope |
|---|---|---|---|
| Fulminate | Required external testing baseline; already established | Which original contracts can be checked, and at what cost, compared with runtime specification checks? | Matched C bodies, CN/QCP contracts and fixed inputs in the shared fragment; report original formulas and justified executable rewrites separately |
| QCP-theta | Required same-foundation mechanism control; first addition | Is TeSpec more than adding input equalities to QCP's precondition? | Identical root binding, program and contracts, with native QCP call/loop handling and a matched proof budget |
| COINS | Required proof-oracle comparison on shared pure relations | How much can direct example-based proof checking already establish, and what does execution-derived checking add? | Pure input/output relations, including quantified properties; use the original framework and the same model/proof budget |
| Gillian-C symbolic testing | Strongly recommended independent execution baseline | How does TeSpec compare with another symbolic heap analysis, rather than only its own verification foundation? | A feature-selected common subset covering arrays, pointer aliases, lists and calls; expand after the adapter is working |
| CN and QCP full verification | Retained reference layer | What assurance and cost does universal verification provide for the correct primary program? | One primary program per group; reuse matching validated evidence |

### QCP-theta: the essential specialization control

For root precondition R and a TeSpec binding theta, create the native QCP input
with root precondition R and theta. Preserve the original implementation,
callee contracts, loop invariants, logical definitions and QCP verification
algorithm. Root equalities apply to entry values: recursive invocations retain
fresh logical parameters. Do not add TeSpec's body-execution policy or copied-state
observation machinery to this baseline.

Run both systems with the same proof model (gpt-6.1-sol), libraries, retry policy
and total proof budget. Measure complete outcomes, residual obligations, proof
construction, checking, tokens and peak RSS. Choose mechanism examples before
measuring: straight-line code, loops, weak but valid callee summaries, recursion,
and internal assertions. Straight-line agreement provides a useful control;
weak-summary and loop cases test whether the execution discipline changes the
obligations. This is separate from universal QCP verification of each primary.

### COINS: compare the shared oracle task

Use the same mathematical relation, concrete input/output pairs and proof budget
in COINS and in TeSpec's oracle comparison. Begin with powers, divisibility,
least-root and list relations where matching definitions can be reviewed.
Record oracle proof cost separately from TeSpec's C execution and safety checks.
This directly tests the proof-oracle contribution while the complete TeSpec run
measures the additional execution-derived obligations.

A later adapter that supplies pre/post heap snapshots is a separate
COINS-style direct-instance-proof control, not native COINS. It is not required
for the first comparison. Retain the baseline's original outcomes; compare
checked acceptance and checked rejection as separate measurements.

### Gillian-C: independent symbolic execution

Use the documented whole-program symbolic-testing interface, with the same C
body and a harness encoding the shared input constraints and assertions.
Gillian-C provides symbolic values and ASSUME/ASSERT; its artifact documents
wpst and bulk-wpst. Pin the implementation before measuring. Select a small
subset by program features, then record the assertions each translation covers.
Explicit separation-logic ownership checks require a reviewed adapter; an
ordinary value ASSERT alone does not implement them.

### Required component ablations

| TeSpec configuration | spatial-SMT | ITP completion |
|---|---|---|
| Native | Off | Off |
| SMT | On | Off |
| ITP | Off | On |
| Full | On | On |

Keep inputs, observation schedule and proof budget fixed. Report decided tests,
UNKNOWN-to-decision transitions, wrong decisions, residual VC counts, ITP calls
avoided, and complete per-test costs. One ITP unit contains all pending VCs of
one test execution. Include retries and proof checking; retain the existing
mean-per-execution reporting convention and individual peak-RSS measurements.
QCP-theta isolates execution/obligation construction; this matrix isolates the
two completion mechanisms.

### Comparisons not added to the main table

Bennet and Darcy generate inputs and use Fulminate as the runtime oracle. For
fixed-input checking, they do not create two additional independent oracle
baselines. If the paper later studies automatic input discovery under a time
budget, add Darcy + Fulminate as a complete pipeline. QuickChick, Infer/Pulse,
CBMC and proof-search systems belong in related work for the present scope.
A CBMC experiment becomes useful if general bounded C bug-finding becomes a
central empirical claim; it is not needed merely to increase baseline count.

### Primary sources for this decision

- [QCP: verification architecture](https://arxiv.org/abs/2505.12878)
- [COINS: paper and software link](https://proceedings.mlr.press/v306/yang26am.html)
- [COINS: released implementation](https://github.com/taylor-swift-13/Coins)
- [Gillian-C: symbolic testing interface](https://gillianplatform.github.io/instantiations/c/symbolic-testing.html)
- [Gillian-C: reproducible whole-program testing commands](https://gillianplatform.github.io/instantiations/c/pldi20-artifact.html)
- [Fulminate: original paper](https://www.cs.ox.ac.uk/people/christopher.pulte/2024-cn-testing-paper.pdf)
- [Code-Specify-Test-Debug-Prove: Fulminate extensions and Darcy](https://www.cl.cam.ac.uk/~pes20/pldi2026-paper155-supplementary.pdf)

## Questions and measurements

| Question | Experiment | Primary measurements |
|---|---|---|
| RQ1: Can original proof-oriented contracts be tested? | Matched tests plus expressive extension cases | Supported assertions, completed instances, checked proofs, remaining goals |
| RQ2: Are results reliable and useful for debugging? | Independently labelled valid/invalid inputs, specification and program mutations | False acceptance/rejection, confirmed violations, inconclusive results, mutant detection |
| RQ3: What contributes to success? | Normalization, SMT-only, SMT+ITP, boundary policy ablations | Paired verdict changes, residual VC count/size, proof success |
| RQ4: What does checking cost? | Repeated isolated runs and repeated proof-agent attempts | Generation/check/execution time, CPU, peak RSS, tokens, proof attempts |
| RQ5: How does testing relate to full verification? | CN/QCP primary verification as context; QCP-theta and TeSpec on matched instances | Checked domain, preserved boundaries, proof effort, unresolved obligations |

## Baselines and version policy

- **Fulminate POPL 2025:** paper and archived artifact define the original method.
- **CN/Fulminate/Darcy PLDI 2026:** use the released artifact at
  https://zenodo.org/records/19577402 to reproduce its original experiments.
- **Current CN:** pin `181d04773807012bcb937aa28d7e67de4cd5c488`
  (2026-10-07), including its pinned Cerberus dependency. Run `cn verify`,
  `cn instrument`, and applicable `cn test` engines separately. This prevents
  attributing an old implementation limitation to the current baseline.
- **QCP foundation and QCP-theta control:** record the upstream revision, SMT
  submodule, executable hash, strategy library, Coq version and options. Pin
  native QCP separately from the TeSpec executor. Earlier comparison probes
  remain historical evidence until reproduced under the matched-input protocol.
- **COINS and Gillian-C:** pin repository revision, dependencies, adapter sources
  and commands before new measurements. Baseline selection is complete; this
  document does not claim either new comparison has been executed.
- **TeSpec:** record controller revision plus dirty diff, executable SHA-256,
  binary build manifest, runtime hashes, mode and all budgets.

Install CN outside teSpec in a dedicated opam switch. Published teSpec contains
binary interfaces and logical runtime dependencies, never sac implementation
sources. Capture all build logs and export the complete opam dependency lock.

## Historical comparison scope (2026-10-11)

The earlier design focused on Fulminate with native fixtures, Bennet + Fulminate,
and Darcy + Fulminate, with QCP only as implementation provenance and COINS only
as related work. The 2026-10-16 selection above supersedes that restriction.
Original runs keep their recorded scope and outcomes. Native execution remains
an overhead control, and input discovery remains separate from checking a given
input. No historical result is relabelled as a new baseline run.

## Subject selection

Keep three populations separate:

1. **Original subjects:** all runnable subjects in the selected Fulminate/Bennet/
   PLDI artifacts, including pKVM allocator cases and original specification bugs.
   Preserve original licences, hashes, test counts, seeds and exclusions.
2. **QCP corpus:** inventory every example and target contract before filtering.
   Publish unsupported syntax, missing dependencies, missing bodies, invalid
   bindings, timeout and unclosed-proof outcomes. Choose typed bindings from
   contracts and explicit feature coverage; synthetic input scans have no
   correctness oracle unless independently labelled.
3. **Paired and separating subjects:** use identical C bodies in the common
   language subset, with reviewed equivalent CN and QCP contracts. Cover scalars,
   arrays, nested structures, pointer cells, aliases, lists, trees, sharing,
   allocation, recursion, loops and modular calls. Add quantified, abstract and
   non-computational logical specifications as a separate extension stratum.

Existing 1,322 E2E expectations remain a development regression suite. Its
UNKNOWN results on deliberate wrong postconditions are not confirmed bugs.
Do not select final subjects by whether TeSpec succeeds. Preserve subjects that
favor CN or Fulminate and report per-feature denominators.

## Matched-input and oracle policy

For common-fragment comparisons, C bodies agree after removing annotations;
contracts are checked for matching integer width, overflow conditions,
ownership, aliasing, allocation lifetime and footprint. Architecture-sensitive
programs require matching models or a recorded exclusion from paired timing.
TeSpec currently models a 32-bit architecture while the host is x86-64.

A TeSpec symbolic-pointer instance can cover many concrete heaps. Fulminate is
run on explicitly recorded representatives of that class. Report both the
concrete input count and symbolic domain; never equate one native run to a
universal result over the class. Compare discovery separately from checking a
given input so input generators do not confound the oracle comparison.

Ground truth is established by independent computations for finite functional
cases, native executions only on defined C behavior, and checked logical proofs
for abstract properties. A failed proof is inconclusive. An UNSAT Require means
invalid test input; a verified negation of an execution VC is a violation only
when a reachable counterexample is established. Mutation operators and
equivalence handling are fixed before measuring detection rates.

## Evidence and verdicts

Retain phase verdicts (Require, safety, completion, postcondition, boundaries),
scope, exact commands, stdout/stderr, exit/signal, timeout, source/spec/input
hashes, VC inventory, dependencies and proof-check results. Distinguish:

- automatic results relative to the executor/SMT trusted base;
- kernel-checked residual proofs with their printed assumptions;
- whole-instance certificates, only when all required obligations are covered;
- remaining obligations and incomplete execution.

`Admitted`, new axioms, changed goal statements and unchecked auto-proof stubs
cannot close a certificate. Audit imports and transitive assumptions against an
explicit fixed runtime trust list. A proof agent writes proofs; a deterministic
external checker hashes goals and dependencies and assigns results. All failures
and unsuccessful proof attempts remain in the dataset.

## Resources and statistics

Use a declared CPU/RAM/OS, compiler, SMT and Coq configuration. Measure compilation,
VC generation, automatic checking, agent generation and proof replay separately,
plus total cold-start and amortized checking costs. Do not reuse concurrent
development runs as performance data. Report peak RSS with measurement scope;
sum neither unrelated peaks nor per-thread resource counters.

Run deterministic timing experiments at least 10 times after one labelled
warm-up; report median, IQR and raw observations. Randomized testing and agent
proofs use recorded independent seeds/attempt identifiers and common fixed
budgets. Report success curves and confidence intervals; retain censored
timeouts. Agent records include model/version, configuration, prompt, tool
transcript, tokens (including cached/reasoning fields when exposed), wall time,
checker time and any billed cost with price provenance. Unavailable usage is
`null`, never zero. Paired comparisons use matched subjects; per-family results
accompany pooled statistics.

## Formal deliverables

1. Typed, capture-avoiding partial instantiation and its interpretation.
2. Nonvacuous satisfaction and violation judgments; existential initial
   satisfiability separated from universal execution correctness.
3. Observation-preserving simplification for assertions jointly with return
   values, expression continuations and frame references.
4. Symbolic coverage and VC soundness, including every feasible branch.
5. Actual-call semantics: fresh frames, alias preservation, C evaluation order,
   recursion, local lifetime, typed returns and shared writes.
6. Actual-loop semantics and state-preserving annotation boundaries; explicit
   treatment of budgets, partial correctness and termination evidence.
7. A proof-completion interface whose accepted results follow from checked VCs.
8. A precisely scoped expressiveness comparison and demonstrated separating
   cases, consistent with baseline extensions and Rocq support.

Mechanized generic theorems are labelled separately from the C implementation
refinement obligation. They must list their hypotheses; proving the abstract
controller theorem does not prove the QCP executor implementation.

## Completion gates

| Deliverable | Completion evidence | Current state |
|---|---|---|
| CN environment | Pinned build, version output, passing valid and rejecting invalid smoke tests | Current CN verify/Fulminate and April snapshot Bennet/Darcy smoke complete; exact archived environment pending |
| Fulminate baseline | Original and paired experiments with raw data | Pending |
| QCP/CN comparison | Reviewed feature matrix, same-task executions | Five paired heap cases exercised; unmodified QCP baseline and loop annotation refinement recorded; full coverage and matched timing pending |
| TeSpec proof workflow | Actual residual proofs, external replay, assumption audit, usage reports | Complete four-VC cell, three-VC imported-relation and 44-VC intermediate-boundary groups replayed; paired negative return VC refuted with other obligations proved. Reachable-counterexample certificates, controlled proof trials and usage instrumentation pending |
| Formal theory | Stated definitions/theorems, mechanized core and implementation correspondence | Generic core checked by coqc/coqchk; C correspondence pending |
| Experiment dataset | Full inventory, raw results, exclusions, analysis scripts | Pending |
| ICSE paper draft | Consistent manuscript, tables generated from data, compiled PDF | Existing draft needs revision |
| Reproduction package | Fresh-environment replay of published commands | TeSpec binary-only regression verified |

The study completes only when all gates have evidence. Empirical findings determine
the final claims about superiority, expressiveness and cost.
