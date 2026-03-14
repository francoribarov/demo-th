import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/section_header_block.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/common/state_feedback_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/common/confirm_action_dialog.dart';

void main() {
  testWidgets('SectionHeaderBlock renders title-only mode', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SectionHeaderBlock(title: 'Detalle'),
        ),
      ),
    );

    expect(find.text('Detalle'), findsOneWidget);
    expect(find.byType(IconButton), findsNothing);
  });

  testWidgets('SectionHeaderBlock supports title, subtitle, and trailing', (
    tester,
  ) async {
    var trailingTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SectionHeaderBlock(
            title: 'Resumen',
            subtitle: 'Detalle adicional',
            trailing: IconButton(
              onPressed: () => trailingTapped = true,
              icon: const Icon(Icons.edit),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Resumen'), findsOneWidget);
    expect(find.text('Detalle adicional'), findsOneWidget);
    expect(find.byIcon(Icons.edit), findsOneWidget);

    await tester.tap(find.byIcon(Icons.edit));
    await tester.pump();
    expect(trailingTapped, isTrue);
  });

  testWidgets(
    'ConfirmActionDialog returns false on cancel and true on confirm',
    (tester) async {
      bool? result;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        result = await ConfirmActionDialog.show(
                          context: context,
                          title: 'Descartar cambios',
                          message: '¿Seguro?',
                          confirmLabel: 'Confirmar',
                          cancelLabel: 'Cancelar',
                        );
                      },
                      child: const Text('Open Regular'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        result = await ConfirmActionDialog.show(
                          context: context,
                          title: 'Eliminar publicación',
                          message: 'Esta acción es irreversible',
                          confirmLabel: 'Eliminar',
                          cancelLabel: 'Cancelar',
                          isDestructive: true,
                        );
                      },
                      child: const Text('Open Destructive'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Regular'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(TextButton, 'Cancelar'));
      await tester.pumpAndSettle();
      expect(result, isFalse);

      await tester.tap(find.text('Open Destructive'));
      await tester.pumpAndSettle();
      final destructiveConfirmButton = tester.widget<TextButton>(
        find.widgetWithText(TextButton, 'Eliminar'),
      );
      expect(destructiveConfirmButton.style, isNotNull);

      await tester.tap(find.widgetWithText(TextButton, 'Eliminar'));
      await tester.pumpAndSettle();
      expect(result, isTrue);
    },
  );

  testWidgets('StateFeedbackView renders loading, empty, and error variants', (
    tester,
  ) async {
    var primaryTapped = false;
    var secondaryTapped = false;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: StateFeedbackView(
            variant: StateFeedbackVariant.loading,
            title: 'Cargando',
            message: 'Esperá un momento',
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Cargando'), findsOneWidget);
    expect(find.text('Esperá un momento'), findsOneWidget);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StateFeedbackView(
            variant: StateFeedbackVariant.empty,
            title: 'Sin resultados',
            message: 'Probá con otros filtros',
            icon: Icons.inbox_outlined,
            primaryActionLabel: 'Reintentar',
            onPrimaryAction: () => primaryTapped = true,
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
    await tester.tap(find.text('Reintentar'));
    await tester.pump();
    expect(primaryTapped, isTrue);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StateFeedbackView(
            variant: StateFeedbackVariant.error,
            title: 'Error',
            message: 'No se pudo cargar',
            icon: Icons.error_outline,
            secondaryActionLabel: 'Cerrar',
            onSecondaryAction: () => secondaryTapped = true,
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.error_outline), findsOneWidget);
    await tester.tap(find.text('Cerrar'));
    await tester.pump();
    expect(secondaryTapped, isTrue);
  });
}
