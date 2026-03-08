import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart';
import 'package:mobile_table_hopping/presentation/pages/publish/steps/data_step.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/text_form_input_field.dart';

void main() {
  Widget buildSubject({
    PublicationCondition? condition,
    int formVersion = 1,
    String gameId = '',
  }) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: DataStep(
            formVersion: formVersion,
            gameId: gameId,
            description: 'Descripcion inicial',
            condition: condition,
            conditions: PublicationCondition.values,
            allGames: const <Game>[],
            filteredGames: const <Game>[],
            isLoadingGames: false,
            onGameIdChanged: (_) {},
            onGameSearchChanged: (_) {},
            onGameSearchCleared: () {},
            onDescriptionChanged: (_) {},
            onConditionChanged: (_) {},
          ),
        ),
      ),
    );
  }

  testWidgets('renders publish description with maxLength 500', (tester) async {
    await tester.pumpWidget(buildSubject());

    final descriptionField = tester.widget<TextFormInputField>(
      find.byKey(const ValueKey('publish_description_1_')),
    );

    expect(descriptionField.maxLength, 500);
  });

  testWidgets('opens condition options bottom sheet on tap', (tester) async {
    await tester.pumpWidget(buildSubject());

    final conditionSelector = find.byKey(
      const ValueKey('publish_condition_1_'),
    );

    expect(conditionSelector, findsOneWidget);

    await tester.tap(conditionSelector);
    await tester.pumpAndSettle();

    expect(find.text('Estado del juego'), findsOneWidget);
    for (final condition in PublicationCondition.values) {
      expect(find.text(condition.label), findsOneWidget);
      expect(find.text(condition.description), findsOneWidget);
    }
  });
}
