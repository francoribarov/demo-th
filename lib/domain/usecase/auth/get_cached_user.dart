import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/domain/model/auth/user.dart';
import 'package:mobile_table_hopping/domain/repository/auth/auth_repository.dart';

@injectable

/// Use case for retrieving the cached user.
class GetCachedUser {
  /// Creates a [GetCachedUser] use case.
  GetCachedUser(this._repository);

  final AuthRepository _repository;

  /// Retrieves the cached user from local storage.
  User? call() {
    return _repository.getCachedUser();
  }
}
