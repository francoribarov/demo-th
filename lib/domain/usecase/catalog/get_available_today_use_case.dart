import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/domain/repository/catalog/catalog_repository.dart';

/// Use case for fetching publications available today.
@injectable
class GetAvailableTodayUseCase {
  const GetAvailableTodayUseCase(this._repository);

  final CatalogRepository _repository;

  Future<Either<DomainException, List<PublicationListing>>> call({
    int limit = 10,
  }) {
    return _repository.getPublicationsAvailableToday(limit: limit);
  }
}
