# Residual VC proof workflow

## Trust boundary

The manifest lists four Coq files:

- `goal`: immutable definitions of all generated VCs;
- `proof_auto`: immutable QCP-accepted automatic obligations;
- `proof_manual`: the only editable target;
- `goal_check`: immutable module-level completeness check.

The boundary is provenance-based:

- `qcp_auto` is QCP/SMT output in `proof_auto`;
- `manual` is any proof written into `proof_manual` by a model or human.

`spectest check-proof` verifies hashes for the immutable generated files,
rejects proof escapes in `proof_manual`, and compiles the complete proof with
Coq 8.20.1. The core runner has no secondary Coq automation and never edits
`proof_manual`. CoqGym is not required.

## Proof loop

1. Read `manifest.json`, the referenced goal definitions, and
   `proof_manual.v`.
2. Search the official QCP proof examples for the same VC/tactic shape:

   - `$SPEC_TEST_ROOT/runtime/qcip/SeparationLogic/examples/QCP_demos_LLM`
   - `$SPEC_TEST_ROOT/runtime/qcip/SeparationLogic/examples/QCP_demos_human`
   - `$SPEC_TEST_ROOT/runtime/qcip/SeparationLogic/examples/Applications_human`
   - `$SPEC_TEST_ROOT/runtime/qcip/SeparationLogic/examples/LLM_bench`

   Search by suffix such as `return_wit`, `entail_wit`, `safety_wit`,
   `split_goal`, and by predicates appearing in the goal.
3. Replace each generated `Abort`/`Admitted` hole in `proof_manual.v` with a
   proof ending in `Qed`.
4. Run `python3 -m spectest check-proof MANIFEST`.
5. Read the first Coq error from `proof_check.stderr.txt`, change only the
   manual proof, and repeat.

Common starting tactics in QCP examples include `pre_process`,
`aggressive_pre_process`, `entailer!`, `Intros`, `Exists`, `Left`, `Right`,
`sep_apply`, `rewrite`, and `lia`. Use them only when they match the actual
goal; compile immediately instead of guessing a long script.

## Non-negotiable rules

- Do not modify the implementation or weaken `Require`/`Ensure`.
- Do not modify generated theorem statements or immutable files.
- Do not introduce `Admitted`, `admit`, `Abort`, `Axiom`, `Parameter`,
  `Hypothesis`, or `Conjecture`.
- Do not treat one failed tactic or a Coq timeout as evidence that the VC is
  false.
- If the VC is actually false, preserve the case as unresolved and explain
  the concrete contradiction; do not forge a proof.
