import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/features/rental/domain/entities/rental_draft.dart';
import 'package:mobile_table_hopping/features/rental/domain/repositories/rental_repository.dart';

/// Use case for confirming a rental.
@injectable
class ConfirmRental {
  /// Creates the use case with a rental repository.
  ConfirmRental(this._repository);
  final RentalRepository _repository;

  /// Executes the confirmation request.
  Future<void> call(RentalDraft draft) {
    return _repository.confirmRental(draft);
  }
}
