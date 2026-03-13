import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';

/// Shared validation logic for rental date selection.
class RentalValidator {
  static const int minimumDays = 3;
  static const int maximumDays = 30;

  static const String unavailablePublicationMessage =
      'No se pudo cargar la información del juego.';
  static const String invalidFormatMessage = 'Formato de fecha inválido.';
  static const String minimumDaysMessage =
      'El alquiler mínimo es de 3 días (ej: Lun a Jue).';
  static const String maximumDaysMessage =
      'El alquiler no puede superar los 30 días.';
  static const String unavailableDatesMessage =
      'Las fechas seleccionadas no están disponibles en su totalidad.';

  /// Returns an error message if invalid, or null when valid.
  static String? validateDates({
    required PublicationListing? publication,
    required String? startDate,
    required String? endDate,
  }) {
    if (publication == null) {
      return unavailablePublicationMessage;
    }

    if (startDate == null || endDate == null) {
      return null;
    }

    final start = DateTime.tryParse(startDate);
    final end = DateTime.tryParse(endDate);

    if (start == null || end == null) {
      return invalidFormatMessage;
    }

    final durationInDays = end.difference(start).inDays + 1;
    if (durationInDays < minimumDays) {
      return minimumDaysMessage;
    }
    if (durationInDays > maximumDays) {
      return maximumDaysMessage;
    }

    if (!publication.isAvailableFor(startDate, endDate)) {
      return unavailableDatesMessage;
    }

    return null;
  }
}

/// Pricing totals for a rental quote.
class RentalPricingTotals {
  const RentalPricingTotals({
    required this.rentalDays,
    required this.subtotal,
    required this.serviceFee,
    required this.deliveryFee,
    required this.foodTotal,
    required this.total,
  });

  final int rentalDays;
  final double subtotal;
  final int serviceFee;
  final int deliveryFee;
  final int foodTotal;
  final double total;
}

/// Shared pricing calculator for rental totals.
class RentalPricingCalculator {
  static const int deliveryFlatFee = 150;
  static const int foodBundleUnitPrice = 250;
  static const double serviceFeeRate = 0.1;

  static RentalPricingTotals calculate({
    required double pricePerDay,
    required String? startDate,
    required String? endDate,
    required bool isDelivery,
    required int foodBundlesCount,
  }) {
    var rentalDays = 1;
    if (startDate != null && endDate != null) {
      final start = DateTime.tryParse(startDate);
      final end = DateTime.tryParse(endDate);
      if (start != null && end != null) {
        rentalDays = end.difference(start).inDays + 1;
        if (rentalDays < 1) rentalDays = 1;
      }
    }

    final subtotal = pricePerDay * rentalDays;
    final serviceFee = (subtotal * serviceFeeRate).round();
    final deliveryFee = isDelivery ? deliveryFlatFee : 0;
    final foodTotal = foodBundlesCount * foodBundleUnitPrice;
    final total = subtotal + serviceFee + deliveryFee + foodTotal;

    return RentalPricingTotals(
      rentalDays: rentalDays,
      subtotal: subtotal,
      serviceFee: serviceFee,
      deliveryFee: deliveryFee,
      foodTotal: foodTotal,
      total: total,
    );
  }
}
