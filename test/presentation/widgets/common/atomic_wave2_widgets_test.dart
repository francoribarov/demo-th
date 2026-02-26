import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/suggestion_chip.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/info_chip.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/label_value_row.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/media_upload_tile.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/page_app_bar.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/removable_photo_tile.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/sliver_page_app_bar.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/common/tabbed_page_app_bar.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/common/bottom_sheet_shell.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/common/success_state_view.dart';

void main() {
  testWidgets('PageAppBar supports leading variants and callback', (
    tester,
  ) async {
    var backTapped = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: PageAppBar(
            title: const Text('Back'),
            onLeadingPressed: () => backTapped += 1,
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pump();
    expect(backTapped, 1);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          appBar: PageAppBar(
            title: Text('No Leading'),
            leadingType: PageAppBarLeadingType.none,
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.arrow_back), findsNothing);
  });

  testWidgets('TabbedPageAppBar renders tabs and switches tab view', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: TabbedPageAppBar(
              title: Text('Tabs'),
              tabs: [
                Tab(text: 'Uno'),
                Tab(text: 'Dos'),
              ],
            ),
            body: TabBarView(
              children: [
                Text('Tab Uno'),
                Text('Tab Dos'),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Uno'), findsOneWidget);
    expect(find.text('Dos'), findsOneWidget);
    expect(find.text('Tab Uno'), findsOneWidget);

    await tester.tap(find.text('Dos'));
    await tester.pumpAndSettle();

    expect(find.text('Tab Dos'), findsOneWidget);
  });

  testWidgets('SliverPageAppBar renders and triggers leading callback', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverPageAppBar(
                onLeadingPressed: () => tapped = true,
                background: Container(key: const Key('sliverBackground')),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 500)),
            ],
          ),
        ),
      ),
    );

    expect(find.byKey(const Key('sliverBackground')), findsOneWidget);
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pump();
    expect(tapped, isTrue);
  });

  testWidgets('SuccessStateView wires primary and secondary actions', (
    tester,
  ) async {
    var primaryTapped = false;
    var secondaryTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: SuccessStateView(
          title: 'Title',
          subtitle: 'Subtitle',
          primaryActionLabel: 'Primary',
          onPrimaryAction: () => primaryTapped = true,
          secondaryActionLabel: 'Secondary',
          onSecondaryAction: () => secondaryTapped = true,
        ),
      ),
    );

    await tester.tap(find.text('Primary'));
    await tester.pump();
    await tester.tap(find.text('Secondary'));
    await tester.pump();

    expect(primaryTapped, isTrue);
    expect(secondaryTapped, isTrue);
  });

  testWidgets('MediaUploadTile handles tap and upload state', (tester) async {
    var taps = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MediaUploadTile(
            onTap: () => taps += 1,
            title: 'Agregar foto',
          ),
        ),
      ),
    );

    await tester.tap(find.byType(MediaUploadTile));
    await tester.pump();
    expect(taps, 1);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MediaUploadTile(
            onTap: () => taps += 1,
            title: 'Agregar foto',
            isUploading: true,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(MediaUploadTile));
    await tester.pump();
    expect(taps, 1);
  });

  testWidgets('RemovablePhotoTile shows primary badge and remove callback', (
    tester,
  ) async {
    var removed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RemovablePhotoTile(
            imageUrl: 'https://example.com/photo.png',
            isPrimary: true,
            onRemove: () => removed = true,
          ),
        ),
      ),
    );

    expect(find.text('Principal'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();
    expect(removed, isTrue);
  });

  testWidgets('InfoChip and LabelValueRow render shared content', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              InfoChip(
                icon: Icons.people,
                label: '2-4',
                layout: InfoChipLayout.column,
              ),
              LabelValueRow(
                leadingIcon: Icons.sell_outlined,
                label: 'Precio',
                value: r'$100',
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('2-4'), findsOneWidget);
    expect(find.text('Precio'), findsOneWidget);
    expect(find.text(r'$100'), findsOneWidget);
    expect(find.byIcon(Icons.sell_outlined), findsOneWidget);
  });

  testWidgets('BottomSheetShell renders header, body, and sticky footer', (
    tester,
  ) async {
    var closeTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BottomSheetShell(
            title: const Text('Sheet Title'),
            trailing: IconButton(
              onPressed: () => closeTapped = true,
              icon: const Icon(Icons.close),
            ),
            body: const Text('Body Content'),
            footer: const Text('Footer Content'),
          ),
        ),
      ),
    );

    expect(find.text('Sheet Title'), findsOneWidget);
    expect(find.text('Body Content'), findsOneWidget);
    expect(find.text('Footer Content'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();
    expect(closeTapped, isTrue);
  });

  testWidgets('SuggestionChip triggers tap callback', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SuggestionChip(
            label: 'Cooperativos',
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Cooperativos'));
    await tester.pump();
    expect(tapped, isTrue);
  });
}
