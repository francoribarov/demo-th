import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/catalog/empty_results_state.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/common/wizard_scaffold.dart';

void main() {
  testWidgets(
    'WizardScaffold renders app bar, step indicator, body and footer',
    (
      tester,
    ) async {
      var primaryTapped = false;
      var secondaryTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: WizardScaffold(
            title: 'Wizard',
            currentStep: 1,
            steps: const ['Uno', 'Dos', 'Tres'],
            body: const Text('Body content'),
            primaryLabel: 'Continuar',
            onPrimaryPressed: () => primaryTapped = true,
            secondaryLabel: 'Atrás',
            onSecondaryPressed: () => secondaryTapped = true,
          ),
        ),
      );

      expect(find.text('Wizard'), findsOneWidget);
      expect(find.text('Body content'), findsOneWidget);
      expect(find.text('Continuar'), findsOneWidget);
      expect(find.text('Atrás'), findsOneWidget);

      await tester.tap(find.text('Atrás'));
      await tester.pump();
      expect(secondaryTapped, isTrue);

      await tester.tap(find.text('Continuar'));
      await tester.pump();
      expect(primaryTapped, isTrue);
      expect(find.byType(AppPrimaryButton), findsOneWidget);
      expect(find.byType(AppSecondaryButton), findsOneWidget);
    },
  );

  testWidgets('WizardScaffold renders inline error and loading state', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: WizardScaffold(
          title: 'Submit flow',
          currentStep: 0,
          steps: ['Uno'],
          body: SizedBox.shrink(),
          inlineErrorMessage: 'Algo salió mal',
          primaryLabel: 'Guardar',
          isSubmitting: true,
        ),
      ),
    );

    expect(find.text('Algo salió mal'), findsOneWidget);
    expect(find.byType(AppPrimaryButton), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    final saveButton = tester.widget<AppPrimaryButton>(
      find.byType(AppPrimaryButton),
    );
    expect(saveButton.onPressed, isNull);
  });

  testWidgets('EmptyResultsState keeps copy and CTA callbacks', (tester) async {
    var changeDatesTapped = false;
    var clearFiltersTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EmptyResultsState(
            onChangeDates: () => changeDatesTapped = true,
            onClearFilters: () => clearFiltersTapped = true,
          ),
        ),
      ),
    );

    expect(
      find.text('No encontramos juegos con estos filtros.'),
      findsOneWidget,
    );
    expect(
      find.text('Probá cambiar las fechas o borrar algunos filtros.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Cambiá las fechas'));
    await tester.pump();
    expect(changeDatesTapped, isTrue);

    await tester.tap(find.text('Borrá filtros'));
    await tester.pump();
    expect(clearFiltersTapped, isTrue);
  });
}
