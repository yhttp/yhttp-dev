TEST_DIR = tests
PKG = yhttp_devutils
PYTEST_FLAGS = -v
HERE = $(shell readlink -f `dirname .`)
VENVNAME = $(shell basename $(HERE))
VENV = $(HOME)/.virtualenvs/$(VENVNAME)
PY = $(VENV)/bin/python3
PIP = $(VENV)/bin/pip3
PYTEST = $(VENV)/bin/pytest
COVERAGE = $(VENV)/bin/coverage
FLAKE8 = $(VENV)/bin/flake8
TWINE = $(VENV)/bin/twine


ifdef U
  UNIT = tests/test_$(U).py
else
  UNIT = $(TEST_DIR)
endif


.PHONY: test
test:
	$(PYTEST) $(PYTEST_FLAGS) $(UNIT)


.PHONY: cover
cover:
	$(PYTEST) $(PYTEST_FLAGS) --cov=$(PKG) $(UNIT)


.PHONY: cover-html
cover-html: cover
	$(COVERAGE) html
	@echo "Browse htmlcov/index.html for the covearge report"


.PHONY: lint
lint:
	$(FLAKE8)


.PHONY: venv
venv:
	python3 -m venv $(VENV)


.PHONY: env
env:
	$(PIP) install -r requirements-dev.txt
	$(PIP) install -e .


.PHONY: venv-delete
venv-delete: clean
	rm -rf $(VENV)


.PHONY: sdist
sdist:
	$(PY) -m build --sdist


.PHONY: bdist
wheel:
	$(PY) -m build --wheel


.PHONY: dist
dist: sdist wheel


.PHONY: pypi
pypi: dist
	$(TWINE) upload dist/*.gz dist/*.whl


.PHONY: clean
clean:
	rm -rf dist/*
	rm -rf build/*
