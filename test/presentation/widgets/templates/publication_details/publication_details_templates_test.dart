import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/publication_details/publication_details_error_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/publication_details/publication_details_tab_content.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/publication_details/publication_reviews_tab_content.dart';

void main() {
  const game = Game(
    id: 'game-1',
    title: 'Terraforming Mars',
    description: 'Desc',
    duration: 120,
    players: '1-5',
    rating: 4.7,
    reviewsCount: 1,
    difficulty: 'Medio',
    reviews: [
      GameReview(
        id: 'review-1',
        userId: 'user-1',
        rating: 5,
        comment: 'Excelente',
      ),
    ],
  );

  final publication = PublicationListing(
    id: 'pub-1',
    ownerId: 'owner-1',
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
      difficulty: 'Medio',
    ),
  );

  testWidgets('PublicationDetailsTabContent emits onViewRules callback', (
    tester,
  ) async {
    var called = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: PublicationDetailsTabContent(
              gameDetail: game,
              publication: publication,
              checkStartDate: '',
              checkEndDate: '',
              availabilityResult: null,
              recommendations: const [],
              onDateRangeSelected: (startDate, endDate) {},
              onCheckAvailability: () {},
              onViewRules: () => called = true,
              onOpenRecommendation: (_) {},
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ver reglas y tutorial'));
    await tester.pump();

    expect(called, isTrue);
  });

  testWidgets('PublicationReviewsTabContent emits onViewAllReviews callback', (
    tester,
  ) async {
    var called = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: PublicationReviewsTabContent(
              gameDetail: game,
              onViewAllReviews: () => called = true,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final button = find.text('Ver todas las reseñas');
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    expect(called, isTrue);
  });

  testWidgets('PublicationDetailsErrorView emits back and home callbacks', (
    tester,
  ) async {
    var backCalled = false;
    var homeCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: PublicationDetailsErrorView(
          errorMessage: 'Error',
          onBack: () => backCalled = true,
          onGoHome: () => homeCalled = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pump();
    expect(backCalled, isTrue);

    await tester.tap(find.text('Volver al inicio'));
    await tester.pump();
    expect(homeCalled, isTrue);
  });
}
