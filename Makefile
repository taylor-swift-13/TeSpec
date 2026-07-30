.PHONY: benchmark-check check format lint runtime test

PYTHON ?= python3

test:
	$(PYTHON) -m unittest discover -s tests -p 'test_*.py'

lint:
	$(PYTHON) -m ruff check spectest tests scripts skills benchmark/baselines
	$(PYTHON) -m ruff format --check spectest tests scripts skills benchmark/baselines

runtime:
	scripts/check-runtime.sh

benchmark-check:
	$(PYTHON) scripts/audit-four-class-question-plan.py

check: lint benchmark-check test runtime

format:
	$(PYTHON) -m ruff format spectest tests scripts skills benchmark/baselines
