# TeSpec four-class benchmark

This directory contains the construction artifacts for a 600-question
specification-evaluation benchmark:

- 100 difficult QCP-annotated base targets;
- six mutation-related `impl + spec` questions per base;
- 150 questions in each of `correct`, `soundness`, `complete`, and
  `incomparable`.

Legacy pilot gold may still contain `perfect` and `sound` under the previous
paired-mutant task definition. It is construction history, not valid gold for
the new two-input task, and must be rematerialized rather than relabeled.

The current files are a shortlist and mutation plan, not released gold labels.
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
```

Generated artifacts:

- [catalog/selected-programs.md](catalog/selected-programs.md)
- [catalog/selected-programs.json](catalog/selected-programs.json)
- [catalog/analyzer-audit.json](catalog/analyzer-audit.json)
- [catalog/question-plan-600.json](catalog/question-plan-600.json)
