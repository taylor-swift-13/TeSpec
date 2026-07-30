# TeSpec four-class benchmark

This directory contains the construction artifacts for a 600-question
specification-evaluation benchmark:

- 100 difficult QCP-annotated base targets;
- exactly six mutation-related `impl + spec` subquestions per base, explicitly
  indexed from 1 through 6;
- three `hard` and three `expert` questions per base;
- 150 questions in each of `correct`, `soundness`, `complete`, and
  `incomparable`, with 75 questions per class and difficulty tier.

Legacy pilot gold may still contain `perfect` and `sound` under the previous
paired-mutant task definition. It is construction history, not valid gold for
the new two-input task, and must be rematerialized rather than relabeled.

The current files are a shortlist and mutation plan, not reviewed gold labels.
Each public question contains only its current implementation and
specification. Parent/sibling mutation lineage is hidden construction
metadata.
See [DESIGN.zh-CN.md](DESIGN.zh-CN.md) for the formal task definition and
required proof/witness audit.

Regenerate the static catalog and balanced question plan:

```bash
python3 scripts/build-four-class-benchmark-catalog.py --size 100
python3 scripts/audit-four-class-programs.py
python3 scripts/build-four-class-question-plan.py
python3 scripts/audit-four-class-question-plan.py
```

Generated artifacts:

- [semantic-review.schema.json](semantic-review.schema.json)
- [catalog/selected-programs.md](catalog/selected-programs.md)
- [catalog/selected-programs.json](catalog/selected-programs.json)
- [catalog/analyzer-audit.json](catalog/analyzer-audit.json)
- [catalog/question-plan-600.json](catalog/question-plan-600.json)
- [catalog/difficulty-audit.json](catalog/difficulty-audit.json)
- [catalog/nano-rejected-bases.json](catalog/nano-rejected-bases.json)

The difficulty audit is a construction gate, not semantic gold. It rejects
unbalanced tiers, shallow expert mutations, missing reasoning dimensions,
public-input leakage, and absent anti-shortcut records. A planned label becomes
gold after a reviewer reads the materialized `impl.c` and `spec.qcp`, records
both Sound and Complete judgments with rationales, and the difficulty audits
pass. Formal proofs and checked counterexamples are optional supporting
evidence rather than release blockers.

The authoritative difficulty criterion is the frozen OpenHands +
`openai/gpt-5-nano` generic-agent baseline. Each materialized question receives
three independent attempts. Questions Nano answers correctly at least twice
are simple and must be replaced without changing the 600-question class
balance. Every scored trajectory must attest that the agent inspected both
`impl.c` and `spec.qcp`; missing input access and infrastructure failures are
unresolved, never evidence that a question is difficult.

Base selection reads bundled `runtime/qcip/QCP_examples` directly and rejects
static construction scores below 30. A materialized base question solved by
Nano at least twice is recorded in `nano-rejected-bases.json`, excluded before
selection, and replaced without changing the 100-base/600-question totals.
Static scores only remove obvious tutorial-scale candidates; the three-run
Nano result remains authoritative.
