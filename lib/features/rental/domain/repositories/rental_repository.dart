import 'package:mobile_table_hopping/features/rental/domain/entities/rental_draft.dart';

/// Contract for rental operations.
// Single method keeps the domain boundary stable even if more ops are added later.
// ignore: one_member_abstracts
abstract class RentalRepository {
  /// Confirms a rental using the provided draft data.
  Future<void> confirmRental(RentalDraft draft);
}
