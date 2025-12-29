// Use cases are documented at a higher level; omit per-member docs.
// ignore_for_file: public_member_api_docs

import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/repositories/game_repository.dart';

/// Use case to get all categories and filter shortcuts
@injectable
class GetCategories {
  GetCategories(this._repository);

  final GameRepository _repository;

  Future<List<GameCategory>> call() async {
    return _repository.getCategories();
  }
}

/// Use case to get filter shortcuts
@injectable
class GetFilterShortcuts {
  GetFilterShortcuts(this._repository);

  final GameRepository _repository;

  Future<List<FilterShortcut>> call() async {
    return _repository.getFilterShortcuts();
  }
}
