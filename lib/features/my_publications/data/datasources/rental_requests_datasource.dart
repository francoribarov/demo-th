import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/network/api_constants.dart';
import 'package:mobile_table_hopping/core/network/dio_client.dart';
import 'package:mobile_table_hopping/features/auth/domain/entities/user.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game_summary.dart';
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
      final response = await _dioClient.get<dynamic>(
        ApiConstants.rentalRequests,
      );
      final data = response.data;
      final items = _extractItems(data);

      return items
          .whereType<Map<String, dynamic>>()
          .map(_mapRentalRequest)
          .toList();
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
        images: [
          'https://m.media-amazon.com/images/I/81xHeEaXlML._AC_SL1500_.jpg',
        ],
        rating: 4.5,
        reviewsCount: 120,
        description: 'Trade, build and settle',
        duration: 90,
        players: '3-4',
        difficulty: 'Medium',
        rules: GameRules(
          videoUrl: '',
          ruleCompleteUrl: '',
          summaryRules: '',
        ),
      ),
      const Game(
        id: 'game-3',
        title: 'Pandemic',
        images: [
          'https://m.media-amazon.com/images/I/81YQ8C3-kDL._AC_SL1500_.jpg',
        ],
        rating: 4.7,
        reviewsCount: 200,
        description: 'Save the world from diseases',
        duration: 45,
        players: '2-4',
        difficulty: 'Hard',
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

  List<dynamic> _extractItems(dynamic data) {
    if (data is List) return data;
    if (data is Map<String, dynamic>) {
      final items = data['items'];
      if (items is List) return items;
    }
    return const [];
  }

  RentalRequest _mapRentalRequest(Map<String, dynamic> json) {
    final id = json['id']?.toString() ?? '';
    final renterId = json['renterId']?.toString() ?? '';
    final renterName = json['renterName']?.toString() ?? 'Usuario';
    final publicationId = json['publicationId']?.toString() ?? id;
    final gameTitle = json['gameTitle']?.toString() ?? 'Juego';
    final totalPrice = _parseDouble(json['finalPrice'] ?? json['totalPrice']);
    final startDate = _parseDate(json['startDate']);
    final endDate = _parseDate(json['endDate']);
    final status = _parseStatus(json['status']?.toString());

    return RentalRequest(
      id: id,
      game: GameSummary(
        id: publicationId,
        title: gameTitle,
        price: totalPrice.round(),
        ownerId: json['ownerId']?.toString(),
      ),
      requester: User(
        id: renterId,
        email: '',
        username: renterName,
      ),
      startDate: startDate,
      endDate: endDate,
      totalPrice: totalPrice,
      status: status,
    );
  }

  double _parseDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0;
  }

  DateTime _parseDate(dynamic value) {
    if (value is String && value.isNotEmpty) {
      return DateTime.parse(value);
    }
    return DateTime.fromMillisecondsSinceEpoch(0);
  }

  RentalRequestStatus _parseStatus(String? status) {
    switch (status?.toUpperCase()) {
      case 'PENDING':
        return RentalRequestStatus.pending;
      case 'ACTIVE':
      case 'ACCEPTED':
        return RentalRequestStatus.accepted;
      case 'REJECTED':
        return RentalRequestStatus.rejected;
      default:
        return RentalRequestStatus.pending;
    }
  }
}
