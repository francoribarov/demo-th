import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/catalog/filters.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/repository/catalog/catalog_repository.dart';

/// Use case for searching games with optional filters.
@injectable
class SearchGamesUseCase {
  const SearchGamesUseCase(this._repository);

  final CatalogRepository _repository;

  Future<Either<DomainException, List<Game>>> call({
    String? query,
    FiltersState? filters,
    String? startDate,
    String? endDate,
    SortOption sortOption = SortOption.availability,
  }) {
    return _repository.searchGames(
      query: query,
      filters: filters,
      startDate: startDate,
      endDate: endDate,
      sortOption: sortOption,
    );
  }
}
