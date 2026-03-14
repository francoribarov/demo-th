import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/data/base_repository.dart';
import 'package:mobile_table_hopping/data/datasource/user/user_remote_datasource.dart';
import 'package:mobile_table_hopping/data/dto/auth/user_model.dart';
import 'package:mobile_table_hopping/domain/model/auth/user.dart';
import 'package:mobile_table_hopping/domain/repository/user/user_repository.dart';

@LazySingleton(as: UserRepository)
/// Default implementation of [UserRepository].
class UserRepositoryImpl extends BaseRepository implements UserRepository {
  /// Creates a [UserRepositoryImpl].
  UserRepositoryImpl(this._remote);

  final UserRemoteDatasource _remote;

  @override
  Future<User> getUserById(String id) async {
    final response = await unwrapOrThrow<UserModel>(
      () => _remote.getUserById(id),
    );
    return response.toDomainModel();
  }
}
