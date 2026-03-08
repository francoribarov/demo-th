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

  testWidgets('confirms and forwards accept callback', (tester) async {
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

    await tester.tap(find.text('Aceptar').last);
    await tester.pumpAndSettle();

    expect(acceptedId, 'req-1');
  });
}
