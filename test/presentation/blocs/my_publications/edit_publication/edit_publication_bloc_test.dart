import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/core/services/image_upload_service.dart';
import 'package:mobile_table_hopping/data/dto/my_publications/publication_detail_model.dart';
import 'package:mobile_table_hopping/data/mapper/my_publications/publish_delivery_method_to_my_publications.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_detail.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_primitives.dart';
import 'package:mobile_table_hopping/domain/model/publish/delivery_method.dart'
    as publish;
import 'package:mobile_table_hopping/domain/params/my_publications/update_publication_params.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_games_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/my_publications/delete_publication_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/my_publications/get_publication_detail_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/my_publications/update_publication_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/publish/get_delivery_methods_use_case.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/edit_publication/edit_publication_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPublicationDetailUseCase extends Mock
    implements GetPublicationDetailUseCase {}

class MockUpdatePublicationUseCase extends Mock
    implements UpdatePublicationUseCase {}

class MockDeletePublicationUseCase extends Mock
    implements DeletePublicationUseCase {}

class MockGetGames extends Mock implements GetGamesUseCase {}

class MockGetDeliveryMethods extends Mock
    implements GetDeliveryMethodsUseCase {}

class MockImageUploadService extends Mock implements ImageUploadService {}

void main() {
  late MockGetPublicationDetailUseCase getPublicationDetail;
  late MockUpdatePublicationUseCase updatePublication;
  late MockDeletePublicationUseCase deletePublication;
  late MockGetGames getGames;
  late MockGetDeliveryMethods getDeliveryMethods;
  late MockImageUploadService imageUploadService;

  const tDomainPublication = PublicationDetail(
    id: 'p-1',
    gameId: 'g-1',
    ownerId: 'o-1',
    description: 'desc',
    condition: PublicationCondition.good,
    price: 100,
    images: [PublicationImage(url: 'https://img.test/1.png', type: 'gallery')],
    deliveryMethods: [
      DeliveryMethod(
        id: 'dm-1',
        deliveryType: DeliveryType.pickupInPerson,
      ),
    ],
  );

  const tGame = Game(
    id: 'g-1',
    title: 'Chess',
    description: 'desc',
    duration: 60,
    players: '2-4',
    categories: [GameCategory(id: 1, name: 'Strategy', icon: 'icon')],
    images: ['https://img.test/game.png'],
  );

  const tPublishDeliveryMethod = publish.DeliveryMethod(
    id: 'dm-1',
    deliveryType: publish.DeliveryType.pickupInPerson,
  );

  setUpAll(() {
    registerFallbackValue(const UpdatePublicationParams(id: 'fallback'));
  });

  setUp(() {
    getPublicationDetail = MockGetPublicationDetailUseCase();
    updatePublication = MockUpdatePublicationUseCase();
    deletePublication = MockDeletePublicationUseCase();
    getGames = MockGetGames();
    getDeliveryMethods = MockGetDeliveryMethods();
    imageUploadService = MockImageUploadService();

    when(() => getGames()).thenAnswer(
      (_) async => const Right<DomainException, List<Game>>([tGame]),
    );
    when(() => getDeliveryMethods()).thenAnswer(
      (_) async => const Right<DomainException, List<publish.DeliveryMethod>>([
        tPublishDeliveryMethod,
      ]),
    );
    when(() => imageUploadService.pickImageFromGallery())
        .thenAnswer((_) async => null);
    when(() => imageUploadService.pickMultipleImages())
        .thenAnswer((_) async => []);
    when(() => imageUploadService.uploadImages(any()))
        .thenAnswer((_) async => []);
  });

  EditPublicationBloc buildBloc() => EditPublicationBloc(
        getPublicationDetail: getPublicationDetail,
        updatePublication: updatePublication,
        deletePublication: deletePublication,
        getGames: getGames,
        getDeliveryMethods: getDeliveryMethods,
        imageUploadService: imageUploadService,
      );

  blocTest<EditPublicationBloc, EditPublicationState>(
    'started sets errorMessage when publication detail use case returns Left',
    build: () {
      when(() => getPublicationDetail('p-1')).thenAnswer(
        (_) async => const Left(DomainException(message: 'load failed')),
      );
      return buildBloc();
    },
    act: (bloc) => bloc.add(
      const EditPublicationEvent.started(publicationId: 'p-1'),
    ),
    expect: () => [
      const EditPublicationState(isLoading: true, publicationId: 'p-1'),
      const EditPublicationState(
        publicationId: 'p-1',
        errorMessage: 'load failed',
      ),
    ],
  );

  blocTest<EditPublicationBloc, EditPublicationState>(
    'submit sets errorMessage when update use case returns Left',
    build: () {
      when(() => updatePublication(any())).thenAnswer(
        (_) async => const Left(DomainException(message: 'update failed')),
      );
      return buildBloc();
    },
    seed: () => const EditPublicationState(
      publicationId: 'p-1',
      description: 'new desc',
      condition: PublicationCondition.good,
      price: 200,
      images: ['https://img.test/new.png'],
      deliveryMethods: [
        DeliveryMethod(
          id: 'dm-1',
          deliveryType: DeliveryType.pickupInPerson,
        ),
      ],
      hasChanges: true,
    ),
    act: (bloc) => bloc.add(const EditPublicationEvent.submit()),
    expect: () => const [
      EditPublicationState(
        publicationId: 'p-1',
        description: 'new desc',
        condition: PublicationCondition.good,
        price: 200,
        images: ['https://img.test/new.png'],
        deliveryMethods: [
          DeliveryMethod(
            id: 'dm-1',
            deliveryType: DeliveryType.pickupInPerson,
          ),
        ],
        hasChanges: true,
        isSubmitting: true,
      ),
      EditPublicationState(
        publicationId: 'p-1',
        description: 'new desc',
        condition: PublicationCondition.good,
        price: 200,
        images: ['https://img.test/new.png'],
        deliveryMethods: [
          DeliveryMethod(
            id: 'dm-1',
            deliveryType: DeliveryType.pickupInPerson,
          ),
        ],
        hasChanges: true,
        errorMessage: 'update failed',
      ),
    ],
  );

  blocTest<EditPublicationBloc, EditPublicationState>(
    'delete sets errorMessage when delete use case returns Left',
    build: () {
      when(() => deletePublication('p-1')).thenAnswer(
        (_) async => const Left(DomainException(message: 'delete failed')),
      );
      return buildBloc();
    },
    seed: () => const EditPublicationState(
      publicationId: 'p-1',
      publication: tDomainPublication,
    ),
    act: (bloc) => bloc.add(const EditPublicationEvent.delete()),
    expect: () => const [
      EditPublicationState(
        publicationId: 'p-1',
        publication: tDomainPublication,
        isDeleting: true,
      ),
      EditPublicationState(
        publicationId: 'p-1',
        publication: tDomainPublication,
        errorMessage: 'delete failed',
      ),
    ],
  );

  test('adapter converts unmigrated publish delivery model', () {
    final mapped = tPublishDeliveryMethod.toMyPublicationsModel();

    expect(mapped.id, 'dm-1');
    expect(mapped.deliveryType, DeliveryType.pickupInPerson);
  });

  test('publication detail dto maps to local domain primitives', () {
    const model = PublicationDetailModel(
      id: 'p-1',
      gameId: 'g-1',
      ownerId: 'o-1',
      description: 'desc',
      condition: PublicationCondition.likeNew,
      price: 300,
      images: ['https://img.test/1.png'],
      deliveryMethods: [
        DeliveryMethodDetailModel(
          id: 'dm-1',
          deliveryType: 'Delivery',
        ),
      ],
    );

    final domain = model.toDomainModel();

    expect(domain.condition, PublicationCondition.likeNew);
    expect(domain.images.first.url, 'https://img.test/1.png');
    expect(domain.deliveryMethods.first.deliveryType, DeliveryType.delivery);
  });
}
