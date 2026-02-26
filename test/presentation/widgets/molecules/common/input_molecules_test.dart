import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/dropdown_form_input_field.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/numeric_input_field.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/search_input_field.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/selectable_input_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/text_form_input_field.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/text_input_field.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/time_picker_field.dart';

void main() {
  testWidgets(
    'TextFormInputField renders validator error and supports suffix',
    (
      tester,
    ) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: _PasswordFieldHarness(formKey: formKey),
          ),
        ),
      );

      await tester.tap(find.text('Validar'));
      await tester.pump();

      expect(find.text('Campo requerido'), findsOneWidget);

      await tester.tap(find.byKey(const Key('passwordVisibilityButton')));
      await tester.pump();

      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    },
  );

  testWidgets('TextInputField propagates text and shows hint/label', (
    tester,
  ) async {
    final controller = TextEditingController();
    var latestValue = '';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextInputField(
            controller: controller,
            labelText: 'Dirección',
            hintText: 'Ingresá una dirección',
            onChanged: (value) => latestValue = value,
          ),
        ),
      ),
    );

    expect(find.text('Dirección'), findsOneWidget);
    expect(find.text('Ingresá una dirección'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Calle 123');
    await tester.pump();

    expect(controller.text, 'Calle 123');
    expect(latestValue, 'Calle 123');
  });

  testWidgets('SearchInputField toggles clear button and calls callback', (
    tester,
  ) async {
    final controller = TextEditingController();
    var clearCalls = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SearchInputField(
            controller: controller,
            onClear: () {
              clearCalls += 1;
              controller.clear();
            },
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.clear), findsNothing);

    await tester.enterText(find.byType(TextField), 'catan');
    await tester.pump();

    expect(find.byIcon(Icons.clear), findsOneWidget);

    await tester.tap(find.byIcon(Icons.clear));
    await tester.pump();

    expect(clearCalls, 1);
    expect(controller.text, isEmpty);
    expect(find.byIcon(Icons.clear), findsNothing);
  });

  testWidgets('NumericInputField filters digits and emits parsed value', (
    tester,
  ) async {
    final controller = TextEditingController();
    int? latestValue;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NumericInputField(
            controller: controller,
            onChangedValue: (value) => latestValue = value,
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), '12a3');
    await tester.pump();

    expect(controller.text, '123');
    expect(latestValue, 123);
  });

  testWidgets('DropdownFormInputField validates and allows selection', (
    tester,
  ) async {
    final formKey = GlobalKey<FormState>();
    String? selected;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              body: Form(
                key: formKey,
                child: Column(
                  children: [
                    DropdownFormInputField<String>(
                      initialValue: selected,
                      hintText: 'Seleccioná una opción',
                      items: const [
                        DropdownMenuItem(value: 'one', child: Text('One')),
                        DropdownMenuItem(value: 'two', child: Text('Two')),
                      ],
                      onChanged: (value) => setState(() => selected = value),
                      validator: (value) =>
                          value == null ? 'Selección requerida' : null,
                    ),
                    ElevatedButton(
                      onPressed: () => formKey.currentState?.validate(),
                      child: const Text('Validar'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Validar'));
    await tester.pump();
    expect(find.text('Selección requerida'), findsOneWidget);

    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('One').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Validar'));
    await tester.pump();

    expect(selected, 'one');
    expect(find.text('Selección requerida'), findsNothing);
  });

  testWidgets('SelectableInputCard updates indicator and onTap', (
    tester,
  ) async {
    var isSelected = false;
    var taps = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              body: SelectableInputCard(
                isSelected: isSelected,
                title: 'Entrega',
                indicatorMode: SelectableInputIndicatorMode.check,
                onTap: () {
                  taps += 1;
                  setState(() => isSelected = !isSelected);
                },
              ),
            );
          },
        ),
      ),
    );

    expect(find.byIcon(Icons.add_circle_outline), findsOneWidget);

    await tester.tap(find.text('Entrega'));
    await tester.pump();

    expect(taps, 1);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
  });

  testWidgets('TimePickerField shows value and emits selected time', (
    tester,
  ) async {
    String? selected;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TimePickerField(
            label: 'Desde',
            value: '10:30',
            onChanged: (value) => selected = value,
          ),
        ),
      ),
    );

    expect(find.text('10:30'), findsOneWidget);

    await tester.tap(find.text('Desde'));
    await tester.pumpAndSettle();

    expect(find.byType(TimePickerDialog), findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(selected, isNotNull);
    expect(RegExp(r'^\d{2}:\d{2}$').hasMatch(selected!), isTrue);
  });
}

class _PasswordFieldHarness extends StatefulWidget {
  const _PasswordFieldHarness({required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  State<_PasswordFieldHarness> createState() => _PasswordFieldHarnessState();
}

class _PasswordFieldHarnessState extends State<_PasswordFieldHarness> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormInputField(
            obscureText: !_isVisible,
            labelText: 'Contraseña',
            suffixIcon: IconButton(
              key: const Key('passwordVisibilityButton'),
              onPressed: () => setState(() => _isVisible = !_isVisible),
              icon: Icon(
                _isVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Campo requerido';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () => widget.formKey.currentState?.validate(),
            child: const Text('Validar'),
          ),
        ],
      ),
    );
  }
}
