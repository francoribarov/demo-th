import 'package:mobile_table_hopping/domain/model/auth/user.dart';

/// Repository interface for user operations.
// ignore: one_member_abstracts
abstract class UserRepository {
  /// Fetches a user by ID from the remote data source.
  Future<User> getUserById(String id);
}
