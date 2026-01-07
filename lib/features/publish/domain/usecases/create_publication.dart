import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/publication.dart';
import 'package:mobile_table_hopping/features/publish/domain/repositories/publish_repository.dart';

@injectable
/// Creates a publication via the publish repository.
class CreatePublication {
  /// Creates a [CreatePublication] use case.
  CreatePublication(this._repository);
  final PublishRepository _repository;

  /// Executes the publication creation request.
  Future<Publication> call(PublicationDraft draft) {
    return _repository.createPublication(draft);
  }
}
