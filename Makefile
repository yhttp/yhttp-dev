PIP = pip
TEST_DIR = tests
PRJ = yhttp_devutils
PYTEST_FLAGS = -v
PYTHON = $(shell which python3)
VENV = $(PYTHON) -m venv


.PHONY: test
test:
	pytest $(PYTEST_FLAGS) $(TEST_DIR)


.PHONY: cover
cover:
	pytest $(PYTEST_FLAGS) --cov=$(PRJ) $(TEST_DIR)


.PHONY: lint
lint:
	flake8


.PHONY: venv
venv:
	$(VENV) .venv


.PHONY: env
env:
	$(PIP) install -r requirements-dev.txt
	$(PIP) install -e .


.PHONY: sdist
sdist:
	python3 setup.py sdist


.PHONY: bdist
bdist:
	python3 setup.py bdist_egg


.PHONY: dist
dist: sdist bdist


.PHONY: clean
clean:
	rm -rf ./dist

.PHONY: deploy
deploy: sdist
	./deploy.sh
