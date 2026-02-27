import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/publication_details/publication_details_info_header.dart';

void main() {
  const game = Game(
    id: 'game-1',
    title: 'Terraforming Mars',
    description: 'Desc',
    duration: 120,
    players: '1-5',
    rating: 4.7,
    reviewsCount: 128,
  );

  final publication = PublicationListing(
    id: 'pub-1',
    ownerId: 'owner-12345',
    gameId: 'game-1',
    title: 'Terraforming Mars Premium',
    condition: PublicationCondition.likeNew,
    price: 120,
    createdAt: DateTime(2026, 1, 2),
    game: const PublicationGameData(
      players: '1-5',
      duration: 120,
      categories: [
        GameCategory(id: 1, name: 'Estrategia', icon: 'strategy'),
      ],
      rating: 4.7,
      reviewsCount: 128,
    ),
  );

  testWidgets('PublicationDetailsInfoHeader uses publication owner data', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DefaultTabController(
          length: 2,
          child: Builder(
            builder: (context) {
              return Scaffold(
                body: PublicationDetailsInfoHeader(
                  publication: publication,
                  gameDetail: game,
                  ownerDisplayName: 'Usuario owner-12345',
                  tabController: DefaultTabController.of(context),
                  onOwnerTap: () {},
                ),
              );
            },
          ),
        ),
      ),
    );

    expect(find.text('Martín R.'), findsNothing);
    expect(find.text('Montevideo • Responde en menos de 1h'), findsNothing);
    expect(find.textContaining('owner-12345'), findsWidgets);
  });

  testWidgets('PublicationDetailsInfoHeader emits onOwnerTap callback', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: DefaultTabController(
          length: 2,
          child: Builder(
            builder: (context) {
              return Scaffold(
                body: PublicationDetailsInfoHeader(
                  publication: publication,
                  gameDetail: game,
                  ownerDisplayName: 'Usuario owner-12345',
                  tabController: DefaultTabController.of(context),
                  onOwnerTap: () => tapped = true,
                ),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.chevron_right));
    await tester.pump();

    expect(tapped, isTrue);
  });
}
