# Project Rules

## Structure
- Keep feature modules in `lib/features/<feature>/` with `data`, `domain`, and `presentation` subfolders.
- Shared code belongs in `lib/core/` (auth, DI, errors, network, routing, theme, utils, widgets).
- App entrypoints are `lib/main.dart` and `lib/bootstrap.dart`.
- Platform-specific code stays in `android/`, `ios/`, `web/`, `macos/`, `windows/`, and `linux/`.
- Assets live in `assets/` and must be registered in `pubspec.yaml`.

## Layering
- `domain` contains pure Dart entities, value objects, use cases, and repository interfaces (no Flutter imports).
- `data` contains models, data sources, mappers, and repository implementations.
- `presentation` contains UI widgets/pages and state management.
- Dependencies flow presentation -> domain <- data. Avoid data depending on presentation.

## Naming and Consistency
- Keep feature names consistent across folders, classes, and files (e.g., `orders`, `OrdersPage`).
- Prefer explicit, descriptive names for use cases and repositories (e.g., `FetchOrders`, `OrdersRepository`).
- Avoid duplicate concepts across features; extract shared behavior into `lib/core/` when needed.

## Dependency Injection and Network
- Register dependencies in `lib/core/di`.
- Centralize API access and interceptors in `lib/core/network`.
- Keep network DTOs and mapping logic in the `data` layer.

## Routing
- Route configuration lives in `lib/core/routing`.
- Keep feature-specific routes close to the feature when possible.

## State Management
- Keep UI state in `presentation` and expose domain interactions via use cases.
- Avoid direct data layer calls from widgets.

## Configuration
- API base URL defaults to port `8000`.
- Override with `--dart-define=API_BASE_URL=http://<your-ip>:8000` when needed.

## Testing
- Use `flutter test`.
- Place tests under `test/` mirroring `lib/` paths.
- Keep tests small and focused on behavior, not implementation details.

## Quality
- Format with `dart format --line-length=80`.
- Run `make format`, `make analyze`, and `make test` before merging changes.
- Avoid unused files or dead code; remove them if no longer needed.

## Docs and Diagrams
- Keep docs under `docs/`.
- Update docs when architecture or workflows change.
