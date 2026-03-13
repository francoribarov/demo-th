import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/domain/validators/optional_date_range_validator.dart';

void main() {
  group('OptionalDateRangeValidator', () {
    test('returns null when both dates are omitted', () {
      final result = OptionalDateRangeValidator.validate(
        startDate: null,
        endDate: null,
      );
      expect(result, isNull);
    });

    test('returns pair error when only one date is set', () {
      final result = OptionalDateRangeValidator.validate(
        startDate: '2026-06-01',
        endDate: null,
      );
      expect(result, OptionalDateRangeValidator.missingPairMessage);
    });

    test('returns order error when end is not after start', () {
      final result = OptionalDateRangeValidator.validate(
        startDate: '2026-06-05',
        endDate: '2026-06-05',
      );
      expect(result, OptionalDateRangeValidator.invalidOrderMessage);
    });

    test('returns null when valid range is provided', () {
      final result = OptionalDateRangeValidator.validate(
        startDate: '2026-06-01',
        endDate: '2026-06-03',
      );
      expect(result, isNull);
    });
  });
}
