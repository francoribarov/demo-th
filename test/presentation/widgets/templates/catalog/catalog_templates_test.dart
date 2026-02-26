import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile_table_hopping/domain/model/catalog/filters.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/catalog/publication_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/catalog/discovery_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/catalog/results_view.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('es_UY');
  });

  Future<void> setLargeSurface(WidgetTester tester) async {
    tester.view
      ..physicalSize = const Size(1440, 2400)
      ..devicePixelRatio = 1;
    addTearDown(() {
      tester.view
        ..resetPhysicalSize()
        ..resetDevicePixelRatio();
    });
  }

  final publication = PublicationListing(
    id: 'pub-1',
    ownerId: 'owner-1',
    gameId: 'game-1',
    title: 'Juego Uno',
    condition: PublicationCondition.good,
    price: 120,
    createdAt: DateTime(2026),
    game: const PublicationGameData(
      players: '2-4',
      duration: 45,
      categories: [GameCategory(id: 1, name: 'CatA', icon: 'A')],
    ),
  );

  testWidgets('DiscoveryView forwards category and shortcut callbacks', (
    tester,
  ) async {
    await setLargeSurface(tester);

    String? selectedCategory;
    FilterShortcut? selectedShortcut;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DiscoveryView(
            categories: const [GameCategory(id: 10, name: 'CatA', icon: 'A')],
            filterShortcuts: const [
              FilterShortcut(
                id: 77,
                name: 'ShortA',
                icon: 'S',
                type: 'query',
                query: 'short-query',
              ),
            ],
            filteredPublications: [publication],
            availableTodayPublications: [publication],
            onRefresh: () async {},
            onCategorySelected: (value) => selectedCategory = value,
            onShortcutSelected: (value) => selectedShortcut = value,
            onSeeMoreToday: () {},
            onPublicationTap: (_) {},
            onPublicationCategoryTap: (_) {},
          ),
        ),
      ),
    );

    await tester.tap(find.text('CatA').first);
    await tester.pump();
    expect(selectedCategory, 'CatA');

    await tester.tap(find.text('ShortA'));
    await tester.pump();
    expect(selectedShortcut?.id, 77);
  });

  testWidgets('ResultsView forwards clear, publication tap and category tap', (
    tester,
  ) async {
    await setLargeSurface(tester);

    var clearTapped = false;
    PublicationListing? tappedPublication;
    String? tappedCategory;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ResultsView(
            query: 'juego',
            selectedCategory: null,
            filteredPublications: [publication],
            hasDateFilter: false,
            filters: const FiltersState(),
            sortOption: SortOption.availability,
            onClearSearch: () => clearTapped = true,
            onOpenFilters: () async {},
            onSortChanged: (_) {},
            onOpenDates: () async {},
            onRefresh: () async {},
            onPublicationTap: (value) => tappedPublication = value,
            onCategoryTap: (value) => tappedCategory = value,
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pump();
    expect(clearTapped, isTrue);

    await tester.tap(find.byType(PublicationCard).first);
    await tester.pump();
    expect(tappedPublication?.id, 'pub-1');

    await tester.ensureVisible(find.text('CatA').first);
    await tester.tap(find.text('CatA').first);
    await tester.pump();
    expect(tappedCategory, 'CatA');
  });
}
