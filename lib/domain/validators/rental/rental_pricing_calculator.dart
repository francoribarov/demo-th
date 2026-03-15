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
