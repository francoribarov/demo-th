import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/auth/user.dart';
import 'package:mobile_table_hopping/domain/repository/user/user_repository.dart';

/// Use case for fetching a user by ID.
@injectable
class GetUserByIdUseCase {
  const GetUserByIdUseCase(this._repository);

  final UserRepository _repository;

  Future<Either<DomainException, User>> call(String id) async {
    try {
      final user = await _repository.getUserById(id);
      return Right(user);
    } on DomainException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DomainException(message: e.toString()));
    }
  }
}
