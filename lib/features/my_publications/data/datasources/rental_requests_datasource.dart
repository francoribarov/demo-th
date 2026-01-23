import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/auth/domain/entities/user.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/entities/rental_request.dart';

abstract class RentalRequestsDataSource {
  Future<List<RentalRequest>> getRentalRequests();
  Future<void> acceptRentalRequest(String id);
  Future<void> rejectRentalRequest(String id);
}

@LazySingleton(as: RentalRequestsDataSource)
class MockRentalRequestsDataSource implements RentalRequestsDataSource {
  final List<RentalRequest> _requests = [
    RentalRequest(
      id: '1',
      game: const Game(
        id: 'game-1',
        title: 'Catan',
        categories: [],
        images: [
          'https://m.media-amazon.com/images/I/81xHeEaXlML._AC_SL1500_.jpg',
        ],
        rating: 4.5,
        reviewsCount: 120,
        description: 'Trade, build and settle',
        duration: 90,
        players: '3-4',
        difficulty: 'Medium',
        price: 50,
        rules: GameRules(
          videoUrl: '',
          ruleCompleteUrl: '',
          summaryRules: '',
        ),
      ),
      requester: const User(
        id: 'user-1',
        email: 'requester@example.com',
        username: 'BoardGameFan',
        imageUrl: 'https://i.pravatar.cc/150?u=user-1',
      ),
      startDate: DateTime(2023, 10, 25),
      endDate: DateTime(2023, 10, 28),
      totalPrice: 15,
      status: RentalRequestStatus.pending,
    ),
    RentalRequest(
      id: '2',
      game: const Game(
        id: 'game-2',
        title: 'Ticket to Ride',
        categories: [],
        images: [
          'https://m.media-amazon.com/images/I/91YV8WfE9fL._AC_SL1500_.jpg',
        ],
        rating: 4.8,
        reviewsCount: 85,
        description: 'Cross-country train adventure',
        duration: 60,
        players: '2-5',
        difficulty: 'Easy',
        price: 45,
        rules: GameRules(
          videoUrl: '',
          ruleCompleteUrl: '',
          summaryRules: '',
        ),
      ),
      requester: const User(
        id: 'user-2',
        email: 'traveler@example.com',
        username: 'TrainMaster',
        imageUrl: 'https://i.pravatar.cc/150?u=user-2',
      ),
      startDate: DateTime(2023, 11),
      endDate: DateTime(2023, 11, 3),
      totalPrice: 10,
      status: RentalRequestStatus.pending,
    ),
  ];

  @override
  Future<List<RentalRequest>> getRentalRequests() async {
    await Future<void>.delayed(const Duration(seconds: 1)); // Simulate latency
    return _requests;
  }

  @override
  Future<void> acceptRentalRequest(String id) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    final index = _requests.indexWhere((r) => r.id == id);
    if (index != -1) {
      _requests[index] = _requests[index].copyWith(
        status: RentalRequestStatus.accepted,
      );
    }
  }

  @override
  Future<void> rejectRentalRequest(String id) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    final index = _requests.indexWhere((r) => r.id == id);
    if (index != -1) {
      _requests[index] = _requests[index].copyWith(
        status: RentalRequestStatus.rejected,
      );
    }
  }
}
