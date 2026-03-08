import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/domain/model/auth/user.dart';
import 'package:mobile_table_hopping/domain/repository/auth/auth_repository.dart';

@injectable
/// Use case for caching a user.
class CacheUser {
  /// Creates a [CacheUser] use case.
  CacheUser(this._repository);

  final AuthRepository _repository;

  /// Caches the user to local storage.
  Future<void> call(User user) {
    return _repository.cacheUser(user);
  }
}
