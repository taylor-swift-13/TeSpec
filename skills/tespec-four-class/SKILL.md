---
name: tespec-four-class
description: Evaluate any existing C implementation and QCP specification by independently searching for implementation-satisfies/spec-rejects and spec-satisfies/implementation-rejects counterexamples, then classify the pair as correct, soundness, complete, or incomparable. Use when a four-class question exposes only impl and spec; mutation relationships between questions are lineage metadata, not extra task inputs.
---

# TeSpec four-class evaluation

Do not edit the implementation, specification, or logical dependencies. Do
not infer a label from a mutation operator or from failure to find a
counterexample.

Read [references/classification-contract.md](references/classification-contract.md)
before evaluating a task. Use `tespec-artifacts` to initialize and finalize the
task root.

## 1. Freeze inputs

Initialize a `four-class` artifact root, then copy the only public inputs to:

```text
input/impl.c
input/spec.qcp
```

Keep headers, strategies, and Coq modules under `dependencies/`. Store mutation
lineage only under `relations/`; never use a parent or sibling as evidence.

## 2. Search for a Complete counterexample

Complete means `R_I ⊆ R_S`. Try to refute it with exactly this polarity:

```text
implementation satisfies the concrete case
AND
specification rejects the resulting behavior
```

Enumerate implementation-defined pre-states across implementation branches,
heap shapes, aliasing, lengths, arithmetic boundaries, exceptional
representations, and values at or just outside `Require` boundaries. Do not
assume `Require` while searching for Complete: exclusion by `Require` can be
the spec rejection. For each candidate:

1. run the implementation with fully concrete arguments and initial heap;
2. reject crashes, undefined behavior, invalid binds, and incomplete traces;
3. freeze logical variables from the pre-state;
4. check the actual return and complete observable post-state against the spec.

Use `qcp-spec-test` when it supports the candidate. A checked `FAIL` can prove
`impl ∧ ¬spec`; `UNKNOWN`, timeout, or tool failure cannot. Save the concrete
case, implementation trace, and negative spec check under
`evidence/completeness/`.

If no counterexample is found, Complete remains unknown until an inclusion
proof or checked adequacy certificate covers all defined implementation
behaviors.

## 3. Search for a Sound counterexample

Sound means `R_S ⊆ R_I`. Try to refute it with the opposite polarity:

```text
specification satisfies a fully concrete behavior
AND
implementation does not produce that behavior
```

Search spec freedom independently of implementation executions: existential
outputs, omitted heap fields, weak predicates, equivalence relations,
underspecified flags or return values, and disjunctive postconditions. For each
candidate:

1. construct a complete pre-state and spec-admitted post-state;
2. positively check every `Require` and `Ensure` conjunct;
3. fix every observable field, return value, and relevant bit pattern;
4. run or symbolically analyze the implementation on the same pre-state;
5. prove the proposed post-state is absent from the implementation relation.

For a deterministic safe implementation, one complete execution plus a
determinism check is sufficient for step 5. For nondeterministic behavior,
cover all implementation outcomes. An implementation run rejected by the spec
is not a Sound counterexample; that direction belongs only to Complete.

If no counterexample is found, Sound remains unknown until an inclusion proof
or checked adequacy certificate covers every spec-admitted behavior.

## 4. Record false-property witnesses

After the underlying test artifacts exist, write each counterexample with the
direction-safe writer:

```bash
python3 "$TESPEC_ROOT/skills/tespec-four-class/scripts/write_counterexample.py" \
  --root TASK_ROOT \
  --property complete \
  --case-file evidence/completeness/case.json \
  --implementation-check evidence/completeness/implementation-trace.json \
  --specification-check evidence/completeness/spec-rejection.json \
  --rationale "Concrete implementation behavior is rejected by the spec."

python3 "$TESPEC_ROOT/skills/tespec-four-class/scripts/write_counterexample.py" \
  --root TASK_ROOT \
  --property sound \
  --case-file evidence/soundness/case.json \
  --implementation-check evidence/soundness/implementation-rejection.json \
  --specification-check evidence/soundness/spec-acceptance.json \
  --rationale "Concrete spec behavior is absent from the implementation."
```

The writer fixes the only legal polarity for each property and hashes the
current impl/spec. It does not replace the underlying semantic checks.

## 5. Write the result

For each true property, provide an inclusion proof or checked certificate. For
each false property, use the canonical counterexample from step 4. Then run:

```bash
python3 "$TESPEC_ROOT/skills/tespec-four-class/scripts/write_result.py" \
  --root TASK_ROOT \
  --sound false \
  --complete false \
  --soundness-evidence evidence/soundness/counterexample.json \
  --completeness-evidence evidence/completeness/counterexample.json
```

The result writer rejects a false-property witness with reversed polarity and
derives the label:

- `correct`: Sound and Complete;
- `soundness`: Sound only;
- `complete`: Complete only;
- `incomparable`: neither.

If either axis lacks the required proof or counterexample, stop without
finalizing. Never turn uncertainty into a four-class label.

## 6. Classification-only mode

Use this mode only when the caller explicitly asks for a best-effort label
without a proof artifact. Still inspect both inputs and run the two
counterexample searches independently. A found, valid counterexample decides
the corresponding axis. When a search finds none, judge that axis from direct
semantic analysis of all relevant branches, preconditions, postconditions,
heap effects, and observable outputs; do not treat the empty search alone as
proof.

Return the requested four-class label even when the argument is not a formal
certificate. Use `abstain` only when an input cannot be read or interpreted,
not merely because a full inclusion proof is unavailable. Do not create
`result.json` or claim machine-checked evidence in this mode.

## 7. Finalize

Clean allowlisted compiler caches, finalize with `tespec-artifacts`, and
validate `artifact-manifest.json`. Deliver the complete root.
