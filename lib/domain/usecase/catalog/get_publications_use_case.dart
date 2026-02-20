import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/domain/repository/catalog/catalog_repository.dart';

/// Use case for fetching publications with optional filters.
@injectable
class GetPublicationsUseCase {
  const GetPublicationsUseCase(this._repository);

  final CatalogRepository _repository;

  Future<Either<DomainException, List<PublicationListing>>> call({
    String? query,
    String? category,
    String? players,
    String? duration,
    int? priceMin,
    int? priceMax,
    String? startDate,
    String? endDate,
    String? sortBy,
    int page = 1,
    int limit = 100,
  }) {
    return _repository.getPublications(
      query: query,
      category: category,
      players: players,
      duration: duration,
      priceMin: priceMin,
      priceMax: priceMax,
      startDate: startDate,
      endDate: endDate,
      sortBy: sortBy,
      page: page,
      limit: limit,
    );
  }
}
