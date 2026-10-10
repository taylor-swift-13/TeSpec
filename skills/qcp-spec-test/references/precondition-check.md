# Require satisfiability workflow

Use this flow when testing whether a QCP `Require` is satisfiable without
executing the function body. Keep the test's logical bindings explicit; a
pointer may stay symbolic when only its identity/alias constraints matter.

## Automatic stage

1. Run the symexec precondition checker with the selected source, function,
   spec, and logical bindings. SMT `SAT` and `UNSAT` are final automatic
   results. Preserve `UNKNOWN` for the proof stage; SMT unknown is neither
   satisfiability nor contradiction.
2. If Agent/ITP mode is enabled, create two isolated VC candidates for each
   `UNKNOWN`, both for the same instantiated `Require`:
   - SAT candidate: prove the generated positive satisfiability proposition.
   - UNSAT candidate: rerun with `--precondition-proof-negation` and prove
     the generated negated satisfiability proposition.
3. This automatic stage always runs, whether or not Agent proof work is
   enabled. Do not skip instantiation or SMT when Agent mode is off. With Agent
   mode disabled, return automatic `SAT`/`UNSAT` results as usual and leave
   only unresolved SMT `UNKNOWN` cases as `UNKNOWN`; candidate VCs are not
   needed in that mode.
4. In Agent/ITP mode, do not turn either candidate's failed or incomplete
   proof into a result.

The generated candidate directories and manifests must be separate so each
proof has its own immutable goal and `proof_manual` file. Use the existing
symexec/QCP VC generation and prepare each manifest from the generated files:

```bash
python3 -m spectest prepare-proof PATH/TO/CANDIDATE \
  PATH/TO/CANDIDATE/GENERATED.c PATH/TO/ORIGINAL.c \
  --function FUNCTION --case-id CASE_ID
```

Add `--qcip-root` only when using a non-bundled QCP tree, and
`--dependency-source` when the generated C source does not carry the original
Coq imports. The manifest preparer pins generated goals and stages their
dependencies. Do not reconstruct the assertion or omit definitions imported
by the VC.

## Single-Agent ITP stage

The automatic stage must finish first and emit all candidate VC manifests. If
its ITP VC inventory is empty, skip the Agent flow. Otherwise start one Agent
for the complete proof stage. That Agent handles every SAT and UNSAT candidate
in the inventory, edits each candidate's `proof_manual` file, and runs the
fixed checker. Do not create a separate proof sub-agent or delegate checker
calls.

For full program spec tests, select `expand` or `no-expand` before the
automatic stage. Expand mode unrolls loops and executes available function
bodies, simplifying states during execution. No-expand mode follows ordinary
QCP symbolic execution with instantiated formulas, invariant and contract VCs,
and continuous expression simplification. The report's `vc_policy` records
which path produced its proof queue.

After filling a candidate proof, the Agent invokes the fixed checker:

```bash
python3 -m spectest check-proof PATH/TO/CANDIDATE/manifest.json
```

Use only successful checker reports to classify:

- SAT proof passes, UNSAT proof does not: `SAT`.
- UNSAT proof passes, SAT proof does not: `UNSAT`.
- Neither passes: `UNKNOWN`.
- Both pass: report an inconsistent proof result and keep the case unresolved;
  do not choose one outcome.

A proof error, timeout, or rejected proof is simply a failed candidate. The
Agent may revise the proof and rerun the checker. Proof files remain manual
artifacts even when checked successfully. The deterministic symexec and
`spectest` layers never launch an Agent. Agent mode adds ITP only for cases
left UNKNOWN after that same automatic flow; it does not replace automatic
checking.
