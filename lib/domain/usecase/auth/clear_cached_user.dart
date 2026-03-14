import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/domain/repository/auth/auth_repository.dart';

@injectable
/// Use case for clearing the cached user.
class ClearCachedUser {
  /// Creates a [ClearCachedUser] use case.
  ClearCachedUser(this._repository);

  final AuthRepository _repository;

  /// Clears the cached user from local storage.
  Future<void> call() {
    return _repository.clearCachedUser();
  }
}
