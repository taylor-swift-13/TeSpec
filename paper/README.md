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

Build:

```bash
cd paper
pdflatex main
bibtex main
pdflatex main
pdflatex main
```

The current PDF is `main.pdf`.
