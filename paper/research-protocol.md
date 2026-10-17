# Proof-backed specification instance testing: study protocol

Status: ICSE comparison design revised on 2026-10-16; mandatory CN/Fulminate
version policy updated on 2026-10-17. The current task is
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

The comparison should establish the benefits and costs of three routes:
runtime specification checking, direct example-based proof checking, and full
verification of the original contract. An independent symbolic-execution
baseline adds evidence beyond the QCP family.

| Comparison | Priority and role | Scientific question | Initial scope |
|---|---|---|---|
| Fulminate | Required external testing baseline; already established | Which original contracts can be checked, and at what cost, compared with runtime specification checks? | Matched C bodies, CN/QCP contracts and fixed inputs in the shared fragment; report original formulas and justified executable rewrites separately |
| COINS | Required proof-oracle comparison on shared pure relations | How much can direct example-based proof checking already establish, and what does execution-derived checking add? | Pure input/output relations, including quantified properties; use the original framework and the same model/proof budget |
| Gillian-C symbolic testing | Strongly recommended independent execution baseline | How does TeSpec compare with another symbolic heap analysis, rather than only its own verification foundation? | A feature-selected common subset covering arrays, pointer aliases, lists and calls; expand after the adapter is working |
| QCP full verification | Required verification comparison | How do instance testing and full verification differ in proof effort, cost and established scope? | Original precondition and contract; one correct primary program per group; reuse matching validated evidence |
| CN full verification | Retained independent verification reference | How does an external verifier perform on the paired primary contracts? | One correct primary program per group; retain existing paired CN evidence |

### Fulminate: separate runtime configurations and failure classes

Use the same latest-version build selected for CN verification, plus a
separately labelled configuration with undefined-behavior sanitization for
safety-sensitive cases. Retain recorded older builds only as historical evidence. Capture the actual
compiler invocation, optimization level, integer widths, sanitizer flags and
runtime diagnostics. Do not infer sanitizer coverage from the outer CN command.
The current read INT_MIN case establishes a missed signed-negation violation in
the recorded configuration; the sanitizer comparison has not yet been run.

Report a normal exit on an independently established violation separately from
unsupported instrumentation. Least-root and divisibility quantifier-bound
errors are support limitations, not false acceptances. Their proved finite-form
controls measure the effect of changing the assertion formulation. Retain
successful baseline cases and do not select the aggregate population by failure.

### QCP: compare directly with full verification

Run native QCP on each correct primary program and its original contract,
without adding test-input equalities. QCP's modular verification uses loop
invariants and callee summaries to establish the contract over its precondition
domain. TeSpec executes selected instances while observing those annotations.
These are the two workflows whose proof effort and cost we want to compare.

Adding input equalities to QCP would still perform modular verification.
Invariants and callee summaries can generalize intermediate states and lose
instance-specific correlations. Such a configuration is therefore omitted from
the testing baselines; the direct full-verification comparison is more useful.

Use the same proof model (gpt-6.1-sol), compatible proof libraries, retry policy
and declared proof budget. Separate VC generation and automatic reasoning,
agent proof construction, and proof checking; record time, tokens and peak RSS.
Report full verification once per primary program, alongside TeSpec's per-test
cost and the aggregate cost of that program's declared test suite. Associate
each result with its established domain: the original contract for QCP and the
selected input domains for TeSpec. Reuse existing verification evidence when
source, contract and dependency identities match. Program and specification
variants continue to receive tests; they do not require universal verification.

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
This matrix measures the contribution and cost of the two completion mechanisms.
Execution preservation is evaluated with the existing call, loop and internal-
observation cases.

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
| RQ5: How does testing relate to full verification? | QCP full verification and CN reference verification of original primary contracts; TeSpec on the declared test suites | Checked domain, preserved boundaries, proof effort, unresolved obligations |

## Baselines and version policy

**Mandatory for all subsequent experiments:** at the start of each experimental
batch, resolve the latest commit of the official CN default branch. Build CN
verification (`cn verify`) and Fulminate instrumentation (`cn instrument`) from
the same source revision and dependency environment. Freeze that build throughout
the batch. Resolve upstream again for a later batch; if the revision changes,
rerun the affected comparisons and controls before combining results. A saved
April or October build is not automatically the latest build for a future run.

