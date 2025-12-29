// Use cases are documented at a higher level; omit per-member docs.
// ignore_for_file: public_member_api_docs

import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/features/catalog/domain/entities/filters.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/repositories/game_repository.dart';

/// Use case for searching and filtering games
@injectable
class SearchGames {
  SearchGames(this._repository);

  final GameRepository _repository;

  Future<List<Game>> call({
    String? query,
    FiltersState? filters,
    String? startDate,
    String? endDate,
    SortOption sortOption = SortOption.availability,
  }) async {
    return _repository.searchGames(
      query: query,
      filters: filters,
      startDate: startDate,
      endDate: endDate,
      sortOption: sortOption,
    );
  }
}
