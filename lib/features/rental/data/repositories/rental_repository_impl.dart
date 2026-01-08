import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/features/rental/data/datasources/rental_remote_datasource.dart';
import 'package:mobile_table_hopping/features/rental/data/models/rental_models.dart';
import 'package:mobile_table_hopping/features/rental/domain/entities/rental_draft.dart';
import 'package:mobile_table_hopping/features/rental/domain/repositories/rental_repository.dart';

/// Repository implementation for rental operations.
@LazySingleton(as: RentalRepository)
class RentalRepositoryImpl implements RentalRepository {
  /// Creates the repository with the remote datasource.
  RentalRepositoryImpl(this._remote);

  final RentalRemoteDatasource _remote;

  @override
  Future<void> confirmRental(RentalDraft draft) async {
    final model = RentalCreateRequestModel.fromEntity(draft);
    await _remote.createRental(model);
  }
}
