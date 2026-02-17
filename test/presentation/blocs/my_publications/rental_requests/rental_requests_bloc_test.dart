import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request_participants.dart';
import 'package:mobile_table_hopping/domain/usecase/my_publications/accept_rental_request_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/my_publications/get_rental_requests_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/my_publications/reject_rental_request_use_case.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/rental_requests/rental_requests_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetRentalRequestsUseCase extends Mock
    implements GetRentalRequestsUseCase {}

class MockAcceptRentalRequestUseCase extends Mock
    implements AcceptRentalRequestUseCase {}

class MockRejectRentalRequestUseCase extends Mock
    implements RejectRentalRequestUseCase {}

void main() {
  late MockGetRentalRequestsUseCase getRentalRequests;
  late MockAcceptRentalRequestUseCase acceptRentalRequest;
  late MockRejectRentalRequestUseCase rejectRentalRequest;

  final tRequest = RentalRequest(
    id: 'r-1',
    game: const RentalRequestGameSummary(
      id: 'g-1',
      title: 'Chess',
      images: ['https://img.test/chess.png'],
      price: 100,
    ),
    requester: const RentalRequestUserSummary(
      id: 'u-1',
      email: 'u@test.com',
      username: 'User',
      imageUrl: 'https://img.test/user.png',
    ),
    startDate: DateTime(2026, 1, 10),
    endDate: DateTime(2026, 1, 12),
    totalPrice: 300,
    status: RentalRequestStatus.pending,
  );

  setUp(() {
    getRentalRequests = MockGetRentalRequestsUseCase();
    acceptRentalRequest = MockAcceptRentalRequestUseCase();
    rejectRentalRequest = MockRejectRentalRequestUseCase();
  });

  RentalRequestsBloc buildBloc() => RentalRequestsBloc(
        getRentalRequests,
        acceptRentalRequest,
        rejectRentalRequest,
      );

  blocTest<RentalRequestsBloc, RentalRequestsState>(
    'started emits failure when getRentalRequests returns Left',
    build: () {
      when(() => getRentalRequests()).thenAnswer(
        (_) async => const Left(DomainException(message: 'load failed')),
      );
      return buildBloc();
    },
    act: (bloc) => bloc.add(const RentalRequestsEvent.started()),
    expect: () => const [
      RentalRequestsState.loading(),
      RentalRequestsState.failure('load failed'),
    ],
  );

  blocTest<RentalRequestsBloc, RentalRequestsState>(
    'accepted keeps state and sets feedback when accept fails',
    build: () {
      when(() => acceptRentalRequest('r-1')).thenAnswer(
        (_) async => const Left(DomainException(message: 'accept failed')),
      );
      return buildBloc();
    },
    seed: () => RentalRequestsState.success([tRequest]),
    act: (bloc) => bloc.add(const RentalRequestsEvent.accepted('r-1')),
    expect: () => [
      RentalRequestsState.success(
        [tRequest],
        processingRequestId: 'r-1',
      ),
      RentalRequestsState.success(
        [tRequest],
        feedbackMessage: 'Error al procesar la solicitud',
      ),
    ],
  );

  blocTest<RentalRequestsBloc, RentalRequestsState>(
    'rejected keeps state and sets feedback when reject fails',
    build: () {
      when(() => rejectRentalRequest('r-1')).thenAnswer(
        (_) async => const Left(DomainException(message: 'reject failed')),
      );
      return buildBloc();
    },
    seed: () => RentalRequestsState.success([tRequest]),
    act: (bloc) => bloc.add(const RentalRequestsEvent.rejected('r-1')),
    expect: () => [
      RentalRequestsState.success(
        [tRequest],
        processingRequestId: 'r-1',
      ),
      RentalRequestsState.success(
        [tRequest],
        feedbackMessage: 'Error al procesar la solicitud',
      ),
    ],
  );
}
