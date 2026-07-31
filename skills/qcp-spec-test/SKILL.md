---
name: qcp-spec-test
description: Test a QCP-annotated C function against fully concrete top-level C arguments and logical-variable bindings, including linked lists, arrays, heap predicates, function calls, and finite loops without invariants. Use when Codex needs to discover required C args or QCP With variables, create or consume human-written binds, run the deterministic qcp-spectest tool, diagnose FAIL/UNKNOWN results, or prove residual Coq VCs that QCP automation did not close.
---

# QCP Spec Test

Keep the framework deterministic. Use model reasoning only to choose binds and
to fill residual Coq proofs. Never add an LLM call to `spectest` itself.

Set `SPEC_TEST_ROOT` to `/home/yangfp/teSpec` when that directory exists.
Otherwise locate the directory containing `spectest/`, `pyproject.toml`, and
`bin/qcp-symexec`. Run all commands from that directory.
Use the bundled `runtime/qcip` by default. Do not refer to an external QCIP
checkout unless the user explicitly selected one or the requested source has
an external, source-local dependency that was not supplied with the source.
Keep domain-specific dependencies with the case, not in the shared runtime.
Keep every source-declared strategy beside that case's source/header, or add
its owning case directory explicitly with `qcp.include_dirs`. There is no
project-level `providers` fallback; never recreate one to make an otherwise
incomplete case pass.
Place Coq modules under
`cases/CASE/dependencies/coq/LOGICAL/MODULE.v`; the tool preserves their
logical module path while recursively staging direct and transitive imports.

## Workflow

1. Identify the source file, target function, and optional named spec.
   When implementation and spec are separate files, preserve them as separate
   immutable inputs. Never ask the model to create a C harness or splice the
   spec into the implementation; `--spec-file` performs that assembly
   deterministically.
2. Analyze the spec before inventing or editing binds:

   ```bash
   python3 -m spectest analyze IMPL.c \
     --spec-file SPEC.qcp \
     --function FUNCTION \
     --write-binds BINDS.json
   ```

   Omit `--spec-file` only when the C source already contains its full QCP
   spec. Use `--spec NAME` solely to select a named spec, not as a spec path.

3. Obtain binds:

   - If the user supplied a binds file or concrete values, preserve them.
     Do not silently replace or broaden human test cases.
   - If binds are absent, read [references/binds.md](references/binds.md) and
     create a JSON binds array using the analysis output and selected
     `Require`.
   - Bind every entry in `argument_bindings` exactly once in the case's
     `"args"` object. These are the target function's C inputs. Use concrete
     numeric addresses for pointers and preserve intended aliasing by reusing
     an address only when the test intentionally aliases.
   - Bind every value-level variable reported with `"required": true`
     exactly once in `"values"`. A `"binding_mode": "derived"` variable may
     normally be omitted because its `Require` equality determines it; supply
     it explicitly when semi-concrete execution must fix a branch or loop
     controller that would otherwise depend on a symbolic heap value.
   - A large heap value that is not inspected element-by-element may be
     explicitly supplied as `{"symbolic": true}`. Keep every scalar that
     controls a branch, finite loop, address, or function argument concrete.
   - A type-level `With {A}` may remain polymorphic. When the test needs a
     concrete instance, put it in that case's `"types"` object, for example
     `"types": {"A": "option Z"}`. Never place a type binding in `"values"`.
   - Every Coq/QCP value type is bindable. Prefer a JSON constructor tree for
     inductive data; use explicit `{"type": T, "qcp": term}` for any type the
     friendly encoder does not understand.

