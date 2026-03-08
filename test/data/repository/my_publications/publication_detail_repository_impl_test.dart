import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/errors/data/data_exception.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/core/resources/api_result.dart';
import 'package:mobile_table_hopping/data/datasource/my_publications/publication_detail_data_source.dart';
import 'package:mobile_table_hopping/data/dto/my_publications/publication_detail_model.dart';
import 'package:mobile_table_hopping/data/dto/my_publications/publication_update_body.dart';
import 'package:mobile_table_hopping/data/repository/my_publications/publication_detail_repository_impl.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_primitives.dart';
import 'package:mobile_table_hopping/domain/params/my_publications/update_publication_params.dart';
import 'package:mocktail/mocktail.dart';

class MockPublicationDetailRemoteDataSource extends Mock
    implements PublicationDetailRemoteDataSource {}

void main() {
  late MockPublicationDetailRemoteDataSource dataSource;
  late PublicationDetailRepositoryImpl repository;

  final dataException = DataException(message: 'boom', statusCode: 500);

  const tModel = PublicationDetailModel(
    id: 'p-1',
    gameId: 'g-1',
    ownerId: 'o-1',
    description: 'desc',
    condition: PublicationCondition.likeNew,
    price: 100,
    images: ['https://img.test/1.png'],
  );

  setUp(() {
    dataSource = MockPublicationDetailRemoteDataSource();
    repository = PublicationDetailRepositoryImpl(dataSource);
  });

  test('getPublicationDetail returns Right on success', () async {
    when(
      () => dataSource.getPublicationDetail('p-1'),
    ).thenAnswer((_) async => const ApiResult.success(data: tModel));

    final result = await repository.getPublicationDetail('p-1');

    expect(result.isRight(), isTrue);
    result.fold(
      (_) => fail('Expected Right'),
      (value) {
        expect(value.id, 'p-1');
        expect(value.description, 'desc');
      },
    );
  });

  test('getPublicationDetail returns Left on failure', () async {
    when(
      () => dataSource.getPublicationDetail('p-1'),
    ).thenAnswer((_) async => ApiResult.failure(dataException: dataException));

    final result = await repository.getPublicationDetail('p-1');

    expect(result.isLeft(), isTrue);
    result.fold(
      (error) {
        expect(error, isA<DomainException>());
        expect(error.message, 'boom');
        expect(error.statusCode, 500);
      },
      (_) => fail('Expected Left'),
    );
  });

  test('updatePublication returns Left on failure', () async {
    const params = UpdatePublicationParams(
      id: 'p-1',
      description: 'new',
      condition: PublicationCondition.good,
      price: 200,
      images: ['https://img.test/new.png'],
      deliveryMethodIds: ['dm-1'],
    );

    when(
      () => dataSource.updatePublication(
        'p-1',
        const PublicationUpdateBody(
          description: 'new',
          condition: PublicationCondition.good,
          price: 200,
          images: ['https://img.test/new.png'],
          deliveryMethodIds: ['dm-1'],
        ),
      ),
    ).thenAnswer((_) async => ApiResult.failure(dataException: dataException));

    final result = await repository.updatePublication(params);

    expect(result.isLeft(), isTrue);
    result.fold(
      (error) {
        expect(error, isA<DomainException>());
        expect(error.message, 'boom');
      },
      (_) => fail('Expected Left'),
    );
  });

  test('deletePublication maps success and failure', () async {
    when(
      () => dataSource.deletePublication('p-1'),
    ).thenAnswer((_) async => const ApiResult.success(data: null));

    final success = await repository.deletePublication('p-1');
    expect(success.isRight(), isTrue);

    when(
      () => dataSource.deletePublication('p-2'),
    ).thenAnswer((_) async => ApiResult.failure(dataException: dataException));

    final failure = await repository.deletePublication('p-2');
    expect(failure.isLeft(), isTrue);
  });
}
