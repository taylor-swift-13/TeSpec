.PHONY: check format lint runtime test

PYTHON ?= python3

test:
	$(PYTHON) -m unittest discover -s tests -p 'test_*.py'

lint:
	$(PYTHON) -m ruff check spectest tests scripts skills
	$(PYTHON) -m ruff format --check spectest tests scripts skills

runtime:
	scripts/check-runtime.sh

check: lint test runtime

format:
	$(PYTHON) -m ruff format spectest tests scripts skills
