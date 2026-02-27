import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/publish/delivery_method.dart';
import 'package:mobile_table_hopping/domain/usecase/publish/create_delivery_method_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/publish/get_delivery_methods_use_case.dart';
import 'package:mobile_table_hopping/presentation/blocs/publish/delivery_method_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateDeliveryMethodUseCase extends Mock implements CreateDeliveryMethodUseCase {}

class MockGetDeliveryMethodsUseCase extends Mock implements GetDeliveryMethodsUseCase {}

class FakeDeliveryMethod extends Fake implements DeliveryMethod {}

void main() {
  late MockCreateDeliveryMethodUseCase mockCreateDeliveryMethod;
  late MockGetDeliveryMethodsUseCase mockGetDeliveryMethods;
  late DeliveryMethodBloc deliveryMethodBloc;

  const deliveryMethod = DeliveryMethod(
    id: 'dm-1',
    deliveryType: DeliveryType.delivery,
    price: 1500,
  );

  setUpAll(() {
    registerFallbackValue(FakeDeliveryMethod());
  });

  setUp(() {
    mockCreateDeliveryMethod = MockCreateDeliveryMethodUseCase();
    mockGetDeliveryMethods = MockGetDeliveryMethodsUseCase();

    deliveryMethodBloc = DeliveryMethodBloc(
      createDeliveryMethod: mockCreateDeliveryMethod,
      getDeliveryMethods: mockGetDeliveryMethods,
    );
  });

  tearDown(() async {
    await deliveryMethodBloc.close();
  });

  blocTest<DeliveryMethodBloc, DeliveryMethodState>(
    'emits contextual message when getDeliveryMethods returns domain error',
    build: () {
      when(
        () => mockGetDeliveryMethods(),
      ).thenAnswer(
        (_) async => const Left(
          DomainException(message: 'backend down'),
        ),
      );
      return deliveryMethodBloc;
    },
    act: (bloc) => bloc.add(const DeliveryMethodEvent.started()),
    expect: () => [
      const DeliveryMethodState(isLoading: true),
      const DeliveryMethodState(
        errorMessage: 'Error al cargar metodos de entrega: backend down',
      ),
    ],
  );

  blocTest<DeliveryMethodBloc, DeliveryMethodState>(
    'emits fallback message when getDeliveryMethods throws unexpectedly',
    build: () {
      when(() => mockGetDeliveryMethods()).thenThrow(Exception('unexpected'));
      return deliveryMethodBloc;
    },
    act: (bloc) => bloc.add(const DeliveryMethodEvent.started()),
    expect: () => [
      const DeliveryMethodState(isLoading: true),
      const DeliveryMethodState(
        errorMessage: 'Error inesperado al cargar metodos de entrega.',
      ),
    ],
  );

  blocTest<DeliveryMethodBloc, DeliveryMethodState>(
    'emits contextual message when createDeliveryMethod returns domain error',
    build: () {
      when(
        () => mockCreateDeliveryMethod(any()),
      ).thenAnswer(
        (_) async => const Left(
          DomainException(message: 'validation failed'),
        ),
      );
      return deliveryMethodBloc;
    },
    act: (bloc) => bloc.add(const DeliveryMethodEvent.methodCreated(deliveryMethod)),
    expect: () => [
      const DeliveryMethodState(isCreating: true),
      const DeliveryMethodState(
        errorMessage: 'Error al crear metodo de entrega: validation failed',
      ),
    ],
  );

  blocTest<DeliveryMethodBloc, DeliveryMethodState>(
    'emits fallback message when createDeliveryMethod throws unexpectedly',
    build: () {
      when(
        () => mockCreateDeliveryMethod(any()),
      ).thenThrow(Exception('unexpected'));
      return deliveryMethodBloc;
    },
    act: (bloc) => bloc.add(const DeliveryMethodEvent.methodCreated(deliveryMethod)),
    expect: () => [
      const DeliveryMethodState(isCreating: true),
      const DeliveryMethodState(
        errorMessage: 'Error inesperado al crear metodo de entrega.',
      ),
    ],
  );
}
