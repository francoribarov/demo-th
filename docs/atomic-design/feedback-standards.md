# Feedback Standards

This guide defines the canonical feedback components for presentation-layer UI.

## Scope

- `lib/presentation`

## Canonical Components

- `InlineFeedbackText` (`atoms/common/inline_feedback_text.dart`)
- `ButtonLoadingIndicator` (`atoms/common/button_loading_indicator.dart`)
- `FeedbackMessenger` (`templates/common/feedback_messenger.dart`)
- `StateFeedbackView` (`organisms/common/state_feedback_view.dart`)
- `FeedbackNotice` + `FeedbackSeverity` (`presentation/blocs/common/feedback_notice.dart`)

## Rules

1. Do not call `ScaffoldMessenger.of(...).showSnackBar(...)` directly in presentation code.
2. Use `FeedbackMessenger` for all user-facing snackbar messages.
3. Do not implement ad-hoc red inline error `Text` when `InlineFeedbackText` can represent the message.
4. Do not repeat manual CTA spinner snippets (`SizedBox(18) + CircularProgressIndicator`) when `ButtonLoadingIndicator` can be used.
5. Use `StateFeedbackView` for page-level loading/empty/error layouts unless the flow has truly unique behavior.

## Tone Mapping

- `FeedbackMessageTone.success` -> `AppColors.success`
- `FeedbackMessageTone.error` -> `AppColors.destructive`
- `FeedbackMessageTone.warning` -> `AppColors.gameRust`
- `FeedbackMessageTone.info` -> default themed snackbar background

## PR Checklist

1. New feedback messages use `FeedbackMessenger`.
2. New inline validation or status messages use `InlineFeedbackText`.
3. New button loading states use `ButtonLoadingIndicator`.
4. New full-state loading/error screens evaluate `StateFeedbackView` first.
5. Severity in presentation state uses `FeedbackNotice` instead of string heuristics.

## Atomic Boundary Guardrails

- `widgets/**` must not import `core/routing/app_router.dart`; use `core/routing/navigation.dart`.
- `templates/**` and `organisms/**` must not import `presentation/blocs/*`.
- `templates/**` and `organisms/**` must not call `context.read/watch<...Bloc>()`.
- `templates/**` and `organisms/**` must not call `context.go/push/popOrGo`; route actions must come from page-level callbacks.
- `presentation/pages/**/steps/**` are page-scoped templates and must not import `presentation/blocs/*` or call `context.read/watch<...Bloc>()`.

## Guardrail script

Run architecture checks in report mode:

```sh
./scripts/atomic_guardrails.sh
```

Strict mode (opt-in):

```sh
./scripts/atomic_guardrails.sh --strict
```

JSON output:

```sh
./scripts/atomic_guardrails.sh --json
```
