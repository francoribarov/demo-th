import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/features/auth/domain/entities/auth_tokens.dart';
import 'package:mobile_table_hopping/features/auth/domain/repositories/auth_repository.dart';

@injectable

/// Use case for refreshing access tokens.
class RefreshToken {
  /// Creates a [RefreshToken] use case.
  RefreshToken(this._repository);

  final AuthRepository _repository;

  /// Refreshes the access token pair.
  Future<AuthTokens> call() {
    return _repository.refresh();
  }
}
