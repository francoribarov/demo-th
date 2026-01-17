import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';
import 'package:mobile_table_hopping/features/catalog/domain/repositories/publication_repository.dart';

/// Use case for getting publication listings.
@injectable
class GetPublications {
  /// Creates a [GetPublications] use case.
  GetPublications(this._repository);

  final PublicationRepository _repository;

  /// Gets all publications with optional query filter.
  Future<List<PublicationListing>> call({String? query}) async {
    return _repository.getPublications(query: query);
  }

  /// Gets a publication by ID.
  Future<PublicationListing?> getById(String id) async {
    return _repository.getPublicationById(id);
  }

  /// Gets recommended publications based on a game ID.
  Future<List<PublicationListing>> getRecommended(String gameId) async {
    return _repository.getRecommendedPublications(gameId);
  }

  /// Gets publications available today.
  Future<List<PublicationListing>> getAvailableToday({int limit = 10}) async {
    return _repository.getPublicationsAvailableToday(limit: limit);
  }
}
