import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/network/api_constants.dart';
import 'package:mobile_table_hopping/core/network/dio_client.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/my_publications/data/models/rental_request_model.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/entities/rental_request.dart';

abstract class RentalRequestsDataSource {
  Future<List<RentalRequest>> getRentalRequests();
  Future<void> acceptRentalRequest(String id);
  Future<void> rejectRentalRequest(String id);
  Future<List<Game>> getMyGames();
}

@LazySingleton(as: RentalRequestsDataSource)
class RentalRequestsDataSourceImpl implements RentalRequestsDataSource {
  RentalRequestsDataSourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<List<RentalRequest>> getRentalRequests() async {
    try {
      final response = await _dioClient.get<Map<String, dynamic>>(
        ApiConstants.rentalRequests,
      );
      final data = response.data;
      if (data != null && data['items'] is List) {
        final items = data['items'] as List;
        return items
            .map((e) => RentalRequestModel.fromJson(e as Map<String, dynamic>))
            .map((e) => e.toDomainModel())
            .toList();
      }
      return [];
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> acceptRentalRequest(String id) async {
    try {
      await _dioClient.post<void>(ApiConstants.acceptRental(id));
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> rejectRentalRequest(String id) async {
    try {
      await _dioClient.post<void>(ApiConstants.rejectRental(id));
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<Game>> getMyGames() async {
    // TODO(FRAN): Implement when endpoint is available.
    // Returning mock data for now to keep functionality working.
    await Future<void>.delayed(const Duration(seconds: 1));
    return [
      const Game(
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
      const Game(
        id: 'game-3',
        title: 'Pandemic',
        categories: [],
        images: [
          'https://m.media-amazon.com/images/I/81YQ8C3-kDL._AC_SL1500_.jpg',
        ],
        rating: 4.7,
        reviewsCount: 200,
        description: 'Save the world from diseases',
        duration: 45,
        players: '2-4',
        difficulty: 'Hard',
        price: 40,
        rules: GameRules(
          videoUrl: '',
          ruleCompleteUrl: '',
          summaryRules: '',
        ),
      ),
    ];
  }

  Exception _handleError(DioException error) {
    if (error.response != null) {
      final data = error.response!.data;
      var message = 'Error en la solicitud';
      if (data is Map && data['detail'] != null) {
        message = data['detail'].toString();
      } else if (data is Map && data['message'] != null) {
        message = data['message'].toString();
      }
      return Exception(message);
    }
    return Exception('Error de conexión. Intente nuevamente.');
  }
}
