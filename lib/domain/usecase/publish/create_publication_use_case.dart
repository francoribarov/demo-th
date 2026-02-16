import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart';
import 'package:mobile_table_hopping/domain/repository/publish/publish_repository.dart';

/// Creates a publication via the publish repository.
@injectable
class CreatePublicationUseCase {
  /// Creates a [CreatePublicationUseCase] use case.
  const CreatePublicationUseCase(this._repository);

  final PublishRepository _repository;

  /// Executes the publication creation request.
  /// [ownerId] is the ID of the authenticated user.
  Future<Either<DomainException, Publication>> call(
    PublicationDraft draft, {
    required String ownerId,
  }) {
    return _repository.createPublication(draft, ownerId: ownerId);
  }
}
