import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/features/auth/domain/entities/auth_session.dart';
import 'package:mobile_table_hopping/features/auth/domain/repositories/auth_repository.dart';

@injectable
/// Use case for registering a new user.
class Register {
  /// Creates a [Register] use case.
  Register(this._repository);

  final AuthRepository _repository;

  /// Registers a new account and returns the authenticated session.
  Future<AuthSession> call({required String email, required String password, required String username, String? location}) {
    return _repository.register(email: email, password: password, username: username, location: location);
  }
}
