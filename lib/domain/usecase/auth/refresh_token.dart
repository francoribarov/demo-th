import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/domain/model/auth/auth_tokens.dart';
import 'package:mobile_table_hopping/domain/repository/auth/auth_repository.dart';

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
