# Implementation/specification classification

The public question contains exactly:

- `impl.c`: the implementation \(I\);
- `spec.qcp`: the specification \(S\).

Do not inspect parent or sibling questions. Mutation relationships between
questions are hidden lineage, not an additional input and not evidence for a
label.

Let \(R_I\) be the safely terminating observable behavior relation of the
implementation and \(R_S\) the behavior relation admitted by the spec.

1. `Sound` means \(R_S \subseteq R_I\).
2. `Complete` means \(R_I \subseteq R_S\).

| label | Sound | Complete |
|---|---:|---:|
| `correct` | true | true |
| `soundness` | true | false |
| `complete` | false | true |
| `incomparable` | false | false |

Reason about both inclusions. `UNKNOWN`, failure to find a counterexample, or
guessed mutation syntax is not proof. Return only:

```json
{"label":"correct|soundness|complete|incomparable|abstain"}
```
