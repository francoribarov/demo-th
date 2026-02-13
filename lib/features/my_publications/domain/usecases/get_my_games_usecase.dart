import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/repositories/my_publications_repository.dart';

@injectable
class GetMyGamesUseCase {
  GetMyGamesUseCase(this._repository);

  final MyPublicationsRepository _repository;

  Future<List<Game>> call() {
    return _repository.getMyGames();
  }
}
