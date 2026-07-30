---
name: tespec-classify-ieee754-clamp
description: Classify the TeSpec ieee754-clamp-expert C implementation and QCP specification by deterministically finding one implementation-allowed/spec-rejected witness for Complete and one spec-allowed/implementation-absent witness for Sound. Use for this IEEE-754 clamp task or an exact repackaging of its impl.c, spec.qcp, SEMANTICS.md, and definitions.v.
---

# Classify the IEEE-754 clamp pair

Do not edit the inputs. Keep two independent witness ledgers:

- Disprove **Complete** (`R_I ⊆ R_S`) only with `impl ∧ ¬spec`.
- Disprove **Sound** (`R_S ⊆ R_I`) only with `spec ∧ ¬impl`.

Never use a witness for one direction as evidence for the other direction.

## Run the checked search

Read `impl.c`, `spec.qcp`, `SEMANTICS.md`, and `definitions.v`, then run:

```bash
python3 "$TESPEC_ROOT/skills/tespec-classify-ieee754-clamp/scripts/find_witnesses.py" \
  --impl PATH/impl.c \
  --spec PATH/spec.qcp \
  --semantics PATH/SEMANTICS.md \
  --definitions PATH/definitions.v \
  --output PATH/two-axis-witnesses.json
```

Use the actual paths in the current task. A nonzero exit, missing source
signature, compiler failure, or `"witness_found": false` is unresolved; do not
guess a four-class label.

## Check Complete

Read `complete_counterexample` first. It must establish:

1. the pre-state is admitted by `BatchDomain`;
2. the concrete implementation terminates and produces the recorded state;
3. that state violates an `Ensure` conjunct.

For this pair, the searched case is a permitted quiet NaN input. The
implementation preserves NaN, so `AllNonNaN(outputs)` is false. This is
`R_I \ R_S` and disproves Complete. It says nothing by itself about Sound.

## Check Sound

Read `sound_counterexample` separately. It must establish:

1. every spec conjunct holds for the proposed post-state;
2. all observable fields are fixed;
3. the deterministic implementation produces a different post-state for the
   same pre-state.

For this pair, use negative zero with bounds `[-1, 1]`. The spec admits
positive zero through `NumericEq`; choose the implementation's actual flag and
return values so all other observables agree. Because heap observation
distinguishes the zero bit patterns, this spec behavior is absent from the
implementation. This is `R_S \ R_I` and disproves Sound. It says nothing by
itself about Complete.

## Derive the label

Map the two independently checked properties:

| label | Sound | Complete |
|---|---:|---:|
| `correct` | true | true |
| `soundness` | true | false |
| `complete` | false | true |
| `incomparable` | false | false |

Only derive the label after both ledgers contain checked evidence.
