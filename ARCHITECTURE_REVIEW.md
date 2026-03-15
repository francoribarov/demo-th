# Architecture Review — Rental Close / Drop-Off PR

**Reviewer role:** `architecture-reviewer`
**PR scope:** 81 files, ~3232 lines — rental close/drop-off, session expiry, password encryption, navigation restructuring

---

## Findings (ordered by severity)

### 1. `[Critical]` — Data-layer DTO leaks into domain layer

**File:** `lib/domain/repository/rental/rental_repository.dart:3`
```
import 'package:mobile_table_hopping/data/dto/rental/rental_drop_off_response.dart';
```

**Description:** `RentalRepository` (a domain-layer contract) imports `RentalDropOffResponse` from `data/dto/`. This violates the foundational Clean Architecture rule that `domain/` must never depend on `data/`. The DTO carries JSON annotations, `BaseDtoResponse`, and serialisation concerns that have no place in the domain layer.

**Suggested fix:** Create a domain model (e.g. `lib/domain/model/rental/drop_off_ticket.dart`) with only domain-relevant fields. Map from the DTO to this model inside the data-layer repository implementation. Update the repository contract and the use case to reference the new domain model instead.

---

### 2. `[Critical]` — Use case imports data-layer DTO

**File:** `lib/domain/usecase/rental/get_drop_off_ticket_use_case.dart:4`
```
import 'package:mobile_table_hopping/data/dto/rental/rental_drop_off_response.dart';
```

**Description:** `GetDropOffTicketUseCase` lives in `domain/` but depends on a `data/dto` class. This is a direct `domain → data` dependency violation, identical to Finding 1, and propagates the DTO leak further across the domain boundary.

**Suggested fix:** Same as Finding 1 — replace `RentalDropOffResponse` with a pure domain model and perform the mapping in the data layer.

---

### 3. `[Critical]` — Data-layer DTO leaks through bloc state into UI widgets

**Files:**
- `lib/presentation/blocs/my_publications/owner_rentals/owner_rentals_bloc.dart:4`
- `lib/presentation/blocs/my_publications/owner_rentals/owner_rentals_state.dart:9`
- `lib/presentation/widgets/organisms/my_publications/owner_rentals_list.dart:5`
- `lib/presentation/widgets/molecules/my_rentals/returned_rental_card.dart`

**Description:** `RentalDropOffResponse` (a DTO with `fromJson`, `BaseDtoResponse`, and codegen annotations) is surfaced all the way from the bloc state into organism and molecule widgets. Presentation-layer widgets should never reference `data/dto/` types directly; they should operate on domain models.

**Suggested fix:** After creating the domain model in Finding 1, update the bloc state, organism, and molecule to use it instead of the DTO.

---

### 4. `[Major]` — Organism imports and directly reads bloc (Atomic Design violation)

**File:** `lib/presentation/widgets/organisms/my_publications/owner_rentals_list.dart:7,45`
```
import '.../owner_rentals_bloc.dart';
...
context.read<OwnerRentalsBloc>().add(const OwnerRentalsEvent.refresh());
```

**Description:** `OwnerRentalsList` is an organism that imports `OwnerRentalsBloc` and calls `context.read<OwnerRentalsBloc>()`. Organisms must be bloc-agnostic; state management orchestration belongs in pages.

**Suggested fix:** Accept an `onRefresh` callback (e.g. `Future<void> Function()`) as a constructor parameter. Wire the bloc call at the page level where the `BlocProvider` is declared.

---

### 5. `[Major]` — Organism imports and directly reads bloc (Atomic Design violation)

**File:** `lib/presentation/widgets/organisms/my_rentals/my_rentals_list.dart:5,22,35`
```
import '.../my_rentals_bloc.dart';
...
context.read<MyRentalsBloc>().add(const MyRentalsEvent.refresh());
context.read<MyRentalsBloc>().add(MyRentalsEvent.dropOffSuccess(rental.id));
```

**Description:** `MyRentalsList` is an organism that imports `MyRentalsBloc` and calls `context.read` in two places. This couples the organism to a specific bloc, breaking Atomic Design rules.

**Suggested fix:** Add `onRefresh` and `onDropOffSuccess(String id)` callbacks to the widget's constructor. Bind bloc dispatch at the page level.

---

### 6. `[Major]` — Organism imports and directly reads bloc (Atomic Design violation)

