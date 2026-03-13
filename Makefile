SHELL := /bin/bash

.PHONY: format analyze test build pre-pr

format:
	./scripts/format.sh

analyze:
	./scripts/analyze.sh

test:
	./scripts/test.sh

build:
	./scripts/build.sh $(TARGET) $(ARGS)

pre-pr:
	./scripts/pre_pr.sh
