import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';

void main() {
  testWidgets('AppPrimaryButton handles normal and loading states', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppPrimaryButton(
            label: 'Guardar',
            onPressed: () => tapped = true,
            icon: Icons.save,
            minimumSize: const Size(double.infinity, 48),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Guardar'));
    await tester.pump();
    expect(tapped, isTrue);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppPrimaryButton(
            label: 'Guardar',
            onPressed: null,
            isLoading: true,
          ),
        ),
      ),
    );

    expect(find.byType(ButtonLoadingIndicator), findsOneWidget);
    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('AppSecondaryButton supports icon and custom style', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppSecondaryButton(
            label: 'Cancelar',
            onPressed: () => tapped = true,
            icon: Icons.close,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.deepOrange,
              minimumSize: const Size(double.infinity, 48),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Cancelar'));
    await tester.pump();
    expect(tapped, isTrue);

    final button = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
    expect(button.style, isNotNull);
  });

  testWidgets('AppBarIconAction supports styled icon button', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            actions: [
              AppBarIconAction(
                icon: Icons.swap_vert,
                tooltip: 'Ordenar',
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () => tapped = true,
              ),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.byTooltip('Ordenar'));
    await tester.pump();
    expect(tapped, isTrue);
  });

  testWidgets('SurfaceCard and MediaPlaceholder render custom props', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SurfaceCard(
            clipBehavior: Clip.antiAlias,
            child: MediaPlaceholder(
              icon: Icons.image_not_supported,
              width: 40,
              height: 40,
            ),
          ),
        ),
      ),
    );

    expect(find.byType(SurfaceCard), findsOneWidget);
    expect(find.byType(MediaPlaceholder), findsOneWidget);
  });
}
