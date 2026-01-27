import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/features/auth/domain/entities/auth_session.dart';
import 'package:mobile_table_hopping/features/auth/domain/repositories/auth_repository.dart';

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
