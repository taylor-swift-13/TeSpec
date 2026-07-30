---
name: tespec-four-class
description: Evaluate one existing C implementation and one QCP specification, produce checked soundness and completeness evidence for their semantic relationship, and classify the pair as correct, soundness, complete, or incomparable. Use when a four-class question exposes only impl and spec; mutation relationships between questions are lineage metadata, not extra task inputs.
---

# TeSpec four-class evaluation

Do not edit the implementation, specification, or logical dependencies. Do
not infer a label from a mutation operator or from failure to find a
counterexample.

Read [references/classification-contract.md](references/classification-contract.md)
before evaluating a task. Use `tespec-artifacts` to initialize and finalize the
task root.

## 1. Freeze inputs

Initialize a `four-class` artifact root, then copy the only public inputs to
the exact paths:

```text
input/impl.c
input/spec.qcp
```

Keep headers, strategies, and Coq modules under `dependencies/`. If this
question was produced by mutating another question, record that relationship
under `relations/`; never place parent implementations/specs or mutation
metadata in `input/`.

## 2. Establish Sound

Determine whether every behavior admitted by the spec is a behavior of the
implementation.

- If false, save a checked spec-allowed behavior that the implementation does
  not produce under `evidence/soundness/`.
- If true, save an inclusion proof or an explicit checked adequacy certificate
  under `evidence/soundness/`.

An `UNKNOWN`, timeout, finite sample with no counterexample, mutation lineage,
or invalid bind does not prove Sound.

## 3. Establish Complete

Determine whether every defined implementation behavior is admitted by the
spec.

- If false, save a concrete implementation execution rejected by the spec.
- If true, save a checked inclusion certificate covering the implementation's
  defined input domain.

Store the certificate or counterexample under `evidence/completeness/`.
Crashes, undefined behavior, timeout, or a sibling mutation are not
completeness witnesses for the current pair.

## 4. Write the result

Use the deterministic writer:

```bash
python3 "$TESPEC_ROOT/skills/tespec-four-class/scripts/write_result.py" \
  --root TASK_ROOT \
  --sound true \
  --complete false \
  --soundness-evidence evidence/soundness/certificate.json \
  --completeness-evidence evidence/completeness/counterexample.json
```

It derives the only allowed label:

- `correct`: Sound and Complete;
- `soundness`: Sound only;
- `complete`: Complete only;
- `incomparable`: neither.

If either property lacks the required certificate, stop without finalizing.
Never turn uncertainty into one of the four labels.

## 5. Finalize

Clean allowlisted compiler caches, finalize with `tespec-artifacts`, and
validate `artifact-manifest.json`. Deliver the complete root, not a detached
`result.json`.
