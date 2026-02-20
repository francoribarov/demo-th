import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/domain/repository/catalog/catalog_repository.dart';

/// Use case for fetching a single publication by ID.
@injectable
class GetPublicationByIdUseCase {
  const GetPublicationByIdUseCase(this._repository);

  final CatalogRepository _repository;

  Future<Either<DomainException, PublicationListing>> call(String id) {
    return _repository.getPublicationById(id);
  }
}
