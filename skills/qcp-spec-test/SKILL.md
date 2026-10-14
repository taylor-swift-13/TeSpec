---
name: qcp-spec-test
description: Test QCP-annotated C programs with partial logical instances, execute loops and calls symbolically, and optionally complete unresolved verification conditions through one proof Agent and an independent certificate controller.
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
3. Select the checking policy:
   - `entry-exit`: execute actual loops and available callee bodies, checking
     safety and the final postcondition.
   - `all-boundaries`: execute the same bodies and iterations, also checking visited
     assertions, invariants and nested call contracts. This compatibility name
     selects checking boundaries, not modular execution.
   Checks observe copies of the current state; no tested annotation replaces
   the state. Callee arguments come from the caller, shared writes return to
   the caller, and no separate callee bind file is needed.
4. Execute all binds:

   ```bash
   python3 -m spectest run SOURCE --function FUNCTION --binds BINDS \
     --execution-mode all-boundaries --output-dir OUTPUT
   ```

   A reached declaration-only call cannot replace body execution with its
   contract. A declaration-only test target supports an explicitly labelled
   Require-only test. Missing bodies, loop/call limits and unresolved symbolic
   operations remain UNKNOWN or ERROR as reported. Increase budgets only when
   justified by the intended input; do not weaken a contract to obtain PASS.

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

Use **one proof Agent for all returned candidate files**. Its task is to fill
`Candidate.v`, optionally compiling drafts for feedback. The controller calls
`check-run-certificates` with its held digest; the proof Agent does not assign
verdicts or invoke final acceptance on its own authority. The controller may
return diagnostics to the same Agent for repair within the requested budget.
No separate coordinating Agent is needed when a deterministic runner owns the
process. Never recursively invoke the runner from the proof Agent.

For initial satisfiability and negative results, read
[Require checks](references/precondition-check.md). Failed proof search is not
UNSAT. A checked proof of an original execution VC's negation establishes
INVALID and makes the test FAIL. Agent judgement is not a certificate.

## Results and resources

Report per-case bindings, scope, status and artifact path. Distinguish:

- automatic QCP/SMT acceptance, relative to the executor/solver trusted base;
- complete VC certificates accepted by independent replay and assumption audit;
- FAIL with an UNSAT entry condition;
- FAIL with an INVALID original VC;
- UNKNOWN and tool errors.

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
`scripts/run-agent.sh AUTO-REPORT.json`. It runs one proof process only when
preparation yields eligible tasks and performs final checking in its external
controller. Preserve the caller's model configuration.
