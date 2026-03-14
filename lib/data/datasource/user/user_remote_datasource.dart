import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/core/resources/api_result.dart';
import 'package:mobile_table_hopping/core/resources/base_data_source.dart';
import 'package:mobile_table_hopping/data/dto/auth/user_model.dart';
import 'package:mobile_table_hopping/data/services/user/user_service.dart';

/// Remote datasource contract for user operations.
// ignore: one_member_abstracts
abstract class UserRemoteDatasource {
  /// Fetches a user by ID.
  Future<ApiResult<UserModel>> getUserById(String id);
}

@LazySingleton(as: UserRemoteDatasource)
/// Dio-backed implementation of [UserRemoteDatasource].
class UserRemoteDatasourceImpl extends BaseDataSource
    implements UserRemoteDatasource {
  /// Creates a [UserRemoteDatasourceImpl].
  UserRemoteDatasourceImpl(this._service);

  final UserService _service;

  @override
  Future<ApiResult<UserModel>> getUserById(String id) {
    return getStateOf<UserModel>(
      request: () => _service.getUserById(id),
    );
  }
}
