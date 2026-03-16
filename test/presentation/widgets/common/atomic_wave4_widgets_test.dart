import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/button_loading_indicator.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/inline_feedback_text.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/common/feedback_messenger.dart';

void main() {
  testWidgets('InlineFeedbackText maps tones to expected colors', (
    tester,
  ) async {
    Future<void> pumpTone(InlineFeedbackTone tone, String message) {
      return tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InlineFeedbackText(
              message: message,
              tone: tone,
            ),
          ),
        ),
      );
    }

    await pumpTone(InlineFeedbackTone.error, 'error');
    var textWidget = tester.widget<Text>(find.text('error'));
    expect(textWidget.style?.color, AppColors.destructive);

    await pumpTone(InlineFeedbackTone.success, 'success');
    textWidget = tester.widget<Text>(find.text('success'));
    expect(textWidget.style?.color, AppColors.success);

    await pumpTone(InlineFeedbackTone.warning, 'warning');
    textWidget = tester.widget<Text>(find.text('warning'));
    expect(textWidget.style?.color, AppColors.gameRust);

    await pumpTone(InlineFeedbackTone.info, 'info');
    textWidget = tester.widget<Text>(find.text('info'));
    expect(textWidget.style?.color, AppColors.mutedForeground);
  });

  testWidgets('ButtonLoadingIndicator uses default and custom values', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ButtonLoadingIndicator(),
        ),
      ),
    );

    var sizeBox = tester.widget<SizedBox>(find.byType(SizedBox));
    var indicator = tester.widget<CircularProgressIndicator>(
      find.byType(CircularProgressIndicator),
    );

    expect(sizeBox.width, 18);
    expect(sizeBox.height, 18);
    expect(indicator.strokeWidth, 2);
    expect(indicator.color, Colors.white);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ButtonLoadingIndicator(
            size: 22,
            strokeWidth: 3,
            color: Colors.red,
          ),
        ),
      ),
    );

    sizeBox = tester.widget<SizedBox>(find.byType(SizedBox));
    indicator = tester.widget<CircularProgressIndicator>(
      find.byType(CircularProgressIndicator),
    );

    expect(sizeBox.width, 22);
    expect(sizeBox.height, 22);
    expect(indicator.strokeWidth, 3);
    expect(indicator.color, Colors.red);
  });

  testWidgets(
    'FeedbackMessenger shows tone-specific snackbars and replaces previous',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => FeedbackMessenger.showInfo(
                        context,
                        message: 'info-msg',
                      ),
                      child: const Text('Info'),
                    ),
                    ElevatedButton(
                      onPressed: () => FeedbackMessenger.showSuccess(
                        context,
                        message: 'success-msg',
                      ),
                      child: const Text('Success'),
                    ),
                    ElevatedButton(
                      onPressed: () => FeedbackMessenger.showError(
                        context,
                        message: 'error-msg',
                      ),
                      child: const Text('Error'),
                    ),
                    ElevatedButton(
                      onPressed: () => FeedbackMessenger.showWarning(
                        context,
                        message: 'warning-msg',
                      ),
                      child: const Text('Warning'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Info'));
      await tester.pump();
      var snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(find.text('info-msg'), findsOneWidget);
      expect(snackBar.backgroundColor, isNull);

      await tester.tap(find.text('Success'));
      await tester.pump();
      snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(find.text('success-msg'), findsOneWidget);
      expect(find.text('info-msg'), findsNothing);
      expect(snackBar.backgroundColor, AppColors.gameSage);

      await tester.tap(find.text('Error'));
      await tester.pump();
      snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(find.text('error-msg'), findsOneWidget);
      expect(snackBar.backgroundColor, AppColors.destructive);

      await tester.tap(find.text('Warning'));
      await tester.pump();
      snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(find.text('warning-msg'), findsOneWidget);
      expect(snackBar.backgroundColor, AppColors.warning);
    },
  );

  testWidgets('InlineFeedbackText error tone preserves destructive style', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: InlineFeedbackText(
            message: 'Auth failed',
          ),
        ),
      ),
    );

    final textWidget = tester.widget<Text>(find.text('Auth failed'));
    expect(textWidget.style?.color, AppColors.destructive);
    expect(textWidget.style?.fontWeight, FontWeight.w600);
  });
}
