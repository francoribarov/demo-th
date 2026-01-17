import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/core/network/api_constants.dart';
import 'package:mobile_table_hopping/core/network/dio_client.dart';
import 'package:mobile_table_hopping/core/network/paginated_response.dart';
import 'package:mobile_table_hopping/features/catalog/data/models/game_model.dart';
import 'package:mobile_table_hopping/features/catalog/data/models/publication_list_item_model.dart';
import 'package:mobile_table_hopping/features/catalog/data/models/publication_listing_model.dart';

/// Remote datasource for games API calls
abstract class GameRemoteDatasource {
  /// Fetches paginated publications (with nested games) with optional filter parameters.
  Future<PaginatedResponse<PublicationListItemModel>> getPublications({
    String? query,
    String? category,
    String? players,
    String? duration,
    int? priceMin,
    int? priceMax,
    String? difficulty,
    String? startDate,
    String? endDate,
    String? sortBy,
    int page = 1,
    int limit = 20,
  });

  /// Fetches a single game by id.
  Future<PublicationDetailModel> getPublicationById(String id);

  /// Fetches a list of games available today.
  Future<List<PublicationListItemModel>> getPublicationsAvailableToday(
      {int limit = 10});

  /// Fetches recommended games for a specific game.
  Future<List<PublicationListItemModel>> getPublicationsRecommendations(
    String gameId, {
    int limit = 6,
  });

  /// Fetches paginated publication listings from /api/publications.
  Future<PaginatedResponse<PublicationListingModel>> getPublicationListings({
    String? query,
    int page = 1,
    int limit = 20,
  });

  Future<GameModel> getGameById(String id);
}

/// Default implementation backed by [DioClient].
@LazySingleton(as: GameRemoteDatasource)
class GameRemoteDatasourceImpl implements GameRemoteDatasource {
  /// Creates a [GameRemoteDatasourceImpl] with the provided client.
  GameRemoteDatasourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<PaginatedResponse<PublicationListItemModel>> getPublications({
    String? query,
    String? category,
    String? players,
    String? duration,
    int? priceMin,
    int? priceMax,
    String? difficulty,
    String? startDate,
    String? endDate,
    String? sortBy,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final queryParams = <String, dynamic>{'page': page, 'limit': limit};

      if (query != null && query.isNotEmpty) queryParams['q'] = query;
      if (category != null) queryParams['category'] = category;
      if (players != null) queryParams['players'] = players;
      if (duration != null) queryParams['duration'] = duration;
      if (priceMin != null) queryParams['price_min'] = priceMin;
      if (priceMax != null) queryParams['price_max'] = priceMax;
      if (difficulty != null) queryParams['difficulty'] = difficulty;
      if (startDate != null) queryParams['start_date'] = startDate;
      if (endDate != null) queryParams['end_date'] = endDate;
      if (sortBy != null) queryParams['sort_by'] = sortBy;

      final response = await _dioClient.get<Map<String, dynamic>>(
        ApiConstants.publications,
        queryParameters: queryParams,
      );

      final data = response.data ?? const <String, dynamic>{};

      // Parse items as publications with nested games
      final itemsData = data['items'] as List<dynamic>? ?? const <dynamic>[];
      final items = itemsData
          .map(
            (json) =>
                PublicationListItemModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();

      return PaginatedResponse(
        items: items,
        total: data['total'] as int? ?? 0,
        page: data['page'] as int? ?? page,
        limit: data['limit'] as int? ?? limit,
        pages: data['pages'] as int? ?? 0,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<PublicationDetailModel> getPublicationById(String id) async {
    try {
      final response = await _dioClient.get<Map<String, dynamic>>(
        ApiConstants.publicationById(id),
      );

      final data = response.data ?? const <String, dynamic>{};
      return PublicationDetailModel.fromJson(data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<PublicationListItemModel>> getPublicationsAvailableToday(
      {int limit = 10}) async {
    try {
      final today = DateTime.now();
      final todayStr =
          '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

      final response = await _dioClient.get<dynamic>(
        ApiConstants.publications,
        queryParameters: <String, dynamic>{
          'limit': limit,
          'available_from': todayStr,
          'available_to': todayStr,
        },
      );

      final data = response.data;
      final List<dynamic> itemsData;

      if (data is List) {
        itemsData = data;
      } else if (data is Map && data['items'] is List) {
        itemsData = data['items'] as List;
      } else {
        itemsData = [];
      }

      return itemsData
          .map((json) {
            if (json is Map<String, dynamic>) {
              return PublicationListItemModel.fromJson(json);
            }
            return null;
          })
          .whereType<PublicationListItemModel>()
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<PublicationListItemModel>> getPublicationsRecommendations(
    String gameId, {
    int limit = 6,
  }) async {
    try {
      final response = await _dioClient.get<List<dynamic>>(
        ApiConstants.publicationRecommendations(gameId),
        queryParameters: <String, dynamic>{'limit': limit},
      );

      final data = response.data ?? const <dynamic>[];
      return data
          .map((json) =>
              PublicationListItemModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final data = error.response!.data;

      var message = 'Error al obtener los juegos';
      if (data is Map && data['detail'] != null) {
        message = data['detail'].toString();
      } else if (data is Map && data['message'] != null) {
        message = data['message'].toString();
      }

      if (statusCode == 404) {
        return Exception('Juego no encontrado');
      } else if (statusCode == 400) {
        return Exception(message);
      }
    }
    return Exception('Error de conexión. Intente nuevamente.');
  }

  @override
  Future<PaginatedResponse<PublicationListingModel>> getPublicationListings({
    String? query,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final queryParams = <String, dynamic>{'page': page, 'limit': limit};
      if (query != null && query.isNotEmpty) queryParams['q'] = query;

      final response = await _dioClient.get<Map<String, dynamic>>(
        ApiConstants.publications,
        queryParameters: queryParams,
      );

      final data = response.data ?? const <String, dynamic>{};
      final itemsData = data['items'] as List<dynamic>? ?? const <dynamic>[];
      final items = itemsData
          .map(
            (json) =>
                PublicationListingModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();

      return PaginatedResponse(
        items: items,
        total: data['total'] as int? ?? 0,
        page: data['page'] as int? ?? page,
        limit: data['limit'] as int? ?? limit,
        pages: data['pages'] as int? ?? 0,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<GameModel> getGameById(String id) async {
    try {
      final response = await _dioClient.get<Map<String, dynamic>>(
        ApiConstants.games + '/$id',
      );

      final data = response.data ?? const <String, dynamic>{};
      return GameModel.fromJson(data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
}
