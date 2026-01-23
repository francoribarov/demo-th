import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/entities/rental_request.dart';

abstract class MyPublicationsRepository {
  Future<List<RentalRequest>> getRentalRequests();
  Future<void> acceptRentalRequest(String requestId);
  Future<void> rejectRentalRequest(String requestId);
  Future<List<Game>> getMyGames();
}
