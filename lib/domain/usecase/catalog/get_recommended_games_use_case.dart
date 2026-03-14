import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/repository/catalog/catalog_repository.dart';

/// Use case for fetching recommended games for a specific game.
@injectable
class GetRecommendedGamesUseCase {
  const GetRecommendedGamesUseCase(this._repository);

  final CatalogRepository _repository;

  Future<Either<DomainException, List<Game>>> call(String gameId) {
    return _repository.getRecommendedGames(gameId);
  }
}
