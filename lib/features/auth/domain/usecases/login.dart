import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/features/auth/domain/entities/auth_session.dart';
import 'package:mobile_table_hopping/features/auth/domain/repositories/auth_repository.dart';

@injectable
/// Use case for authenticating with email and password.
class Login {
  /// Creates a [Login] use case.
  Login(this._repository);

  final AuthRepository _repository;

  /// Executes the login and returns the authenticated session.
  Future<AuthSession> call({required String email, required String password}) {
    return _repository.login(email: email, password: password);
  }
}
