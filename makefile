.ONESHELL:
.EXPORT_ALL_VARIABLES:

SHELL = /bin/bash
CONDA_ACTIVATE = source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate

PYTHONPATH=src

#######
# Help
#######

.DEFAULT_GOAL := help
.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

###################
# Conda Enviroment
###################

PY_VERSION := 3.11
POETRY_VERSION := 1.4.0
CONDA_ENV_NAME := $(notdir $(shell pwd))
ACTIVATE_ENV = source activate $(CONDA_ENV_NAME)

.PHONY: build-conda-env
build-conda-env: $(CONDA_ENV_NAME)  ## Build the conda environment
$(CONDA_ENV_NAME):
	conda create --name $(CONDA_ENV_NAME) -y  python=$(PY_VERSION)
	$(ACTIVATE_ENV) && python -s -m pip install poetry==$(POETRY_VERSION) && poetry config virtualenvs.create false && poetry install --no-root

.PHONY: clean-conda-env
clean-conda-env:  ## Remove the conda environment
	conda remove --name $(CONDA_ENV_NAME) --all -y

.PHONY: test
test: ## Run unit tests (unit)
	$(ACTIVATE_ENV) && pytest src/ -s -v
