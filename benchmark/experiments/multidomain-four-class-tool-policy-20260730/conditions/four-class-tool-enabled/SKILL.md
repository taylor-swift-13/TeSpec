---
name: four-class-tool-enabled
description: Classify a C implementation and QCP specification as correct, soundness, complete, or incomparable by checking both relation inclusions and using workspace, compiler, and concrete-test tools. Use for best-effort four-class evaluation when impl/spec are the only semantic inputs and executable probes are allowed.
---

# Four-class classification

Treat mutation relationships as hidden lineage, never as label evidence.
Inspect the complete implementation, specification, and supplied semantic
definitions before deciding.

## Tool policy

Use workspace tools. Read `impl.c`, `spec.qcp`, and all files under
`dependencies/`. Create temporary compiler harnesses or small scripts for
targeted boundary cases when they can distinguish an inclusion. Run the
implementation only on legal, defined inputs; reject crashes, undefined
behavior, and invalid pre-states as evidence. Do not edit the supplied inputs.

Tools produce semantic observations, not labels. Combine their results with
direct reasoning about branches, heap effects, outputs, and spec freedom.

## Decision procedure

Let `I` be the safely terminating observable implementation relation and `S`
the relation admitted by the spec.

1. Search for a Complete counterexample in `I \ S`: execute a legal concrete
   implementation case, freeze pre-state logical values, and check whether the
   resulting return and complete observable post-state violate `Require` or
   `Ensure`.
2. Search independently for a Sound counterexample in `S \ I`: construct a
   complete spec-admitted behavior, then show the implementation cannot
   produce that behavior from the same pre-state. Look especially for
   existential outputs, omitted fields, weak predicates, alias freedom, and
   representation equivalences.
3. If no counterexample is found, judge the corresponding inclusion from
   direct semantic analysis. Absence from a finite search is not itself proof.
4. A formal proof is not required in classification-only evaluation. Give the
   best supported label after analyzing both axes. Use `abstain` only when an
   input cannot be read or interpreted.

Map the axes exactly:

| label | `S subset I` (Sound) | `I subset S` (Complete) |
|---|---:|---:|
| `correct` | true | true |
| `soundness` | true | false |
| `complete` | false | true |
| `incomparable` | false | false |
