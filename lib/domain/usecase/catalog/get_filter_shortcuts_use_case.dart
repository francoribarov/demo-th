import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/repository/catalog/catalog_repository.dart';

/// Use case for fetching filter shortcuts.
@injectable
class GetFilterShortcutsUseCase {
  const GetFilterShortcutsUseCase(this._repository);

  final CatalogRepository _repository;

  Future<Either<DomainException, List<FilterShortcut>>> call() {
    return _repository.getFilterShortcuts();
  }
}