- **Latest upstream observed on 2026-10-17:**
  `b4a2f009234d9c80380dbf95a9b2325e36a4705d`, committed 2026-10-13 UTC,
  on `rems-project/cn` `main`. The live `git ls-remote --symref` query and
  official commit API agreed. Its `cn.opam` pins Cerberus `c8c085d`, expanded to
  `c8c085d4714ae17095b2e1202fa33c5545d98df1`. This is a verified source selection;
  it has not been installed, smoke-tested, or used for new measurements here.
  The machine-readable record is
  [the version-policy receipt](evidence/cn-fulminate-version-policy-20261017.json).
- **Build acceptance before measurements:** archive the full CN and dependency
  commits, exported opam lock, clean-source status or complete explained build
  diff, version output, executable SHA-256, build log, solver/compiler versions,
  target layout, optimization/sanitizer flags, enabled ownership/leak checks,
  exact commands, and valid/invalid smoke-test receipts. An unexplained `dirty`
  suffix is insufficient provenance. A build or support failure is recorded;
  do not silently substitute an old baseline.
- **Historical results:** the read suite uses `39efc873fd3b1cd4cab1aecb401e88f61bc80b41`
  (2026-04-16), binary `1911ca79378e335eb7d14b47856b3397c3cbe247761d13c4d1f084980767ac2b`.
  Least-root and divisibility use `181d04773807012bcb937aa28d7e67de4cd5c488`
  (2026-10-07), binary `5be860152aa68727c2749bef403fe65f19d50fdbd29a07472e37ea7819c2c5f3`.
  Both recorded version strings carry `dirty`; raw receipts remain unchanged.
  Rerun the complete claimed case sets, including correct and equivalent-form
  controls, before reporting them as latest-version findings. In particular,
  read INT_MIN has not yet been confirmed on the new baseline.
- **Published Fulminate and PLDI artifacts:** retain them for historical
  reproduction only, separately labelled by release and configuration. They
  do not replace the latest upstream CN/Fulminate baseline in new experiments.
- **QCP full verification:** record the upstream revision, SMT submodule,
  executable hash, strategy library, Coq version and options. Pin native QCP
  separately from the TeSpec executor. Reuse matching primary-verification
  evidence and measure any missing stages under the current cost protocol.
- **COINS and Gillian-C:** pin repository revision, dependencies, adapter sources
  and commands before new measurements. The literature review informs the
  final common-feature selection; neither new comparison has been executed.
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
warm-up; use mean per-execution costs in the main result tables. Retain raw
observations and dispersion summaries for audit. Randomized testing and agent
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
| CN environment | Latest upstream revision, shared CN/Fulminate build, full provenance and valid/invalid smoke tests | Upstream b4a2f00923 identified on 2026-10-17; build, smoke tests and new measurements pending; older build checks are historical |
| Fulminate baseline | Original and paired experiments with raw data | Pending |
| QCP/CN comparison | Reviewed feature matrix, same-task executions | Five paired heap cases exercised; unmodified QCP baseline and loop annotation refinement recorded; full coverage and matched timing pending |
| TeSpec proof workflow | Actual residual proofs, external replay, assumption audit, usage reports | Complete four-VC cell, three-VC imported-relation and 44-VC intermediate-boundary groups replayed; paired negative return VC refuted with other obligations proved. Reachable-counterexample certificates, controlled proof trials and usage instrumentation pending |
| Formal theory | Stated definitions/theorems, mechanized core and implementation correspondence | Generic core checked by coqc/coqchk; C correspondence pending |
| Experiment dataset | Full inventory, raw results, exclusions, analysis scripts | Pending |
| ICSE paper draft | Method-led manuscript, formal interfaces, four recorded case studies, compiled and visually inspected PDF | Revised on 2026-10-16; broader comparative experiments remain pending |
| Reproduction package | Fresh-environment replay of published commands | TeSpec binary-only regression verified |

The study completes only when all gates have evidence. Empirical findings determine
the final claims about superiority, expressiveness and cost.
