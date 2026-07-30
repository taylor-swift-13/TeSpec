# Codex CLI GPT-5 Nano binds-only ablation

This experiment repeats the four-label `classify_switch` comparison through
Codex CLI rather than OpenHands. The four questions share one implementation
and are mutations of the specification; the original semantic inputs remain
only `impl.c` and `spec.qcp`.

- Tool-enabled Nano has a deliberately narrow role: first return six concrete
  binds, then classify after the runner executes TeSpec and supplies the
  derived report. The runner audits the binds and report before the
  classification stage.
- Tool-forbidden Nano receives the same semantic inputs inline and must emit
  no tool event.
- Each Codex call is stateless. This avoids relying on tool-result continuation
  support from an OpenAI-compatible gateway while retaining Codex CLI's model
  configuration, structured output, sandbox, and event audit.
- Each attempt runs in a fresh temporary workspace. Input hashes, generated
  binds, TeSpec reports, Codex JSONL traces, timeouts, and protocol adherence
  are audited separately from label accuracy.

The model provider is an ephemeral Codex custom provider targeting
`https://yunwu.ai/v1` through the Responses API. The API key is read only from
`YUNWU_API_KEY` and is never written to an artifact.

## Result

The balanced run used four mutation-related specs, three attempts per question
and condition:

- Tool-enabled: 12/12 attempts produced valid six-case binds, completed TeSpec,
  and passed the strict protocol audit. Labels were correct in 8/12 attempts
  (66.7%).
- Tool-forbidden: labels were correct in 9/12 attempts (75.0%). All 12 emitted
  a parsed zero-action answer; one correct answer was followed by a transport
  failure while Codex was closing the response.
- The tool delta was -1/12 (-8.3 percentage points). The only per-question
  difference was one `q03` attempt where Nano interpreted a TeSpec
  Completeness counterexample as evidence against Soundness.

This run fixes the earlier protocol-adherence confound: TeSpec was genuinely
executed in every treatment attempt. It still does not demonstrate an accuracy
improvement. The report directly establishes or refutes Complete for sampled
implementation behaviors, but Nano must reason separately about spec-only
behaviors for Soundness and sometimes applies the test evidence to the wrong
direction.

Exact attempt projections, raw-summary hashes, pilot exclusions, and the
small-sample warning are recorded in `report.json`. Raw traces remain under
the ignored `benchmark/results/codex-gpt-5-nano/` tree.
