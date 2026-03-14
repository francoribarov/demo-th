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

## Atomic guardrails

Run non-blocking architecture guardrails for presentation feedback and atomic boundary patterns:

- Direct `ScaffoldMessenger` snackbars
- Ad-hoc destructive inline styles
- Manual CTA spinners
- Widget imports of `core/routing/app_router.dart`
- `templates/**` and `organisms/**` importing blocs or calling bloc read/watch
- `templates/**` and `organisms/**` direct navigation calls (`context.go/push/popOrGo`)
- `presentation/pages/**/steps/**` importing blocs or calling bloc read/watch

```sh
./scripts/atomic_guardrails.sh
```

Run in strict mode (non-zero exit when violations are found):

```sh
./scripts/atomic_guardrails.sh --strict
```

Get machine-readable output:

```sh
./scripts/atomic_guardrails.sh --json
```
