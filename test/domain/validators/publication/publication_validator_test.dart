import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart';
import 'package:mobile_table_hopping/domain/validators/publication/publication_validator.dart';

void main() {
  group('PublicationValidator', () {
    group('validateDescription', () {
      test('returns error when empty', () {
        final r = PublicationValidator.validateDescription('');
        expect(r, PublicationDescriptionError.required);
      });

      test('returns error when too short', () {
        final r = PublicationValidator.validateDescription('corto');
        expect(r, PublicationDescriptionError.tooShort);
      });

      test('returns null when meets minimum', () {
        final r = PublicationValidator.validateDescription(
          'Descripción válida.',
        );
        expect(r, isNull);
      });
    });

    group('validateCondition', () {
      test('returns error when null', () {
        final r = PublicationValidator.validateCondition(null);
        expect(r, PublicationConditionError.required);
      });

      test('returns null when provided', () {
        final r = PublicationValidator.validateCondition(
          PublicationCondition.likeNew,
        );
        expect(r, isNull);
      });
    });

    group('validatePricing', () {
      test('returns error when zero or negative', () {
        expect(
          PublicationValidator.validatePricing(0),
          PublicationPriceError.mustBePositive,
        );
        expect(
          PublicationValidator.validatePricing(-10),
          PublicationPriceError.mustBePositive,
        );
      });

      test('returns null when positive', () {
        final r = PublicationValidator.validatePricing(1500);
        expect(r, isNull);
      });
    });
  });
}
