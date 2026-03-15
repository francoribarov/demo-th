# Data Layer Review — Rental Close / Drop-Off PR

**Reviewer role:** `data-layer-reviewer`
**Scope:** Retrofit services, DTOs, DataSources, Repositories, Mappers
**Focus:** Retrofit annotations, DTO structure (`@freezed`, `fromJson`, `@JsonKey`), DataSource pattern (`getStateOf`, `ApiResult`), Repository pattern (`Either<DomainException, T>`, `executeDataSource*`), mapper correctness, `DataExceptionMapper` usage

---

## Findings

---

### 1. `[Critical]` — `RentalDropOffResponse.toDomainModel()` returns `this`, leaking a DTO into the domain layer

**File:** `lib/data/dto/rental/rental_drop_off_response.dart:26`
**Description:** `toDomainModel()` returns `this` instead of mapping to a domain model. This means the `BaseDtoResponse<RentalDropOffResponse>` contract is self-referential — the DTO *is* the domain model — and it leaks `@freezed`/`@JsonKey` annotated data-layer types through the repository interface, use case, bloc state, and into presentation widgets.
**Fix:** Create `lib/domain/model/rental/drop_off_ticket.dart` with domain-only fields (`id`, `status`, `rentalId`, `dropOffDate`, `images`, `rejectionReason`). Implement a real mapping:

```dart
@override
DropOffTicket toDomainModel() => DropOffTicket(
  id: id,
  status: status,
  rentalId: rentalId,
  dropOffDate: DateTime.parse(dropOffDate),
  images: images,
  rejectionReason: rejectionReason,
);
```

---

### 2. `[Major]` — `UserRepositoryImpl.getUserById` returns `Future<User>` instead of `Either<DomainException, User>`

**File:** `lib/data/repository/user/user_repository_impl.dart:17`
**Description:** Uses `unwrapOrThrow` and returns a bare `Future<User>`, forcing the use case to wrap it in try-catch. Every other repository (`RentalRepositoryImpl`, `UploadRepositoryImpl`) uses `executeDataSource*` helpers and returns `Either`. This breaks the established data-layer pattern and pushes error-handling responsibility to the wrong layer.
**Fix:** Change to `executeDataSource` and return `Either`:

```dart
@override
Future<Either<DomainException, User>> getUserById(String id) {
  return executeDataSource<UserModel, User>(
    function: () => _remote.getUserById(id),
  );
}
```

---

### 3. `[Major]` — `dropOffResponse` datasource builds body as raw `Map` instead of a typed DTO

**File:** `lib/data/datasource/rental/rental_data_source.dart:92-97`
**Description:** The body `{'status': status, 'ticketId': ticketId, 'rejectionReason': ?rejectionReason}` is a hand-built map with string keys. This is inconsistent with `createRental` (uses `ConfirmRentalBody.toJson()`) and `dropOffRental` (uses `DropOffBody.toJson()`). Typos in the string keys will only fail at runtime, and the body structure is not documented or validated at compile time.
**Fix:** Create a `DropOffResponseBody` freezed DTO:

```dart
@freezed
abstract class DropOffResponseBody with _$DropOffResponseBody {
  const factory DropOffResponseBody({
    required String status,
    required String ticketId,
    String? rejectionReason,
  }) = _DropOffResponseBody;

  factory DropOffResponseBody.fromJson(Map<String, dynamic> json) =>
      _$DropOffResponseBodyFromJson(json);
}
```

Then call `body.toJson()` in the datasource, matching the established pattern.

---

### 4. `[Major]` — `UploadRepositoryImpl.uploadImage` crashes on empty URL list

**File:** `lib/data/repository/upload/upload_repository_impl.dart:25`
**Description:** `(urls) => Right(urls.first)` throws an unhandled `StateError` if the server returns `{"urls": [], "message": "..."}`. The `executeDataSource` success path maps the DTO correctly, but the `.first` call is unguarded. This error would bypass the `Either` error channel entirely.
**Fix:** Guard the access:

```dart
(urls) => urls.isEmpty
    ? Left(DomainException(message: 'Upload returned no URLs'))
    : Right(urls.first),
```

---

### 5. `[Major]` — `PasswordEncryptor` uses raw `Dio` and bypasses the DataSource → Service error pipeline

**File:** `lib/core/security/password_encryptor.dart:26-31`
**Description:** `_buildEncrypter()` calls `_dio.get<Map<String, dynamic>>('/api/auth/public-key')` directly, bypassing the Retrofit service → DataSource → `getStateOf` → `ApiResult` error pipeline. If the key endpoint fails, a raw `DioException` propagates to the repository, which is not caught by the `on DomainException` handler in `GetUserByIdUseCase`-style callers. Additionally, `response.data!` force-unwraps without null check.
**Fix:** Create a Retrofit endpoint in `AuthService`, a corresponding DataSource method, and have the repository orchestrate the key fetch through the standard pipeline. At minimum, wrap the Dio call in a try-catch that produces a `DomainException`.

---

### 6. `[Minor]` — `MyRentalModel.toDomainModel()` hardcodes `price: 0` and `email: ''`

**File:** `lib/data/dto/rental/my_rental_model.dart:39,44`
**Description:** The mapper sets `RentalRequestGameSummary.price` to `0` and `RentalRequestUserSummary.email` to `''` because these fields are absent from the API response. These placeholder values silently lose information and can cause incorrect UI displays (e.g., price shown as \$0.00). The domain model's `required int price` and `required String email` force the mapper to lie.
**Fix:** Make `price` nullable (`int?`) in `RentalRequestGameSummary` and `email` nullable (`String?`) in `RentalRequestUserSummary` so consumers can distinguish "not provided" from a real zero/empty value.

