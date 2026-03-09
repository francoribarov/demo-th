import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart';
import 'package:mobile_table_hopping/domain/validators/rental/rental_validator.dart';

void main() {
  final publication = PublicationListing(
    id: 'pub-1',
    ownerId: 'owner-1',
    gameId: 'game-1',
    title: 'Catan',
    condition: PublicationCondition.likeNew,
    price: 100,
    deposit: 50,
    createdAt: DateTime(2026),
    game: const PublicationGameData(
      players: '2-4',
      duration: 60,
      categories: [GameCategory(id: 1, name: 'Strategy', icon: 'icon')],
    ),
  );

  group('RentalValidator', () {
    test('returns null for valid range', () {
      final error = RentalValidator.validateDates(
        publication: publication,
        startDate: '2026-06-01',
        endDate: '2026-06-03',
      );

      expect(error, isNull);
    });

    test('returns minimum duration error', () {
      final error = RentalValidator.validateDates(
        publication: publication,
        startDate: '2026-06-01',
        endDate: '2026-06-01',
      );

      expect(error, RentalValidator.minimumDaysMessage);
    });
  });

  group('RentalPricingCalculator', () {
    test('calculates totals consistently', () {
      final totals = RentalPricingCalculator.calculate(
        pricePerDay: 100,
        startDate: '2026-06-01',
        endDate: '2026-06-03',
        isDelivery: true,
        foodBundlesCount: 2,
      );

      expect(totals.rentalDays, 3);
      expect(totals.subtotal, 300);
      expect(totals.serviceFee, 30);
      expect(totals.deliveryFee, 150);
      expect(totals.foodTotal, 500);
      expect(totals.total, 980);
    });
  });
}
