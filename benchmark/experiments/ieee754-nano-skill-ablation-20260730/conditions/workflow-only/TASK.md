# Implementation/specification classification

The semantic inputs are exactly:

- `impl.c`: implementation \(I\);
- `spec.qcp`: specification \(S\).

Files under `dependencies/`, when present, only define the fixed QCP/Coq
environment or a reusable evaluation workflow. They do not contain a gold
label. Do not infer a label from file names, mutation operators, parent
questions, or sibling questions.

Before answering, use the workspace tools to read both `impl.c` and
`spec.qcp`, plus any definitions they reference under `dependencies/`. An
answer produced without inspecting both semantic inputs is invalid.

Also read `dependencies/TOOL_SKILL.md` and follow its label-blind workflow.
Use ordinary workspace tools when useful.

Let \(R_I\) be the safely terminating observable implementation relation and
\(R_S\) the relation admitted by the specification.

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
