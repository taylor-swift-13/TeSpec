# Strategy correspondence evidence

This directory separates three kinds of evidence.

- `executions/`: eight automatic reports for a helper returning 1, with either
  a loose return-in-{0,1} contract or an exact return-1 contract, under both
  strategies and both observation schedules. Loose: inline PASS, modular FAIL
  after selecting 0. Exact: both PASS. The modular reports are scoped to the
  selected contract model, not a counterexample to the helper's body.
- `experiment.json`: input/output hashes, archived original paths, exact
  commands, source revision, executor hash, stage resources and run outcomes.
  Reports retain original paths; the recorded relocation rule locates their
  archived copies. No execution-VC ITP or kernel certificate is claimed.
- `theory/`: full independent replay of 12 modules and 102 closed principal
  statements. This proves parameterized reference results, not C refinement.
- `proof-development/`: all retained checks of the new module while developing
  the correspondence and its total-acceptance extension.

`ModeCorrespondence.v` in `paper/theory/` proves both why unconditional
agreement fails and when semantic agreement follows. Matching boundaries,
two-way successor coverage, and related check interpretations are explicit
assumptions. The current sampler is not proved to meet that interface.