---

### 7. `[Minor]` — `UploadRemoteDataSource` is not an abstract class

**File:** `lib/data/datasource/upload/upload_remote_data_source.dart:11-16`
**Description:** The base class `UploadRemoteDataSource` is concrete with `throw UnimplementedError()` in the method body. Every other datasource contract in this project (`RentalRemoteDataSource`, `UserRemoteDatasource`) uses a proper `abstract class` with abstract methods. This is inconsistent and allows accidental instantiation of the base class.
**Fix:** Make it abstract:

```dart
abstract class UploadRemoteDataSource {
  Future<ApiResult<ImageUploadResponse>> uploadImage(String filePath);
}
```

---

### 8. `[Minor]` — `AuthRepositoryImpl.refresh()` throws generic `Exception` instead of `DomainException`

**File:** `lib/data/repository/auth/auth_repository_impl.dart:72`
**Description:** `throw Exception('No refresh token available')` throws a generic `Exception`. Callers catching `on DomainException` will not handle this — it will escape as an unhandled exception. The rest of the auth repository throws `DomainException` via `unwrapOrThrow`.
**Fix:**

```dart
throw DomainException(message: 'No refresh token available');
```

---

### 9. `[Minor]` — Redundant `@JsonKey` annotations where name matches field name

**File:** `lib/data/dto/rental/rental_drop_off_response.dart:14-17`, `lib/data/dto/rental/my_rental_model.dart:23-24`
**Description:** `@JsonKey(name: 'dropOffTicketId')` on a field named `dropOffTicketId`, `@JsonKey(name: 'finalPrice')` on `finalPrice`, and similarly `@JsonKey(name: 'rentalId')`, `@JsonKey(name: 'dropOffDate')`, `@JsonKey(name: 'images')`, `@JsonKey(name: 'rejectionReason')` in `RentalDropOffResponse` — the generated key already matches the Dart field name. These annotations add noise without changing serialization behavior.
**Fix:** Remove `@JsonKey` when the `name` argument equals the field name. Keep only annotations that actually remap (e.g., `@JsonKey(name: 'delivery_methods')` in `UserModel`).

---

### 10. `[Minor]` — `MyRentalModel._parseStatus` silently defaults unknown statuses to `pending`

**File:** `lib/data/dto/rental/my_rental_model.dart:71-72`
**Description:** If the backend introduces a new status value (e.g., `OVERDUE`), `_parseStatus` silently maps it to `pending`. This makes debugging difficult — the UI will show a rental as "Pending" when it is actually in a new state the client doesn't know about.
**Fix:** Either add a `RentalRequestStatus.unknown` variant or log/report the unrecognized value before defaulting:

```dart
default:
  debugPrint('Unknown rental status: $status');
  return RentalRequestStatus.pending;
```

---

### 11. `[Nit]` — `RentalService.dropOffRental` and `dropOffResponse` accept `Map<String, dynamic>` instead of typed DTOs

**File:** `lib/data/services/rental/rental_service.dart:39,55`
**Description:** Both methods accept `@Body() Map<String, dynamic> body` at the Retrofit boundary. While the DataSource converts DTOs to maps via `.toJson()` before calling, having the Retrofit service accept the typed DTO directly (e.g., `@Body() DropOffBody body`) would let Retrofit handle serialization and provide compile-time type safety at the service layer.
**Fix:** Change signatures to accept typed DTOs. Retrofit's code generator calls `.toJson()` automatically for `@Body()` parameters that have a `toJson()` method.

---

### 12. `[Nit]` — `PasswordEncryptor` lazy init has a race condition on concurrent calls

**File:** `lib/core/security/password_encryptor.dart:20`
**Description:** `_encrypter ??= await _buildEncrypter()` is not safe across concurrent async calls. If `encrypt()` is called twice before `_buildEncrypter()` resolves, both see `_encrypter == null` and fire two network requests. The second result silently overwrites the first (functionally harmless but wasteful).
**Fix:** Cache the `Future` instead of the result:

```dart
Future<Encrypter>? _pending;

Future<String> encrypt(String password) async {
  final encrypter = await (_pending ??= _buildEncrypter());
  final encrypted = encrypter.encryptBytes(utf8.encode(password));
  return encrypted.base64;
}
```

---

## Summary

| Severity | Count | Key Theme |
|----------|-------|-----------|
| Critical | 1     | DTO leaks into domain via self-referential `toDomainModel()` |
| Major    | 4     | Repository pattern inconsistency, untyped body maps, unguarded `.first`, raw Dio in encryptor |
| Minor    | 5     | Mapper data loss, non-abstract datasource, wrong exception type, redundant annotations, silent status default |
| Nit      | 2     | Untyped Retrofit `@Body`, race condition in lazy init |

**Top priority items:**
1. Create a proper domain model for `RentalDropOffResponse` to stop the DTO leak (Finding 1)
2. Align `UserRepositoryImpl` with the `Either` return pattern (Finding 2)
3. Guard `urls.first` in `UploadRepositoryImpl` against empty lists (Finding 4)
4. Replace the raw body map in `dropOffResponse` datasource with a typed DTO (Finding 3)
