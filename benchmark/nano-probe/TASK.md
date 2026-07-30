# Implementation/specification classification

The semantic inputs are exactly:

- `impl.c`: implementation \(I\);
- `spec.qcp`: specification \(S\).

Files under `dependencies/`, when present, only define the fixed QCP/Coq
environment. Do not infer a label from file names, mutation operators, parent
questions, or sibling questions.

Before answering, use the workspace tools to read both `impl.c` and
`spec.qcp`, plus any definitions they reference under `dependencies/`. An
answer produced without inspecting both semantic inputs is invalid.

Let \(R_I\) be the safely terminating observable behavior relation of the
implementation and \(R_S\) the behavior relation admitted by the
specification.

- Sound means \(R_S \subseteq R_I\).
- Complete means \(R_I \subseteq R_S\).

| label | Sound | Complete |
|---|---:|---:|
| `correct` | true | true |
| `soundness` | true | false |
| `complete` | false | true |
| `incomparable` | false | false |

Reason about both inclusions. `UNKNOWN`, failure to find a counterexample, or
mutation syntax is not proof. Return only:

```json
{"label":"correct|soundness|complete|incomparable|abstain"}
```
