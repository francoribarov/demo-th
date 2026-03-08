import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/errors/data/data_exception.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/core/resources/api_result.dart';
import 'package:mobile_table_hopping/data/datasource/my_publications/rental_requests_data_source.dart';
import 'package:mobile_table_hopping/data/dto/rental/my_rental_model.dart';
import 'package:mobile_table_hopping/data/repository/my_publications/rental_requests_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockRentalRequestsRemoteDataSource extends Mock
    implements RentalRequestsRemoteDataSource {}

void main() {
  late MockRentalRequestsRemoteDataSource dataSource;
  late RentalRequestsRepositoryImpl repository;

  final dataException = DataException(message: 'boom-rental', statusCode: 503);

  const tModel = MyRentalModel(
    id: 'r-1',
    publicationId: 'g-1',
    renterId: 'u-1',
    ownerId: 'owner-1',
    startDate: '2026-01-10T00:00:00.000Z',
    endDate: '2026-01-12T00:00:00.000Z',
    status: 'PENDING',
    finalPrice: 300,
    renterName: 'User',
    gameTitle: 'Chess',
  );

  setUp(() {
    dataSource = MockRentalRequestsRemoteDataSource();
    repository = RentalRequestsRepositoryImpl(dataSource);
  });

  test('getRentalRequests returns Right on success', () async {
    when(
      () => dataSource.getRentalRequests(),
    ).thenAnswer((_) async => const ApiResult.success(data: [tModel]));

    final result = await repository.getRentalRequests();

    expect(result.isRight(), isTrue);
    result.fold(
      (_) => fail('Expected Right'),
      (value) {
        expect(value.length, 1);
        expect(value.first.id, 'r-1');
      },
    );
  });

  test('getRentalRequests returns Left on failure', () async {
    when(
      () => dataSource.getRentalRequests(),
    ).thenAnswer((_) async => ApiResult.failure(dataException: dataException));

    final result = await repository.getRentalRequests();

    expect(result.isLeft(), isTrue);
    result.fold(
      (error) {
        expect(error, isA<DomainException>());
        expect(error.message, 'boom-rental');
        expect(error.statusCode, 503);
      },
      (_) => fail('Expected Left'),
    );
  });
}
