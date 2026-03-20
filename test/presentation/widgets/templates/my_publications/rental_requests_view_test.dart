import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request_participants.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/my_publications/rental_requests_view.dart';

void main() {
  final request = RentalRequest(
    id: 'req-1',
    game: const RentalRequestGameSummary(
      id: 'game-1',
      title: 'Chess',
      price: 100,
    ),
    requester: const RentalRequestUserSummary(
      id: 'user-1',
      email: 'user@test.com',
      username: 'Alice',
    ),
    startDate: DateTime(2026, 1, 10),
    endDate: DateTime(2026, 1, 12),
    totalPrice: 300,
    status: RentalRequestStatus.pending,
  );

  final overlappingRequest = RentalRequest(
    id: 'req-2',
    game: const RentalRequestGameSummary(
      id: 'game-1',
      title: 'Chess',
      price: 100,
    ),
    requester: const RentalRequestUserSummary(
      id: 'user-2',
      email: 'bob@test.com',
      username: 'Bob',
    ),
    startDate: DateTime(2026, 1, 11),
    endDate: DateTime(2026, 1, 14),
    totalPrice: 400,
    status: RentalRequestStatus.pending,
  );

  testWidgets('shows loading state', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RentalRequestsView(
            isLoading: true,
            requests: const [],
            processingRequestId: null,
            onAcceptRequest: (_) {},
            onRejectRequest: (_) {},
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
    'confirms and forwards accept callback via bottom sheet',
    (tester) async {
      String? acceptedId;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RentalRequestsView(
              isLoading: false,
              requests: [request],
              processingRequestId: null,
              onAcceptRequest: (id) => acceptedId = id,
              onRejectRequest: (_) {},
            ),
          ),
        ),
      );

      await tester.tap(find.text('Aceptar').first);
      await tester.pumpAndSettle();

      // Sheet CTA is also "Aceptar" — find the
      // one inside the bottom sheet (last match).
      expect(find.text('Aceptar'), findsWidgets);

      await tester.tap(find.text('Aceptar').last);
      await tester.pumpAndSettle();

      expect(acceptedId, 'req-1');
    },
  );

  testWidgets(
    'shows overlap warning in confirmation sheet',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RentalRequestsView(
              isLoading: false,
              requests: [request, overlappingRequest],
              processingRequestId: null,
              onAcceptRequest: (_) {},
              onRejectRequest: (_) {},
            ),
          ),
        ),
      );

      expect(
        find.text('1 solicitud superpuesta'),
        findsNWidgets(2),
      );

      await tester.tap(find.text('Aceptar').first);
      await tester.pumpAndSettle();

      expect(
        find.textContaining('será rechazada'),
        findsOneWidget,
      );
    },
  );

  testWidgets('shows no overlap badge for non-overlapping requests', (
    tester,
  ) async {
    final nonOverlapping = RentalRequest(
      id: 'req-3',
      game: const RentalRequestGameSummary(
        id: 'game-2',
        title: 'Monopoly',
        price: 80,
      ),
      requester: const RentalRequestUserSummary(
        id: 'user-3',
        email: 'carol@test.com',
        username: 'Carol',
      ),
      startDate: DateTime(2026, 2),
      endDate: DateTime(2026, 2, 5),
      totalPrice: 320,
      status: RentalRequestStatus.pending,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RentalRequestsView(
            isLoading: false,
            requests: [request, nonOverlapping],
            processingRequestId: null,
            onAcceptRequest: (_) {},
            onRejectRequest: (_) {},
          ),
        ),
      ),
    );

    expect(find.textContaining('superpuesta'), findsNothing);
  });
}
