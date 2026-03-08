import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart';
import 'package:mobile_table_hopping/domain/params/rental/confirm_rental_params.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_publication_by_id_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/rental/confirm_rental_use_case.dart';
import 'package:mobile_table_hopping/presentation/blocs/common/feedback_notice.dart';
import 'package:mobile_table_hopping/presentation/blocs/rental/rental_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPublicationById extends Mock
    implements GetPublicationByIdUseCase {}

class MockConfirmRentalUseCase extends Mock implements ConfirmRentalUseCase {}

class FakeConfirmRentalParams extends Fake implements ConfirmRentalParams {}

void main() {
  late MockGetPublicationById mockGetPublicationById;
  late MockConfirmRentalUseCase mockConfirmRentalUseCase;
  late RentalBloc rentalBloc;

  final tPublication = PublicationListing(
    id: '123',
    ownerId: 'owner-1',
    gameId: '1',
    title: 'Test Game',
    condition: PublicationCondition.likeNew,
    price: 100,
    deposit: 50,
    createdAt: DateTime(2026),
    game: const PublicationGameData(
      players: '2-4',
      duration: 60,
      categories: [GameCategory(id: 1, name: 'Strategy', icon: 'img')],
    ),
  );

  setUp(() {
    registerFallbackValue(FakeConfirmRentalParams());
    mockGetPublicationById = MockGetPublicationById();
    mockConfirmRentalUseCase = MockConfirmRentalUseCase();
    rentalBloc = RentalBloc(
      getPublicationById: mockGetPublicationById,
      confirmRentalUseCase: mockConfirmRentalUseCase,
    );

    when(() => mockGetPublicationById(any())).thenAnswer(
      (_) async => Right<DomainException, PublicationListing>(tPublication),
    );
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
        isA<RentalState>()
            .having((s) => s.endDate, 'endDate', null)
            .having(
              (s) => s.feedbackNotice,
              'message',
              const FeedbackNotice(
                message: 'El alquiler mínimo es de 3 días (ej: Lun a Jue).',
                severity: FeedbackSeverity.warning,
              ),
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
              (s) => s.feedbackNotice,
              'message',
              const FeedbackNotice(
                message: 'El juego debe estar disponible por al menos 3 días.',
                severity: FeedbackSeverity.warning,
              ),
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
        startDate: '2026-05-25',
      ),
      act: (bloc) =>
          bloc.add(const RentalEvent.endDateChanged(endDate: '2026-06-05')),
      expect: () => [
        isA<RentalState>().having(
          (s) => s.feedbackNotice,
          'message',
          const FeedbackNotice(
            message:
                'Las fechas seleccionadas no están disponibles en su totalidad.',
            severity: FeedbackSeverity.warning,
          ),
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
          (s) => s.feedbackNotice,
          'message',
          const FeedbackNotice(
            message: 'El alquiler no puede superar los 30 días.',
            severity: FeedbackSeverity.warning,
          ),
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
              (s) => s.feedbackNotice,
              'message',
              const FeedbackNotice(
                message: 'Elegí una fecha de fin posterior al inicio.',
                severity: FeedbackSeverity.warning,
              ),
            ),
      ],
    );
  });

  group('RentalBloc Feedback Severity', () {
    blocTest<RentalBloc, RentalState>(
      'emits error severity feedback when rental submission fails',
      build: () {
        when(() => mockConfirmRentalUseCase(any())).thenAnswer(
          (_) async => const Left(DomainException(message: 'submit failed')),
        );
        return rentalBloc;
      },
      seed: () => RentalState(
        publication: tPublication,
        startDate: '2026-06-01',
        endDate: '2026-06-03',
      ),
      act: (bloc) => bloc.add(const RentalEvent.submitted()),
      expect: () => [
        isA<RentalState>()
            .having((s) => s.isSubmitting, 'isSubmitting', true)
            .having((s) => s.feedbackNotice, 'feedbackNotice', null),
        isA<RentalState>()
            .having((s) => s.isSubmitting, 'isSubmitting', false)
            .having(
              (s) => s.feedbackNotice,
              'feedbackNotice',
              const FeedbackNotice(
                message:
                    'No se pudo enviar la solicitud de alquiler.: submit failed',
                severity: FeedbackSeverity.error,
              ),
            ),
      ],
    );
  });

  group('RentalBloc Price Calculations', () {
    blocTest<RentalBloc, RentalState>(
      'should calculate 3 days rental price correctly',
      build: () => rentalBloc,
      seed: () => RentalState(publication: tPublication),
      act: (bloc) => bloc
        ..add(const RentalEvent.startDateChanged(startDate: '2026-06-01'))
        ..add(const RentalEvent.endDateChanged(endDate: '2026-06-03')),
      skip: 1, // Skip start date change
      expect: () => [
        isA<RentalState>()
            .having((s) => s.rentalDays, 'rentalDays', 3)
            .having((s) => s.subtotal, 'subtotal', 300.0) // 100 * 3
            .having((s) => s.serviceFee, 'serviceFee', 30) // 300 * 0.1
            .having((s) => s.foodTotal, 'foodTotal', 0)
            .having((s) => s.deliveryFee, 'deliveryFee', 0)
            .having((s) => s.total, 'total', 330.0), // 300 + 30
      ],
    );

    blocTest<RentalBloc, RentalState>(
      'should include delivery fee when delivery is selected',
      build: () => rentalBloc,
      seed: () => RentalState(
        publication: tPublication,
        startDate: '2026-06-01',
        endDate: '2026-06-03',
        rentalDays: 3,
        subtotal: 300,
        serviceFee: 30,
        total: 330,
      ),
      act: (bloc) =>
          bloc.add(const RentalEvent.deliveryChanged(isDelivery: true)),
      expect: () => [
        isA<RentalState>()
            .having((s) => s.isDelivery, 'isDelivery', true)
            .having((s) => s.deliveryFee, 'deliveryFee', 150)
            .having((s) => s.total, 'total', 480.0), // 330 + 150
      ],
    );

    blocTest<RentalBloc, RentalState>(
      'should include food bundles in total',
      build: () => rentalBloc,
      seed: () => RentalState(
        publication: tPublication,
        startDate: '2026-06-01',
        endDate: '2026-06-03',
        rentalDays: 3,
        subtotal: 300,
        serviceFee: 30,
        total: 330,
      ),
      act: (bloc) => bloc.add(
        const RentalEvent.foodBundlesChanged(foodBundles: ['classic', 'sweet']),
      ),
      expect: () => [
        isA<RentalState>()
            .having((s) => s.selectedFoodBundles.length, 'bundles count', 2)
            .having((s) => s.foodTotal, 'foodTotal', 500) // 2 * 250
            .having((s) => s.total, 'total', 830.0), // 330 + 500
      ],
    );
  });
}
