# Scripts

This repo keeps helper commands in `scripts/` and `tool/`.

## Coverage

Generate coverage and enforce the configured thresholds:

```sh
dart tool/test_and_coverage.dart
```

To run tests via FVM:

```sh
dart tool/test_and_coverage.dart --use-fvm
```

To enforce coverage only (after running tests with coverage):

```sh
dart tool/enforce_coverage.dart --coverage-file coverage/lcov.info --thresholds tool/coverage_thresholds.json
```
