import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game_draft.dart';
import 'package:mobile_table_hopping/domain/repository/catalog/catalog_repository.dart';

/// Use case for creating a new game in the catalog.
@injectable
class CreateGameUseCase {
  const CreateGameUseCase(this._repository);

  final CatalogRepository _repository;

  Future<Either<DomainException, Game>> call(GameDraft draft) {
    return _repository.createGame(draft);
  }
}
