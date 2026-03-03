# TableHoppingApp

TableHoppingApp is a Flutter app organized with a feature-first Clean Architecture approach.

## Architecture
Core principles:
- Features live in `lib/features/<feature>/{data,domain,presentation}`.
- Shared, platform-agnostic code lives in `lib/core/` (auth, DI, errors, network, routing, theme, utils, widgets).
- Domain stays pure Dart (no Flutter imports); data implements domain; presentation depends on domain.

Entrypoints:
- `lib/main.dart` and `lib/bootstrap.dart`.

Platforms:
- `android/`, `ios/`, `web/`.

## Docs
- [Project rules](docs/rules.md)
- [Architecture diagrams](docs/diagrams/architecture.md)

## Quick start
```sh
flutter pub get
flutter run
```

## Quality
```sh
make format
make analyze
make test
```

## Lefthook (Azure local gate)
```sh
lefthook install
lefthook run pre-push
```

The `pre-push` hook mirrors the Azure pipeline checks:
- `make format`
- `make analyze`
- `make test`

And `pre-commit` runs fast staged-file checks:
- `dart fix --apply` on staged `.dart` files (excluding generated files)
- `dart format --line-length=120` on staged `.dart` files
- `flutter analyze` for staged `.dart` files

## API configuration
The app talks to the backend at port `8000`.

Defaults:
- Android emulator: `http://10.0.2.2:8000`
- iOS simulator / Web: `http://localhost:8000`

If you run on a physical device, override the base URL:
```sh
flutter run --dart-define=API_BASE_URL=http://<your-computer-ip>:8000
```
