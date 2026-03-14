import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/domain/repository/auth/auth_repository.dart';

@injectable
/// Use case for logging out the current user.
class Logout {
  /// Creates a [Logout] use case.
  Logout(this._repository);

  final AuthRepository _repository;

  /// Clears the current session.
  Future<void> call() {
    return _repository.logout();
  }
}