**File:** `lib/presentation/widgets/organisms/my_rentals/my_rentals_error_state.dart:3,29`
```
import '.../my_rentals_bloc.dart';
...
context.read<MyRentalsBloc>().add(const MyRentalsEvent.refresh());
```

**Description:** `MyRentalsErrorState` is an organism that directly dispatches a bloc event. This makes the widget non-reusable and tightly coupled to `MyRentalsBloc`.

**Suggested fix:** Accept a `VoidCallback onRetry` parameter instead of accessing the bloc directly. Wire the callback from the page.

---

### 7. `[Major]` — Template imports bloc, reads bloc, and performs direct navigation

**File:** `lib/presentation/widgets/templates/my_rentals/drop_off_bottom_sheet.dart:9,19-21,36,70-77,81-89`
```
import '.../drop_off_bloc.dart';
import 'package:go_router/go_router.dart';
...
create: (context) => getIt<DropOffBloc>(),
...
context.pop();
...
context.read<DropOffBloc>().add(...)
```

**Description:** `drop_off_bottom_sheet.dart` is placed under `templates/` but creates its own `BlocProvider`, calls `context.read<DropOffBloc>()` in multiple places, and calls `context.pop()` directly via `go_router`. Templates must not own bloc creation, read blocs, or perform navigation — all three are page-level responsibilities.

**Suggested fix:** Move bloc provision and the `showModalBottomSheet` orchestration to the page. Convert `_DropOffContent` to accept callbacks (`onPickImage`, `onSubmit`, `onDismiss`) and state fields (`imagePath`, `isSubmitting`, `errorMessage`) as constructor parameters. Replace `context.pop()` with an `onDismiss` callback.

---

### 8. `[Major]` — `UserRepository` throws raw exceptions instead of returning `Either`

**File:** `lib/domain/repository/user/user_repository.dart:7`
```dart
Future<User> getUserById(String id);
```

**Description:** Unlike `RentalRepository`, `UserRepository.getUserById` returns a bare `Future<User>`, letting implementation-level exceptions bubble uncaught. The project convention (evidenced by `RentalRepository`) is to return `Either<DomainException, T>` for explicit error handling.

**Suggested fix:** Change the signature to `Future<Either<DomainException, User>> getUserById(String id)` and wrap errors in the implementation via `safeApiCall` or equivalent. Update all consumers.

---

### 9. `[Minor]` — `PasswordEncryptor` makes HTTP calls but lives in `core/security/`

**File:** `lib/core/security/password_encryptor.dart:1-33`

**Description:** `PasswordEncryptor` depends on `DioClient` and fetches a key from `/api/auth/public-key`. This makes it a data-layer concern disguised as a cross-cutting utility. `core/` should contain pure utilities, constants, and framework-agnostic helpers — not HTTP-calling services.

**Suggested fix:** Move the class to `lib/data/security/password_encryptor.dart` (or `lib/data/datasource/auth/`). Keep only a pure encryption interface in `core/` or `domain/` if an abstraction is needed.

---

### 10. `[Minor]` — `User.email` changed from required to `@Default('')` without migration guard

**File:** `lib/domain/model/auth/user.dart:14`
```dart
@Default('') String email,
```

**Description:** Changing `email` from required to defaulting to empty string is a silent contract change that may cause downstream consumers (login screens, profile displays, email-dependent logic) to silently receive empty strings instead of failing fast when data is missing.

**Suggested fix:** Audit all 11+ consumers of `User.email`. If empty email is a legitimate state (e.g. social login), add a `hasEmail` getter or make it `String?` so consumers can distinguish "no email" from "empty email".

---

### 11. `[Nit]` — `RentalDropOffResponse.toDomainModel()` returns `this`

**File:** `lib/data/dto/rental/rental_drop_off_response.dart:26-27`
```dart
@override
RentalDropOffResponse toDomainModel() => this;
```

**Description:** `toDomainModel()` returning `this` confirms no domain model exists for drop-off tickets. The `BaseDtoResponse` contract is satisfied trivially, which defeats its purpose and reinforces the DTO leak into domain/presentation layers.

**Suggested fix:** Create a proper domain model and implement a real mapping here.

---

## Summary

| Severity | Count | Key Theme |
|----------|-------|-----------|
| Critical | 3     | Data DTO leaks into domain & presentation layers |
| Major    | 5     | Atomic Design violations (bloc in organisms/templates), inconsistent error handling |
| Minor    | 2     | Misplaced infra class, silent contract change |
| Nit      | 1     | No-op domain mapping |
