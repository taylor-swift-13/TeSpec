# TeSpec paper drafts

`main.tex` is the primary software-engineering paper:

> **TeSpec: Proof-Backed Instance Testing of C Heap Specifications**

It frames TeSpec as a testing and specification-evaluation tool rather than a
new program logic.  The main sections cover the user problem, relationship to
property-based testing, a worked minimum-subarray motivation example, workflow
and implementation, binding interface, engineering assurances, threats to
validity, and related work.

The benchmark section defines the bidirectional `code-to-spec` and
`spec-to-code` generation tasks, syntax-only versus no-tool comparison, frozen
submissions, and hidden semantic testing with implementation mutations.

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
