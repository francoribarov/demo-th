# Code Quality Review — Rental Close / Drop-Off Feature PR

**Reviewer:** code-quality-reviewer
**Scope:** 81 files, ~3232 lines changed
**Focus:** Correctness & safety, BLoC/Cubit patterns, error handling, Flutter best practices, clean architecture

---

## Findings (ordered by severity)

---

### 1. [Critical] Drop-off success never propagates to `MyRentalsBloc`

**File:** `lib/presentation/widgets/templates/my_rentals/drop_off_bottom_sheet.dart`, line 36
**Description:** `context.pop()` is called without passing `true` as the result. `showDropOffBottomSheet` returns `Future<bool?>`, and `MyRentalsList` checks `if (success != null && success)` — this condition is always false because `pop()` returns `null`. The rental card never updates to "Returned" status without a full manual refresh.
**Suggested fix:**
```dart
// Change:
context.pop();
// To:
context.pop(true);
```

---

### 2. [Critical] Domain layer depends on data-layer DTO (`RentalDropOffResponse`)

**File:** `lib/domain/repository/rental/rental_repository.dart`, line 3 & 51
**Description:** The domain-layer repository interface imports `RentalDropOffResponse` (a data DTO). This violates clean architecture's dependency rule — the domain layer must never depend on the data layer. The leak propagates to use cases, BLoC state, and widgets.
**Affected files:**
- `lib/domain/repository/rental/rental_repository.dart` (import + return type)
- `lib/domain/usecase/rental/get_drop_off_ticket_use_case.dart` (import + return type)
- `lib/presentation/blocs/my_publications/owner_rentals/owner_rentals_bloc.dart` (import)
- `lib/presentation/blocs/my_publications/owner_rentals/owner_rentals_state.dart` (field type)
- `lib/presentation/widgets/molecules/my_rentals/returned_rental_card.dart` (import + parameter)
- `lib/presentation/widgets/organisms/my_publications/owner_rentals_list.dart` (import + parameter)
- `lib/data/dto/rental/rental_drop_off_response.dart` (`toDomainModel()` returns `this`)

**Suggested fix:** Create a domain model (e.g., `DropOffTicket`) in `lib/domain/model/rental/`, update `RentalDropOffResponse.toDomainModel()` to map to it, and replace all domain/presentation references to `RentalDropOffResponse` with the new domain model.

---

### 3. [Critical] `PasswordEncryptor.encrypt()` has a race condition on lazy initialization

**File:** `lib/core/security/password_encryptor.dart`, line 20
**Description:** `_encrypter ??= await _buildEncrypter()` is not thread-safe across concurrent `async` calls. If `encrypt()` is called twice before `_buildEncrypter()` resolves (e.g., simultaneous login and register), both calls will see `_encrypter == null` and fire two network requests to `/api/auth/public-key`. The second result silently overwrites the first.
**Suggested fix:** Guard with a `Completer` or a local `Future` cache (similar to the pattern used in `RefreshInterceptor._refreshTokens`):
```dart
Future<Encrypter>? _pending;

Future<String> encrypt(String password) async {
  final encrypter = await (_pending ??= _buildEncrypter());
  final encrypted = encrypter.encryptBytes(utf8.encode(password));
  return encrypted.base64;
}
```

---

### 4. [Major] `UserRepository` throws instead of returning `Either`

**File:** `lib/domain/repository/user/user_repository.dart`, line 7
**Description:** `getUserById` returns `Future<User>` instead of `Future<Either<DomainException, User>>`, breaking the project-wide convention. The implementation (`UserRepositoryImpl`) uses `unwrapOrThrow`, forcing the use case (`GetUserByIdUseCase`) to wrap it in a try-catch to produce an `Either`. All other repositories consistently return `Either`.
**Suggested fix:** Change the interface and implementation to return `Either<DomainException, User>` using `executeDataSource`, matching the pattern in `RentalRepository`.

---

### 5. [Major] `GetOwnerRentalsUseCase` makes 3 sequential API calls that should be concurrent

