# GPT-5 Nano skill/tool ablation

This experiment uses the existing `ieee754-clamp-expert` question and its
human-reviewed `incomparable` gold label. The implementation and specification
bytes are identical in every scored condition.

Three attempts were run per condition with `openai/gpt-5-nano`, high reasoning,
Chat Completions, three-way concurrency, a 600-second per-attempt timeout, and
the `https://yunwu.ai/v1` gateway.

| condition | predictions | correct | mean wall time | makespan |
|---|---|---:|---:|---:|
| no skill | `correct`, `correct`, `soundness` | 0/3 | 300.073 s | 330.433 s |
| workflow-only skill | `correct`, `correct`, `correct` | 0/3 | 180.311 s | 249.342 s |
| tool-backed skill | `correct`, `correct`, `incomparable` | 1/3 | 152.073 s | 212.191 s |

All scored attempts inspected both semantic inputs. Two of three
workflow-only attempts explicitly opened the skill file; none created a
compiler probe. All three tool-backed attempts opened the skill, ran the
probe, received the NaN and signed-zero observations, and got exit code zero.

The tool-backed skill therefore improved this one-question sample from 0/3 to
1/3 and made one Nano run combine both counterexamples correctly. It did not
make the result reliable: two runs still answered `correct`. With one question
and three stochastic attempts, this is a capability probe, not a population
performance estimate.

The exact aggregate records, hashes, trajectory audit, and excluded pilot runs
are in `report.json`. Raw OpenHands traces remain under the gitignored
`benchmark/results/` tree.
