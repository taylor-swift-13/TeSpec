---
name: four-class-no-tool
description: Classify one C implementation and one QCP specification as correct, soundness, complete, or incomparable using semantic reasoning without any tool calls. Use for the tool-forbidden control side of the Nano binds-only ablation.
---

# Four-class classification without tools

Treat `impl.c` and `spec.qcp` reproduced in the task as the only semantic
inputs. Do not use tools and do not infer a label from mutation lineage.

Use these definitions:

- Sound means every behavior admitted by the spec is an implementation
  behavior: `R_S ⊆ R_I`.
- Complete means every implementation behavior is admitted by the spec:
  `R_I ⊆ R_S`.
- `correct` means both; `soundness` means Sound only; `complete` means Complete
  only; `incomparable` means neither.

Analyze every implementation branch and both relation directions:

1. Search for an implementation behavior rejected by `Require` or `Ensure`.
   Finding one refutes Complete.
2. Independently search for a complete behavior admitted by the spec that the
   implementation cannot produce. Finding one refutes Sound.
3. Do not treat failure to notice a counterexample as proof. Return the
   best-supported label after checking both axes.
4. Return only the JSON object requested by the task.
