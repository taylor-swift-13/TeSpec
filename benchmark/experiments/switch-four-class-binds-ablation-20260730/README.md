# GPT-5 Nano TeSpec binds-only ablation

This historical experiment compared the same four mutation-related
`impl.c`/`spec.qcp` pairs under two conditions. The tool-enabled model could
write only
`binds.json`; TeSpec deterministically attaches the immutable spec, executes
the implementation, and checks the post-state. The control model is forbidden
from calling tools.

The condition skill snapshots and their dataset builder were removed after
the run. `dataset-manifest.json` retains their historical hashes.

The four questions cover `correct`, `complete`, `soundness`, and
`incomparable`. `fixtures/smoke-binds.json` is maintainer-only validation data
and is not copied into either model workspace.

The earlier `multidomain-four-class-tool-policy-20260730` run is invalid
because its treatment wrote ordinary compiler harnesses instead of invoking
TeSpec.

## Result

The audited final allocation used GPT-5 Nano through
`https://yunwu.ai/v1`, with three attempts on each of four balanced labels.

- No-tool: 12/12 attempts obeyed the zero-action policy and 10/12 labels were
  correct (83.3%).
- Tool allocation: 6/12 labels were correct (50.0%), counting timeouts and
  unparseable completions as unsuccessful allocations.
- Strict binds-only TeSpec adherence: only 2/12 attempts (16.7%). One was
  correct and one abstained, so the strict-subset accuracy was 50.0%.

No improvement is demonstrated. The strict tool subset is too small and
selection-biased for a causal accuracy estimate; the main observed problem is
Nano/OpenHands protocol adherence, not TeSpec execution speed. Local
maintainer smoke tests ran all six binds for a question in roughly 0.05–0.09
seconds.

Three pre-experiments are excluded: one inlined the code and elicited no tool
calls, one never completed `spectest run`, and one leaked terminal working
directory state across commands. The final skill uses a subshell so its
temporary `cd` cannot contaminate later actions. Exact hashes, attempt audits,
and exclusions are recorded in `dataset-manifest.json` and `report.json`.