4. Run the implementation against the original spec:

   ```bash
   python3 -m spectest run IMPL.c \
     --spec-file SPEC.qcp \
     --function FUNCTION \
     [--spec SPEC] \
     --binds BINDS.json \
     --output-dir OUTPUT
   ```

   This command executes the implementation and checks the resulting state
   against the supplied spec. A successful C execution without a spec result
   is not a TeSpec test.

   Add `-I` when the source uses an external C/QCP header or a declared
   strategy file. Paths such as `QCP_examples/QCP_demos_LLM` are resolved
   relative to the bundled `runtime/qcip`. The concrete engine deliberately
   has no predicate-name or
   struct-layout special cases. It unfolds QCP `Let` separation definitions
   directly, recursively unifies existential constructor tails from closed
   bindings, and loads `include strategies` declarations from the source.
   Nested JSON arrays may bind nested Coq list types, so recursively composed
   predicates can describe an outer list whose nodes own inner lists, arrays,
   and closed structs without adding an engine layout rule.
   An `Extern Coq` predicate declaration alone has no executable heap
   semantics; locate its source-declared strategy rules or preserve the
   resulting UNKNOWN/error instead of guessing a layout. Use a loop limit
   large enough for each concrete input; increasing a finite bound is allowed.

   Do not invent `args` or `values` for callees. At each concrete function call the engine
   evaluates caller arguments, creates fresh callee parameter cells, carries
   the current heap into the callee, executes its body, and returns its value
   and heap. A callee body takes precedence over its spec; a spec is used only
   for a declaration with no available body.

   Closed `Zlength`, `Znth`, list-index terms, propositional connectives, and
   small closed integer quantifiers are reduced generically before QCP sends
   pure obligations to SMT. A VC accepted there belongs in `proof_auto`.
   If QCP/SMT leaves a residual, the result is immediately UNKNOWN and the
   goal remains in `proof_manual`; the core has no secondary `coq_auto`
   tactic layer and never edits `proof_manual`.
   Never add function names, case names, binds ids, concrete regression
   values, predicate-specific proof reconstruction, or generated Coq tactics
   to the automatic layer. New reduction rules must operate on general QCP
   assertion AST constructors and must be accepted by SMT.
   In particular, `Znth` follows its Coq definition through `Z.to_nat`:
   negative indices map to zero and an out-of-range nonnegative index selects
   the supplied default.  An opaque `Extern Coq` predicate that has no
   executable QCP definition remains a legitimate manual residual.

5. Process every bind independently:

   - `PASS / qcp_full_auto_passed`: QCP/SMT closed every VC in
     `proof_auto`.
   - `FAIL`: QCP reported a concrete inconsistency or execution failure that
     establishes the spec violation.
   - `ERROR / bindings_violate_require`: report the bind as invalid, not as a
     program failure.
   - `UNKNOWN / loop_unroll_limit_exceeded`: increase the bound when the
     concrete execution is finite; otherwise preserve UNKNOWN.
   - `UNKNOWN / call_depth_limit_exceeded`: increase the call-depth bound for
     known finite recursion; otherwise preserve UNKNOWN.
   - `UNKNOWN / residual_vc_requires_proof`: follow the residual proof
     workflow below.
   - Any other UNKNOWN or ERROR: inspect that case's stdout, stderr, generated
     source, and manifest. Never convert uncertainty into PASS.

## Prove residual VCs

Read [references/residual-vc.md](references/residual-vc.md) whenever a case
contains a residual VC manifest.

Edit only the manifest's `proof_manual` file. Fill every listed
`residual_goals` lemma with a real proof, then run:

```bash
python3 -m spectest check-proof PATH/TO/vc/manifest.json
```

Repeat proof editing and deterministic checking until it returns PASS or a
genuine blocker remains. Do not edit the C implementation, function
`Require`/`Ensure`, generated goal, generated auto proof, generated goal check,
or manifest hashes. Do not use `Admitted`, `admit`, `Abort`, new axioms,
parameters, hypotheses, or conjectures.

A failed proof attempt leaves the bind UNKNOWN; it does not prove the spec
false. A `check-proof` PASS is the only way to upgrade a residual case to a
satisfied manual result. A model-written proof is still manual for provenance;
never describe it as QCP or core automation. CoqGym is not part of this
workflow and must not be added unless a later, measured need justifies the
extra dependency.

## Report

Report each bind with its C arguments, logical values, selected spec, final
status, and artifact path. Distinguish these final bases:

- QCP/SMT automatic proof (`qcp_auto`);
- model- or human-written Coq residual proof (`manual`);
- concrete counterexample/spec failure;
- invalid bind;
- unresolved/tool error.

Do not claim general program verification. The result applies only to the
listed concrete logical bindings and explored finite paths.

## Dedicated model runner

Normally perform bind selection and proof work directly as the active model.
For an unattended external run explicitly requested by the user, execute
`scripts/run-agent.sh`. It follows the CAV Codex runner shape and pins the
model-only layer to `gpt-5.4-mini` with medium reasoning; the core tool remains
model-free.
