// Use cases are documented at a higher level; omit per-member docs.
//

import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/repositories/game_repository.dart';

/// Use case for getting all games
@injectable
class GetGames {
  GetGames(this._repository);

  final GameRepository _repository;

  Future<List<Game>> call() async {
    return _repository.getGames();
  }

  Future<List<Game>> getAvailableToday() async {
    return _repository.getGamesAvailableToday();
  }

  /// Get a single game by ID
  Future<Game?> getById(String id) async {
    return _repository.getGameById(id);
  }

  /// Get recommended games for a specific game
  Future<List<Game>> getRecommended(String id) async {
    return _repository.getRecommendedGames(id);
  }

  Future<List<GameCategory>> getCategories() async {
    return _repository.getCategories();
  }

  Future<List<FilterShortcut>> getFilterShortcuts() async {
    return _repository.getFilterShortcuts();
  }
}
