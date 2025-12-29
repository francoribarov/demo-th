import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/listing.dart';
import 'package:mobile_table_hopping/features/publish/domain/repositories/publish_repository.dart';

@injectable
/// Creates a listing via the publish repository.
class CreateListing {
  /// Creates a [CreateListing] use case.
  CreateListing(this._repository);
  final PublishRepository _repository;

  /// Executes the listing creation request.
  Future<Listing> call(ListingDraft draft) {
    return _repository.createListing(draft);
  }
}
