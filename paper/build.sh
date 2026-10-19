#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "$0")"
python3 scripts/audit-case-studies.py
python3 scripts/audit-strategy-correspondence.py
python3 scripts/summarize-evidence.py
for figure in overview observation result-flow; do
  (cd figures && pdflatex -interaction=nonstopmode -halt-on-error "$figure-standalone.tex" > "build-$figure.log")
done
pdflatex -interaction=nonstopmode -halt-on-error main.tex > build-pass1.log
bibtex main > build-bibtex.log
pdflatex -interaction=nonstopmode -halt-on-error main.tex > build-pass2.log
pdflatex -interaction=nonstopmode -halt-on-error main.tex > build-pass3.log
printf '%s\n' 'Built paper/main.pdf; see main.log for layout diagnostics.'
