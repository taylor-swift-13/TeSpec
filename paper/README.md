# TeSpec paper drafts

`main.tex` is the primary software-engineering paper:

> **TeSpec: Proof-Backed Instance Testing of C Heap Specifications**

It frames TeSpec as a testing and specification-evaluation tool rather than a
new program logic.  The main sections cover the user problem, relationship to
property-based testing, a worked minimum-subarray motivation example, workflow
and implementation, binding interface, engineering assurances, threats to
validity, and related work.

The benchmark section defines the four-class `correct` / `soundness` /
`complete` / `incomparable` task, the 100-program by six-question construction
with balanced hard/expert tiers, hidden
proof/counterexample gold, and the paired agent-versus-agent+TeSpec protocol.
The empirical-results subsection remains intentionally blank: measurements
must be filled from a frozen 600-question artifact rather than internal
regression runs.

Supporting theory material is retained separately:

- `theory-heavy-draft.tex`: archived theory-oriented English draft;
- `theory.zh-CN.md`: strict Chinese theory notes;
- `theorems.zh-CN.md`: Chinese translations of the old draft's formal
  statements;
- `qcp-theory-audit.zh-CN.md`: audit of what follows from the QCP paper versus
  what would require new TeSpec proofs.

The SE draft treats this material as design rationale and assurance notes, not
as its primary contribution.

Build:

```bash
cd paper
pdflatex main
bibtex main
pdflatex main
pdflatex main
```

The current PDF is `main.pdf`.
