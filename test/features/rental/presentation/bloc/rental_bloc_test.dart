import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/l10n/app_strings.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';

import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_games.dart';
import 'package:mobile_table_hopping/features/rental/domain/usecases/confirm_rental.dart';
import 'package:mobile_table_hopping/features/rental/presentation/bloc/rental_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetGames extends Mock implements GetGames {}

class MockConfirmRental extends Mock implements ConfirmRental {}

void main() {
  late MockGetGames mockGetGames;
  late MockConfirmRental mockConfirmRental;
  late RentalBloc rentalBloc;

  const tGame = Game(
    id: '123',
    catalogId: 123,
    title: 'Test Game',
    categories: [GameCategory(id: 1, name: 'Strategy', icon: 'img')],
    images: ['image1.jpg'],
    rating: 4.5,
    reviewsCount: 10,
    description: '',
    duration: 60,
    players: '2-4',
    difficulty: 'Medium',
    price: 100,
    ownerId: 'owner123',
    availability: [
      AvailabilityRange(from: '2026-01-01', to: '2026-01-31'),
    ],
    rules: GameRules(videoUrl: '', ruleCompleteUrl: '', summaryRules: ''),
  );

  setUp(() {
    mockGetGames = MockGetGames();
    mockConfirmRental = MockConfirmRental();
    rentalBloc = RentalBloc(
      getGames: mockGetGames,
      confirmRental: mockConfirmRental,
    );

    when(() => mockGetGames.getById(any())).thenAnswer((_) async => tGame);
  });

  tearDown(() async {
    await rentalBloc.close();
  });

  group('RentalBloc Date Validations', () {
    blocTest<RentalBloc, RentalState>(
      'should emit snackbar error when duration is less than 3 days',
      build: () => rentalBloc,
      seed: () => const RentalState(game: tGame, startDate: '2026-01-10'),
      act: (bloc) => bloc.add(const RentalEvent.endDateChanged(endDate: '2026-01-11')),
      expect: () => [
        isA<RentalState>()
            .having((s) => s.endDate, 'endDate', null)
            .having(
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
        game: tGame.copyWith(
          availability: [
            const AvailabilityRange(from: '2026-01-01', to: '2026-01-02'),
          ],
        ),
      ),
      act: (bloc) => bloc.add(const RentalEvent.startDateChanged(startDate: '2026-01-01')),
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
      seed: () => const RentalState(game: tGame, startDate: '2026-01-10'),
      act: (bloc) => bloc.add(const RentalEvent.endDateChanged(endDate: '2026-02-05')),
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
        game: tGame.copyWith(
          availability: [
            const AvailabilityRange(from: '2026-01-01', to: '2026-03-01'),
          ],
        ),
        startDate: '2026-01-01',
      ),
      act: (bloc) => bloc.add(const RentalEvent.endDateChanged(endDate: '2026-02-15')),
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
      seed: () => const RentalState(
        game: tGame,
        startDate: '2026-01-05',
        endDate: '2026-01-10',
      ),
      act: (bloc) => bloc.add(const RentalEvent.startDateChanged(startDate: '2026-01-15')),
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
