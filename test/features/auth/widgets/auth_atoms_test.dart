import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';

void main() {
  testWidgets('AuthSubmitButton triggers callback and supports loading state', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AuthSubmitButton(
            label: 'Ingresar',
            onPressed: () => tapped = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Ingresar'));
    await tester.pump();
    expect(tapped, isTrue);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AuthSubmitButton(
            label: 'Ingresar',
            onPressed: _noop,
            isLoading: true,
          ),
        ),
      ),
    );

    expect(find.byType(ButtonLoadingIndicator), findsOneWidget);
  });

  testWidgets('AuthErrorText applies canonical top padding and message', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AuthErrorText(message: 'Credenciales inválidas'),
        ),
      ),
    );

    expect(find.text('Credenciales inválidas'), findsOneWidget);
    final padding = tester.widget<Padding>(find.byType(Padding).first);
    expect(
      padding.padding,
      const EdgeInsets.only(top: AppTheme.spacingMd),
    );
  });
}

void _noop() {}
