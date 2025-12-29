import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/features/rental/domain/entities/rental_draft.dart';
import 'package:mobile_table_hopping/features/rental/domain/repositories/rental_repository.dart';

/// Stub implementation until full backend + ownership wiring is available in the app.
@LazySingleton(as: RentalRepository)
class RentalRepositoryImpl implements RentalRepository {
  @override
  Future<void> confirmRental(RentalDraft draft) async {
    // Simulate a network call.
    await Future<void>.delayed(const Duration(milliseconds: 400));
  }
}
