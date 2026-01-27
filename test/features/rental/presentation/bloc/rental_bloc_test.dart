import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/l10n/app_strings.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_publications.dart';
import 'package:mobile_table_hopping/features/rental/domain/usecases/confirm_rental.dart';
import 'package:mobile_table_hopping/features/rental/presentation/bloc/rental_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPublications extends Mock implements GetPublications {}

class MockConfirmRental extends Mock implements ConfirmRental {}

void main() {
  late MockGetPublications mockGetPublications;
  late MockConfirmRental mockConfirmRental;
  late RentalBloc rentalBloc;

  final tPublication = PublicationListing(
    id: '123',
    ownerId: 'owner-1',
    gameId: '1',
    title: 'Test Game',
    condition: 'like_new',
    price: 100,
    deposit: 50,
    createdAt: DateTime(2026, 1, 1),
    game: const PublicationGameData(
      players: '2-4',
      duration: 60,
      categories: [GameCategory(id: 1, name: 'Strategy', icon: 'img')],
    ),
    bookedDates: const [],
  );

  setUp(() {
    mockGetPublications = MockGetPublications();
    mockConfirmRental = MockConfirmRental();
    rentalBloc = RentalBloc(
      getPublications: mockGetPublications,
      confirmRental: mockConfirmRental,
    );

    when(() => mockGetPublications.getById(any()))
        .thenAnswer((_) async => tPublication);
  });

  tearDown(() async {
    await rentalBloc.close();
  });

  group('RentalBloc Date Validations', () {
    blocTest<RentalBloc, RentalState>(
      'should emit snackbar error when duration is less than 3 days',
      build: () => rentalBloc,
      seed: () =>
          RentalState(publication: tPublication, startDate: '2026-01-10'),
      act: (bloc) =>
          bloc.add(const RentalEvent.endDateChanged(endDate: '2026-01-11')),
      expect: () => [
        isA<RentalState>().having((s) => s.endDate, 'endDate', null).having(
              (s) => s.snackbarMessage,
              'message',
              AppStrings.rentalMinDays,
            ),
      ],
    );

    blocTest<RentalBloc, RentalState>(
      'should emit snackbar error if start date chosen has less than 3 days availability',
      build: () => rentalBloc,
      seed: () => RentalState(
        publication: tPublication.copyWith(
          bookedDates: const [
            AvailabilityRange(from: '2026-01-03', to: '2026-01-03'),
          ],
        ),
      ),
      act: (bloc) =>
          bloc.add(const RentalEvent.startDateChanged(startDate: '2026-01-01')),
      expect: () => [
        isA<RentalState>()
            .having((s) => s.startDate, 'startDate', null)
            .having(
              (s) => s.snackbarMessage,
              'message',
              AppStrings.rentalMinAvailability,
            ),
      ],
    );
    blocTest<RentalBloc, RentalState>(
      'should emit snackbar error when dates are not within availability',
      build: () => rentalBloc,
      seed: () => RentalState(
        publication: tPublication.copyWith(
          bookedDates: const [
            AvailabilityRange(from: '2026-06-01', to: '2026-06-01'),
          ],
        ),
        startDate: '2026-01-10',
      ),
      act: (bloc) =>
          bloc.add(const RentalEvent.endDateChanged(endDate: '2027-02-05')),
      expect: () => [
        isA<RentalState>().having(
          (s) => s.snackbarMessage,
          'message',
          AppStrings.rentalUnavailableRange,
        ),
      ],
    );

    blocTest<RentalBloc, RentalState>(
      'should emit snackbar error when duration exceeds 30 days',
      build: () => rentalBloc,
      seed: () => RentalState(
        publication: tPublication.copyWith(
          bookedDates: const [],
        ),
        startDate: '2026-01-01',
      ),
      act: (bloc) =>
          bloc.add(const RentalEvent.endDateChanged(endDate: '2026-02-15')),
      expect: () => [
        isA<RentalState>().having(
          (s) => s.snackbarMessage,
          'message',
          AppStrings.rentalMaxDays,
        ),
      ],
    );

    blocTest<RentalBloc, RentalState>(
      'should clear end date if start date is changed to after end date',
      build: () => rentalBloc,
      seed: () => RentalState(
        publication: tPublication,
        startDate: '2026-01-05',
        endDate: '2026-01-10',
      ),
      act: (bloc) =>
          bloc.add(const RentalEvent.startDateChanged(startDate: '2026-01-15')),
      expect: () => [
        isA<RentalState>()
            .having((s) => s.startDate, 'startDate', '2026-01-15')
            .having((s) => s.endDate, 'endDate', null)
            .having(
              (s) => s.snackbarMessage,
              'message',
              AppStrings.rentalChooseLaterEnd,
            ),
      ],
    );
  });
}