**File:** `lib/domain/usecase/rental/get_owner_rentals_use_case.dart`, lines 20-37
**Description:** Three independent `getMyRentals` calls are `await`ed sequentially. This triples the loading time unnecessarily when the requests have no data dependencies on each other.
**Suggested fix:**
```dart
final results = await Future.wait([
  _repository.getMyRentals(role: 'owner', status: 'Active', ...),
  _repository.getMyRentals(role: 'owner', status: 'Accepted', ...),
  _repository.getMyRentals(role: 'owner', status: 'Returned', ...),
]);
// Then fold each result...
```

---

### 6. [Major] `PasswordEncryptor` caches the RSA key forever with no invalidation

**File:** `lib/core/security/password_encryptor.dart`, lines 16, 20
**Description:** Once `_encrypter` is built, it is cached indefinitely. If the server rotates its RSA key pair, all subsequent encryptions will use the stale key and fail. There is no TTL, retry-on-failure, or cache-busting mechanism.
**Suggested fix:** Add a TTL-based expiry (e.g., cache for 1 hour), or catch encryption/decryption failures from the server and refetch the key on a 400/401 response from the login/register endpoint.

---

### 7. [Major] `AuthBloc` catches `on Exception` without a preceding `on DomainException` clause

**File:** `lib/presentation/blocs/auth/auth_bloc.dart`, lines 87, 167, 331
**Description:** All error handlers in `AuthBloc` use `on Exception catch (e)` and defer to `_friendlyMessage()` for type discrimination. While functionally correct, this violates the project convention of catching `on DomainException catch (e)` first for explicit error handling, then `on Exception` as fallback.
**Suggested fix:**
```dart
} on DomainException catch (e) {
  emit(state.copyWith(..., errorMessage: e.message));
} on Exception catch (e) {
  emit(state.copyWith(..., errorMessage: fallbackMessage));
}
```

---

### 8. [Major] `OwnerRentalsBloc._onConfirmReturn` uses mutable variable to escape `fold`

**File:** `lib/presentation/blocs/my_publications/owner_rentals/owner_rentals_bloc.dart`, lines 94-146
**Description:** The method uses a mutable `ticketId` variable set inside a `fold` callback, then checks `if (ticketId == null) return` after the fold. This anti-pattern is fragile and makes the control flow hard to follow. Additionally, the left callback of `fold` is synchronous while the right is `async`, creating a `FutureOr<void>` return type mismatch.
**Suggested fix:** Unwrap the `Either` with `fold` that returns early on error, or use a helper like `getOrElse` / pattern matching:
```dart
final ticket = ticketResult.fold(
  (error) { emit(...); return null; },
  (ticket) => ticket,
);
if (ticket == null) return;
```

---

### 9. [Minor] `drop_off_bottom_sheet.dart` uses `Colors.red` instead of design-system color

**File:** `lib/presentation/widgets/templates/my_rentals/drop_off_bottom_sheet.dart`, line 40
**Description:** `backgroundColor: Colors.red` bypasses the project's `AppColors` design system. All other error-colored elements use `AppColors.error` or `AppColors.statusRejected`.
**Suggested fix:** Replace `Colors.red` with `AppColors.error`.

---

### 10. [Minor] `ReturnedRentalCard` uses hardcoded `Colors.purple`

**File:** `lib/presentation/widgets/molecules/my_rentals/returned_rental_card.dart`, line 39
**Description:** `Colors.purple.withValues(alpha: 0.25)` is used for the card border instead of a design token from `AppColors`. This is inconsistent with the rest of the UI.
**Suggested fix:** Use `AppColors.statusReturned.withOpacityValue(0.25)` or define a new token in `AppColors`.

---

### 11. [Minor] Inconsistent feedback pattern — `ScaffoldMessenger` vs `FeedbackMessenger`

**Files:**
- `lib/presentation/pages/my_publications/my_publications_page.dart`, lines 129-150 (direct `ScaffoldMessenger`)
- `lib/presentation/pages/my_rentals/my_rentals_page.dart`, lines 31-39 (direct `ScaffoldMessenger`)
- `lib/presentation/widgets/templates/my_rentals/drop_off_bottom_sheet.dart`, lines 38-43 (direct `ScaffoldMessenger`)

