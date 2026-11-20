---
name: qcp-spec-test
description: Test QCP-annotated C programs with partial logical instances, execute loops and calls symbolically, and optionally complete unresolved verification conditions through per-execution proof tasks and an independent certificate controller.
---

# QCP Spec Test

Run the deterministic test first. Agent assistance adds proof construction;
input semantics, execution, and verdict rules remain the same without an Agent.
Use the user-selected TeSpec worktree containing `spectest/`, `pyproject.toml`
and `bin/tespec-symexec`. Do not silently switch to another checkout.
Use its bundled `runtime/qcip` unless the task requires an explicitly selected
runtime. A 64-bit target requires both a matching executor build and logical
runtime; the packaged default is 32-bit.

## Inputs and execution

1. Identify the source, function, optional named specification, and binds.
   Preserve user-supplied inputs. For a separate specification, pass
   `--spec-file`; the deterministic tool assembles it with the implementation.
2. Run `python3 -m spectest analyze SOURCE --function FUNCTION --write-binds BINDS`.
   Add `--spec-file SPEC` when appropriate. Read
   [binding rules](references/binds.md) when constructing or interpreting binds.
   Bind logical contents to describe the input heap. Pointer C arguments may
   be omitted or explicitly symbolic; numeric addresses are optional test
   constraints, not prerequisites for heap ownership. Follow analysis metadata
   for required non-pointer arguments and logical variables.
3. Choose the execution strategy and VC coverage independently.
   The default `inline` strategy follows available bodies and loop iterations.
   `modular` uses contracts and loop invariants to carry the symbolic state.
   In either strategy a call with only a declaration uses its contract.
   `entry-exit` checks safety and the final postcondition.
   `all-boundaries` also checks visited annotations and call boundaries.
4. Execute all binds:

   ```bash
   python3 -m spectest run SOURCE --function FUNCTION --binds BINDS \
     --execution-mode all-boundaries --output-dir OUTPUT
   ```

   A declaration-only test target supports a Require-only test. Loop/call limits
   and unresolved symbolic operations retain the status reported by the executor. Increase
   budgets only when justified by the intended input.

Keep declared headers, strategies and Coq definitions with the case. Add `-I`
for required include roots. Coq dependencies can live under
`dependencies/coq/LOGICAL/MODULE.v` beside the source. Definition-driven
unfolding and simplification handle available definitions; opaque residual
predicates retain their logical meaning. Never invent a heap layout or add
case-specific reductions to the automatic layer.

## Optional proof stage

Finish the automatic stage for every bind before proof construction. Without
Agent assistance, report `OUTPUT/report.json` directly. With proof assistance,
read [certificate workflow](references/residual-vc.md) and prepare:

```bash
python3 -m spectest prepare-run-certificates OUTPUT/report.json \
  --output OUTPUT/proof
```

The external controller retains the returned manifest digest outside the proof
Agent's editable files. If `proof_required` is false, skip the Agent. Other
UNKNOWN cases can remain unresolved because they need execution or tool fixes.

Use the proof controller to replay eligible proof sources first. Start a proof
Agent for each execution that still needs a candidate. Its task is to fill
`Candidate.v`, optionally compiling drafts for feedback. The controller calls
`check-run-certificates` with its held digest; the proof Agent does not assign
verdicts or invoke final acceptance on its own authority. The controller may
return diagnostics to the same Agent for repair within the requested budget.
No separate coordinating Agent is needed when a deterministic runner owns the
process. Never recursively invoke the runner from the proof Agent.

For initial satisfiability and negative results, read
[Require checks](references/precondition-check.md). Failed proof search is not
UNSAT. A checked proof of an original execution VC's negation establishes
INVALID for that VC. An execution counterexample also requires evidence that
the failing state is reachable.

## Results and resources

Report per-case bindings, scope, status and artifact path. Distinguish:

- automatic QCP/SMT acceptance, relative to the executor/solver trusted base;
- independently checked certificates, with their exact goals or full interface;
- FAIL with an UNSAT entry condition;
- FAIL with an execution counterexample;
- CRASH with the confirmed program fault and its reason;
- UNKNOWN for unresolved permissions and ERROR for tool failures.

A successful partial instance establishes the checked properties for its
represented initial states, under the recorded execution semantics and proof
scope. It is not unrestricted verification of every input. Require-only
success does not claim that the function executed. Ignored annotations remain
NOT_RUN.

Retain automatic wall/CPU time and peak process RSS. For proof assistance,
record elapsed time, process resources, attempt outcomes, and token usage from
actual agent telemetry. Unavailable token counts and model identities are
`null` with an explanation; never estimate them. Keep automatic, agent and
certificate-checking costs separate. Record concurrency for comparative timing.

For explicitly requested unattended proof construction, use
`scripts/run-agent.sh AUTO-REPORT.json`. It replays matching proof sources, then
requests a candidate for each execution that still needs one. The default CLI requests `gpt-6.1-sol`.
The controller performs final checking.
