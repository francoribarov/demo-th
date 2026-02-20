import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/domain/model/auth/auth_session.dart';
import 'package:mobile_table_hopping/domain/repository/auth/auth_repository.dart';

@injectable

/// Use case for retrieving the cached auth session.
class GetAuthStatus {
  /// Creates a [GetAuthStatus] use case.
  GetAuthStatus(this._repository);

  final AuthRepository _repository;

  /// Returns the cached authenticated session, if available.
  Future<AuthSession?> call() {
    return _repository.getAuthStatus();
  }
}
