import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/publish/game_selector.dart';

void main() {
  const game = Game(
    id: 'game-1',
    title: 'Catan',
    description: 'Trade and build.',
    duration: 90,
    players: '3-4',
  );
  const games = [game];

  testWidgets('forwards search and selection callbacks', (tester) async {
    final searchTerms = <String>[];
    var clearCalls = 0;
    String? selectedId;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GameSelector(
            selectedGameId: null,
            allGames: games,
            filteredGames: games,
            isLoadingGames: false,
            onSearchChanged: searchTerms.add,
            onSearchCleared: () => clearCalls += 1,
            onGameSelected: (value) => selectedId = value.id,
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'cat');
    await tester.pump();

    expect(searchTerms, contains('cat'));

    await tester.tap(find.text('Catan'));
    await tester.pumpAndSettle();

    expect(selectedId, 'game-1');
    expect(clearCalls, 1);
  });

  testWidgets('shows selected game summary and allows changing selection', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GameSelector(
            selectedGameId: 'game-1',
            allGames: games,
            filteredGames: games,
            isLoadingGames: false,
            onSearchChanged: (_) {},
            onSearchCleared: () {},
            onGameSelected: (_) {},
          ),
        ),
      ),
    );

    expect(find.text('Juego seleccionado'), findsOneWidget);
    expect(find.text('Cambiar'), findsOneWidget);
  });
}
