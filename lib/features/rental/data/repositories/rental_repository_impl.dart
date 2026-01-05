import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/core/network/api_constants.dart';
import 'package:mobile_table_hopping/core/network/dio_client.dart';
import 'package:mobile_table_hopping/features/rental/data/models/rental_models.dart';
import 'package:mobile_table_hopping/features/rental/domain/entities/rental_draft.dart';
import 'package:mobile_table_hopping/features/rental/domain/repositories/rental_repository.dart';

/// Remote implementation that persists rentals through the API.
@LazySingleton(as: RentalRepository)
class RentalRepositoryImpl implements RentalRepository {
  /// Creates the repository with a configured HTTP client.
  RentalRepositoryImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<void> confirmRental(RentalDraft draft) async {
    final model = RentalCreateRequestModel.fromEntity(draft);
    await _dioClient.post<void>(ApiConstants.rentals, data: model.toJson());
  }
}
