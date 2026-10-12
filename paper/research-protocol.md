# Proof-backed specification instance testing: study protocol

Status: active study; baseline installation, original allocator inventory/control probes and exploratory proof replay complete; matched coverage, controlled performance and agent experiments pending. This protocol
was recorded before executing the comparative benchmark. Existing executor regressions
are development evidence and are reported separately from comparative measurements.

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

Strict inclusion requires an explicit source/target fragment, a semantics-preserving
embedding, and a separating example with a checked proof. Success on selected
examples establishes empirical coverage, not a language-inclusion theorem.
The primary empirical comparison is restricted to Fulminate and the baseline
engines in the associated Code-Specify-Test-Debug-Prove study: Bennet and Darcy.
CN universal verification is contextual evidence from the same toolchain. QCP
is the executor foundation and a source of external subjects, rather than an
additional main comparison tool. VERINA, COINS and SpecRL remain related work.

## Questions and measurements

| Question | Experiment | Primary measurements |
|---|---|---|
| RQ1: Can original proof-oriented contracts be tested? | Matched tests plus expressive extension cases | Supported assertions, completed instances, checked proofs, remaining goals |
| RQ2: Are results reliable and useful for debugging? | Independently labelled valid/invalid inputs, specification and program mutations | False acceptance/rejection, confirmed violations, inconclusive results, mutant detection |
| RQ3: What contributes to success? | Normalization, SMT-only, SMT+ITP, boundary policy ablations | Paired verdict changes, residual VC count/size, proof success |
| RQ4: What does checking cost? | Repeated isolated runs and repeated proof-agent attempts | Generation/check/execution time, CPU, peak RSS, tokens, proof attempts |
| RQ5: How does testing relate to full verification? | CN verification as context and TeSpec execution/proof evidence on matched instances | Checked domain, preserved boundaries, proof effort, unresolved obligations |

## Baselines and version policy

- **Fulminate POPL 2025:** paper and archived artifact define the original method.
- **CN/Fulminate/Darcy PLDI 2026:** use the released artifact at
  https://zenodo.org/records/19577402 to reproduce its original experiments.
- **Current CN:** pin `181d04773807012bcb937aa28d7e67de4cd5c488`
  (2026-10-07), including its pinned Cerberus dependency. Run `cn verify`,
  `cn instrument`, and applicable `cn test` engines separately. This prevents
  attributing an old implementation limitation to the current baseline.
- **QCP foundation:** record the upstream revision, SMT submodule, executable
  hash, strategy library, Coq version and options as dependency provenance.
  Earlier QCP comparison probes remain supplementary development evidence.
- **TeSpec:** record controller revision plus dirty diff, executable SHA-256,
  binary build manifest, runtime hashes, mode and all budgets.

Install CN outside teSpec in a dedicated opam switch. Published teSpec contains
binary interfaces and logical runtime dependencies, never sac implementation
sources. Capture all build logs and export the complete opam dependency lock.

## Focused comparison update (2026-10-11)

The POPL 2025 Fulminate evaluation uses instrumented/uninstrumented execution
for overhead measurements. The subsequent user-provided PLDI 2026 paper
compares Darcy with Bennet. The comparison therefore keeps the three runtime
configurations separate: Fulminate with supplied native fixtures, Bennet plus
its Fulminate oracle, and Darcy plus its Fulminate oracle. Native execution
is the overhead control, not a logical-specification baseline.

Additional subjects are selected for proof-oriented formulas and symbolic
heap inputs before measuring tool outcomes. The candidate inventory is
`benchmark/comparison/extension-candidates-20261011/inventory.json`. Each
candidate must complete TeSpec execution, establish initial satisfiability,
and pass whole-run certificate checking before being presented as a TeSpec
success. An original formula rejected by instrumentation is compared with
a justified executable rewrite when available; rewrite success is reported.
Recursive heaps alone are not a separating feature: both CN and Bennet
already support lists and balanced trees.

QuickCheck and QuickChick are discussed in related work. Their generator and
checker interfaces do not directly implement the C symbolic-heap task evaluated
here. They are not added as experimental baselines; a missing adapter is not
counted as a tool failure. The main direct comparison remains Fulminate,
Bennet and Darcy.

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
