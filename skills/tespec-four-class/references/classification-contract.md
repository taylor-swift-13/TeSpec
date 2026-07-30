# Four-class contract

A question exposes exactly one implementation `I` and one specification `S`.
Mutation relationships may connect this question to siblings during dataset
construction, but they are not question inputs and cannot substitute for
evidence about the current pair.

For legal initial state `x`, let `B(I, x)` be the safely terminating observable
implementation behavior and `R(S, x)` be the set of behaviors admitted by the
spec under logical bindings frozen from the initial state.

## Properties

Sound:

```text
for every legal x and behavior y:
  if y is admitted by S at x, then y is a behavior of I at x
```

Equivalently, `R(S) ⊆ B(I)`. A counterexample is a concrete behavior admitted
by the spec but not produced by the implementation.

Complete:

```text
for every legal x:
  the defined behavior B(I, x) is admitted by S at x
```

Equivalently, `B(I) ⊆ R(S)`. A counterexample is a concrete implementation
execution rejected by the spec, including exclusion by `Require`.

## Classification

| Label | Sound | Complete |
|---|---:|---:|
| `correct` | true | true |
| `soundness` | true | false |
| `complete` | false | true |
| `incomparable` | false | false |

Do not ingest legacy `perfect` or `sound` labels as aliases: those datasets may
use different axis definitions and require rematerialization.

## Evidence requirements

For each true property, provide a proof or checked adequacy certificate. A
finite test set with no counterexample is not sufficient by itself.

For each false property, provide a concrete machine-checkable counterexample
with:

- concrete C arguments and complete relevant heap;
- initial logical bindings frozen before execution;
- an implementation trace or a concrete spec-admitted behavior, as required;
- checked positive or negative candidate polarity;
- impl, spec, dependency, and tool hashes.

`FAIL` may contribute to a completeness counterexample. `UNKNOWN`, `ERROR`,
timeout, crash, undefined behavior, or an invalid bind is unresolved evidence.
Mutation lineage is provenance only.
