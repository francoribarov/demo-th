SHELL := /bin/bash

.PHONY: format format-check analyze test build pre-pr

format:
	./scripts/format.sh

format-check:
	./scripts/format.sh --output=none --set-exit-if-changed

analyze:
	./scripts/analyze.sh

test:
	./scripts/test.sh

build:
	./scripts/build.sh $(TARGET) $(ARGS)

pre-pr:
	./scripts/pre_pr.sh
