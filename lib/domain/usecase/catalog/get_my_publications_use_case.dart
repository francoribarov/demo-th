import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/domain/repository/catalog/catalog_repository.dart';

/// Use case for fetching the current user's publications.
@injectable
class GetMyPublicationsUseCase {
  const GetMyPublicationsUseCase(this._repository);

  final CatalogRepository _repository;

  Future<Either<DomainException, List<PublicationListing>>> call() {
    return _repository.getMyPublications();
  }
}