**Description:** The `_RentalRequestsTab` uses the centralized `FeedbackMessenger` helper, but `_OwnerRentalsTab`, `MyRentalsPage`, and `_DropOffContent` use `ScaffoldMessenger.of(context)` directly with inline styling. This creates inconsistent snackbar appearance and duplicated styling logic.
**Suggested fix:** Refactor all snackbar usage to use `FeedbackMessenger.showSuccess/showError/showWarning`.

---

### 12. [Minor] `SessionExpiredNotifier` never disposes its `StreamController`

**File:** `lib/core/auth/session_expired_notifier.dart`, line 11
**Description:** The broadcast `StreamController` is never closed. As a `@lazySingleton` this is acceptable in production (lives for the app lifetime), but will leak in tests if the DI container is reset without disposing the notifier.
**Suggested fix:** Implement a `dispose()` method (or `@disposeMethod` annotation from injectable) that calls `_controller.close()`.

---

### 13. [Minor] `OwnerRentalsList` — list items lack `Key`s

**File:** `lib/presentation/widgets/organisms/my_publications/owner_rentals_list.dart`, lines 59-69, 81-89, 100-108
**Description:** Items generated via `.map()` in a `ListView` do not specify a `Key`. When items are removed (e.g., after confirming a return), Flutter may incorrectly reuse widget state, causing visual glitches.
**Suggested fix:** Add `key: ValueKey(rental.id)` to each `ReturnedRentalCard` and `MyRentalCard`.

---

### 14. [Minor] `MyRentalModel.toDomainModel()` hardcodes `price: 0` and `email: ''`

**File:** `lib/data/dto/rental/my_rental_model.dart`, lines 39, 42-43
**Description:** `RentalRequestGameSummary.price` is hardcoded to `0` and `RentalRequestUserSummary.email` to `''` because the API doesn't return them. These dummy values may cause incorrect displays if the fields are ever rendered (e.g., price shown as $0).
**Suggested fix:** Make these fields nullable in `RentalRequestGameSummary`/`RentalRequestUserSummary`, or add TODO comments to track the missing API data.

---

### 15. [Minor] `DropOffBloc` has no `listenWhen` / `buildWhen` optimization in the bottom sheet

**File:** `lib/presentation/widgets/templates/my_rentals/drop_off_bottom_sheet.dart`, lines 33, 70, 81
**Description:** The `BlocListener` fires on every state change without a `listenWhen` filter, and there are two separate `BlocBuilder` widgets that rebuild independently. The listener could fire spuriously on intermediate states.
**Suggested fix:** Add `listenWhen: (prev, curr) => prev.isSuccess != curr.isSuccess || prev.errorMessage != curr.errorMessage` to the `BlocListener`.

---

### 16. [Nit] `AppTypography.bodySmall` without `const` in `ReturnedRentalCard`

**File:** `lib/presentation/widgets/molecules/my_rentals/returned_rental_card.dart`, line 210
**Description:** `Text('Sin imágenes', style: AppTypography.bodySmall)` — if `AppTypography.bodySmall` is a `const` getter, the `Text` widget could be `const`.
**Suggested fix:** Check if `const Text('Sin imágenes', style: AppTypography.bodySmall)` compiles; if so, add `const`.

---

### 17. [Nit] `RefreshInterceptor._refreshTokens` — 100ms magic delay for concurrency guard

**File:** `lib/core/network/interceptors/refresh_interceptor.dart`, lines 117-119
**Description:** A `Future.delayed(100ms)` is used to clear `_refreshing` to prevent duplicate refresh calls. The 100ms value is arbitrary and not documented. An edge case exists where a new 401 arriving during this window returns a stale (already-completed) future.
**Suggested fix:** Document the rationale for the 100ms window, or use a `Completer`-based approach that clears `_refreshing` only after all waiting callers have consumed the result.

---

## Summary

| Severity | Count |
|----------|-------|
| Critical | 3     |
| Major    | 5     |
| Minor    | 7     |
| Nit      | 2     |

**Top priority items:**
1. Fix `context.pop()` -> `context.pop(true)` in drop-off bottom sheet (breaks the drop-off flow entirely)
2. Create a domain model for `RentalDropOffResponse` to fix the clean architecture violation across 7+ files
3. Guard `PasswordEncryptor` initialization against concurrent calls
