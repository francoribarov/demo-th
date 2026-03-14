import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';

/// Typed validation errors for rental date selection.
enum RentalDateError {
  unavailablePublication,
  invalidFormat,
  belowMinimumDays,
  aboveMaximumDays,
  unavailableDates,
}

/// Shared validation logic for rental date selection.
class RentalValidator {
  static const int minimumDays = 3;
  static const int maximumDays = 30;

  /// Returns a typed error if invalid, or null when valid.
  static RentalDateError? validateDates({
    required PublicationListing? publication,
    required String? startDate,
    required String? endDate,
  }) {
    if (publication == null) {
      return RentalDateError.unavailablePublication;
    }

    if (startDate == null || endDate == null) {
      return null;
    }

    final start = DateTime.tryParse(startDate);
    final end = DateTime.tryParse(endDate);

    if (start == null || end == null) {
      return RentalDateError.invalidFormat;
    }

    final durationInDays = end.difference(start).inDays + 1;
    if (durationInDays < minimumDays) {
      return RentalDateError.belowMinimumDays;
    }
    if (durationInDays > maximumDays) {
      return RentalDateError.aboveMaximumDays;
    }

    if (!publication.isAvailableFor(startDate, endDate)) {
      return RentalDateError.unavailableDates;
    }

    return null;
  }
}
