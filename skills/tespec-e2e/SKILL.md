---
name: tespec-e2e
description: "Run the direct TeSpec end-to-end workflow for executable C code with a missing, incomplete, or suspect QCP specification: author and repair the spec, create exactly 30 concrete binds, mutation-test implementations, and deliver validated evidence under e2e/. Use for spec creation and refinement from implementation source; do not use for classifying an already-fixed reference/spec/mutant tuple."
---

# TeSpec E2E

Keep the executable implementation authoritative and TeSpec deterministic.
Use model judgment only to author specs, binds, and implementation mutants.
Never add a model call to TeSpec.

Set `TESPEC_ROOT=/opt/tespec` inside the Docker image and to the repository
root in a source checkout. Run `qcp-spectest` when installed; fall back to
`python3 -m spectest` from `TESPEC_ROOT`.

## 1. Create an isolated workspace

Never edit the user's implementation in place. Use `tespec-artifacts` to
initialize `e2e/FUNCTION`, then populate:

```text
e2e/FUNCTION/
├── source/original/
├── spec/versions/
├── spec/final_spec.c
├── tests/binds.json
├── mutants/refinement/
├── mutants/heldout/
├── evidence/
├── reports/
├── negative-examples.json
├── survivors.json
├── SPEC_CHANGELOG.md
└── manifest.json
```

Copy all source-local headers, Coq modules, and strategies needed by the
target. Preserve the implementation body byte-for-byte in every spec version.

## 2. Study analogous bundled cases

Read [references/case-index.md](references/case-index.md), then inspect at
least two structurally similar directories under `TESPEC_ROOT/cases`. Reuse
their annotation and binds shapes, not their concrete values or predicates.
Do not add function-name or case-specific behavior to TeSpec.

## 3. Generate the candidate spec

Infer the C arguments, reachable heap footprint, aliasing, old-state values,
return, modified cells, preserved cells, finite loop/call requirements, and
needed logical types. Put the QCP annotation on a copy of the implementation.
Keep case-specific Coq definitions and strategies beside that copy.

Run:

```bash
qcp-spectest analyze spec/versions/v001.c \
  --function FUNCTION --write-binds /tmp/template.json
```

If the function has multiple full specs, process every selected spec
independently with `--spec`; each receives its own 30-case binds file and
reports.

## 4. Generate exactly 30 tests per spec

Create 30 unique binds from the analysis result. Bind every top-level C
argument and every required value-level `With`; preserve intended pointer
aliasing explicitly. Cover:

- every feasible branch and loop/call boundary;
- zero, one, typical, and largest practical finite heap shapes;
- arithmetic and index boundaries without undefined C behavior;
- empty/nonempty arrays or lists and head/middle/tail heap updates;
- aliasing modes permitted by `Require`;
- representative custom constructors and logical types.

Do not duplicate a bind under a different ID. Every bind must satisfy
`Require`; invalid binds do not count toward 30. Read the existing
`qcp-spec-test` binds reference when an arbitrary Coq type is involved.

## 5. Repair the spec against the reference

Run all 30 tests on the original body. Classify evidence strictly:

- `PASS`: this bind does not violate the candidate spec.
- `FAIL`: inspect the actual reference transition; correct the spec when its
  heap relation, old-state relation, or postcondition is wrong.
- `ERROR / bindings_violate_require`: repair or replace the bind, not the
  implementation.
- `UNKNOWN`: increase finite bounds or complete a real residual proof; never
  treat it as evidence that the spec is correct or incorrect.

After every spec edit:

1. save a new immutable `spec/versions/vNNN.c`;
2. record the reason and evidence in `SPEC_CHANGELOG.md`;
3. rerun `analyze`;
4. rebuild the 30 binds if `With`, arguments, or `Require` changed;
5. rerun all 30 reference tests.

Do not enter mutation testing until all 30 reference cases are `PASS`.

## 6. Generate and run mutants

Read [references/mutation-protocol.md](references/mutation-protocol.md).
Generate at least eight refinement mutants. Each mutant must:

- preserve the candidate spec text exactly;
- contain one localized implementation change;
- remain parseable, terminating, memory-safe on all 30 binds, and free of
  deliberate undefined behavior;
- use a general operator such as branch, arithmetic, constant, loop bound,
  omitted/incorrect heap write, wrong field/index, return, or callee change.

Run the deterministic matrix:

```bash
python3 "$TESPEC_ROOT/skills/tespec-e2e/scripts/run_mutation_matrix.py" \
  --artifact-root . \
  --reference spec/versions/vNNN.c \
  --function FUNCTION \
  --binds tests/binds.json \
  --mutants mutants/refinement \
  --output-dir reports/refinement-vNNN \
  --spec-version vNNN
```

A negative example requires `PASS` on the reference and `FAIL` on the mutant
for the same bind. Never include `UNKNOWN`, `ERROR`, an invalid mutant, or an
unconfirmed behavioral claim in `negative-examples.json`.

## 7. Correct weak specs without hiding overfitting

Inspect surviving mutants. If a survivor has confirmed observable behavior
different from the reference and the intended contract should reject it, the
spec is too weak: create the next spec version and repeat the complete
30-reference-test and mutation regression. If the mutant is equivalent on the
domain, record it as equivalent rather than weakening or strengthening the
spec artificially.

Every spec edit invalidates the previous matrix as a final score. Archive it
as refinement evidence. After the final spec is frozen, generate at least four
fresh held-out mutants that were not used to edit the spec and run a separate
matrix. Do not modify the frozen spec from held-out results; report survivors.

## 8. Deliver

Copy the frozen version to `spec/final_spec.c` and deliver:

- `tests/binds.json` with exactly 30 valid tests per spec;
- refinement and held-out mutant sources and reports;
- confirmed negative examples and survivors;
- the versioned change log;
- `manifest.json` with SHA-256 hashes and status counts.

Preview and clean only allowlisted compiler caches with `tespec-artifacts`.
Finalize and validate `artifact-manifest.json`; never hand off an unvalidated
directory or include `.vo`, `.glob`, `.aux`, bytecode, or solver caches.

Describe the result as “the reference did not violate this spec on the 30
listed binds.” Do not claim general verification.
