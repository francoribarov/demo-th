import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_detail.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_primitives.dart';
import 'package:mobile_table_hopping/presentation/blocs/common/publication_form_state.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/edit_publication/edit_publication_bloc.dart';
import 'package:mobile_table_hopping/presentation/pages/my_publications/edit_publication_page.dart';
import 'package:mocktail/mocktail.dart';

class MockEditPublicationBloc extends MockBloc<EditPublicationEvent, EditPublicationState>
    implements EditPublicationBloc {}

void main() {
  late MockEditPublicationBloc editPublicationBloc;

  const publication = PublicationDetail(
    id: 'p-1',
    gameId: 'g-1',
    ownerId: 'o-1',
    description: 'corto',
    condition: PublicationCondition.good,
    price: 0,
    images: [PublicationImage(url: 'https://img.test/1.png', type: 'gallery')],
    deliveryMethods: [
      DeliveryMethod(id: 'dm-1', deliveryType: DeliveryType.pickupInPerson),
    ],
  );

  const invalidLoadedState = EditPublicationState(
    publicationId: 'p-1',
    publication: publication,
    form: PublicationFormState(
      gameId: 'g-1',
      description: 'corto',
      condition: PublicationCondition.good,
      descriptionError: 'La descripción debe ser más detallada (min 10 caracteres).',
      priceError: 'El precio debe ser mayor a 0.',
    ),
  );

  setUpAll(() {
    registerFallbackValue(
      const EditPublicationEvent.started(publicationId: 'x'),
    );
    registerFallbackValue(const EditPublicationState());
  });

  setUp(() {
    editPublicationBloc = MockEditPublicationBloc();
  });

  Widget buildSubject() {
    return MaterialApp(
      home: BlocProvider<EditPublicationBloc>.value(
        value: editPublicationBloc,
        child: const EditPublicationPage(publicationId: 'p-1'),
      ),
    );
  }

  testWidgets(
    'shows preloaded field errors immediately and keeps next disabled',
    (tester) async {
      whenListen(
        editPublicationBloc,
        const Stream<EditPublicationState>.empty(),
        initialState: invalidLoadedState,
      );
      when(() => editPublicationBloc.state).thenReturn(invalidLoadedState);

      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(
        find.text('La descripción debe ser más detallada (min 10 caracteres).'),
        findsOneWidget,
      );

      final nextButton = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'Siguiente'),
      );
      expect(nextButton.onPressed, isNull);
    },
  );
}
