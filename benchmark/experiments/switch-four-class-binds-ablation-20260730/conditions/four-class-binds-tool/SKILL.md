---
name: four-class-binds-tool
description: Classify one C implementation and one QCP specification as correct, soundness, complete, or incomparable by letting TeSpec assemble and test the immutable pair while the model writes only concrete binds. Use for the tool-enabled side of the Nano binds-only ablation.
---

# Four-class classification with TeSpec binds

Treat `impl.c` and `spec.qcp` as the only semantic inputs. Do not edit them and
do not infer a label from mutation lineage.

Use these definitions:

- Sound means every behavior admitted by the spec is an implementation
  behavior: `R_S ⊆ R_I`.
- Complete means every implementation behavior is admitted by the spec:
  `R_I ⊆ R_S`.
- `correct` means both; `soundness` means Sound only; `complete` means Complete
  only; `incomparable` means neither.

Follow this protocol:

1. Do not answer from the task text. Read `impl.c` and `spec.qcp` with the
   terminal.
2. While the terminal is still in the starting workspace, run this command
   exactly:

   ```bash
   WORKSPACE="$(pwd -P)"; (cd /home/yangfp/teSpec && \
     python3 -m spectest analyze "$WORKSPACE/impl.c" \
       --spec-file "$WORKSPACE/spec.qcp" \
       --function classify_switch \
       --write-binds "$WORKSPACE/binds.json")
   ```

   There is exactly one positional argument after `analyze`: `impl.c`.
3. Replace the one-case template by editing only `binds.json`. Include at
   least six concrete cases covering every implementation branch and its
   boundaries. Do not write or edit any C source, QCP spec, script, harness,
   oracle, proof, or combined source.
4. Without changing the terminal's workspace directory, run this command
   exactly:

   ```bash
   WORKSPACE="$(pwd -P)"; (cd /home/yangfp/teSpec && \
     python3 -m spectest run "$WORKSPACE/impl.c" \
       --spec-file "$WORKSPACE/spec.qcp" \
       --function classify_switch \
       --binds "$WORKSPACE/binds.json" \
       --output-dir "$WORKSPACE/tespec-output")
   ```
5. Use checked results to find implementation behaviors rejected by the spec.
   Separately reason about spec-admitted behaviors the implementation cannot
   produce; passing implementation traces alone do not establish Sound.
6. Return only the JSON object requested by the task.

A direct answer without successful `spectest analyze` and `spectest run`
actions is a protocol failure, even if its label happens to be correct.
