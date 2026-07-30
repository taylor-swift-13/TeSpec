# Legacy pilot material

The directories below preserve experiments from the earlier paired-mutant
task definition. Their `questions.json`, `gold.json`, and recorded baseline
results are construction history and are not valid gold for the current
two-input four-class task.

New public questions must be rematerialized with only:

```text
impl.c
spec.qcp
```

Reference/domain/mutant files and mutation relationships stay in hidden
construction metadata. Do not relabel old `perfect` or `sound` results; rerun
the semantic audit using the current Sound and Complete inclusions.
