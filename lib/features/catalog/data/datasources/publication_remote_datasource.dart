import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/core/network/api_constants.dart';
import 'package:mobile_table_hopping/core/network/dio_client.dart';
import 'package:mobile_table_hopping/core/network/paginated_response.dart';
import 'package:mobile_table_hopping/features/catalog/data/models/publication_listing_model.dart';

/// Remote datasource for publications API calls.
/// Handles all network requests to /api/publications.
abstract class PublicationRemoteDatasource {
  /// Fetches paginated publication listings with optional filters.
  /// GET /api/publications
  Future<List<PublicationListingModel>> getPublications({
    String? query,
    String? category,
    String? players,
    String? duration,
    int? priceMin,
    int? priceMax,
    String? startDate,
    String? endDate,
    String? sortBy,
    int page = 1,
    int limit = 20,
  });

  /// Fetches a single publication by ID.
  /// GET /api/publications/:id
  Future<PublicationListingModel> getPublicationById(String id);

  /// Fetches publications available for rental today.
  /// GET /api/publications/available-today
  Future<List<PublicationListingModel>> getPublicationsAvailableToday({
    int limit = 10,
  });

  /// Fetches publication categories for filtering.
  /// GET /api/categories
  Future<List<PublicationCategoryModel>> getCategories();

  /// Fetches filter shortcuts for quick filtering.
  /// GET /api/categories/filter-shortcuts
  Future<List<FilterShortcutModel>> getFilterShortcuts();

  /// Fetches recommended publications based on a game ID.
  /// GET /api/publications?game_id={gameId}
  Future<List<PublicationListingModel>> getRecommendedPublications(
      String gameId);

  /// Fetches the current user's publications.
  /// GET /api/publications/my-publications
  Future<List<PublicationListingModel>> getMyPublications();
}

/// Filter shortcut model for category chips.
class FilterShortcutModel {
  FilterShortcutModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
    this.query,
    this.value,
  });

  factory FilterShortcutModel.fromJson(Map<String, dynamic> json) {
    return FilterShortcutModel(
      id: json['id'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
      type: json['type'] as String,
      query: json['query'] as String?,
      value: json['value'] as String?,
    );
  }

  final int id;
  final String name;
  final String icon;
  final String type;
  final String? query;
  final String? value;
}

/// Default implementation backed by [DioClient].
@LazySingleton(as: PublicationRemoteDatasource)
class PublicationRemoteDatasourceImpl implements PublicationRemoteDatasource {
  /// Creates a [PublicationRemoteDatasourceImpl] with the provided client.
  PublicationRemoteDatasourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<List<PublicationListingModel>> getPublications({
    String? query,
    String? category,
    String? players,
    String? duration,
    int? priceMin,
    int? priceMax,
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
      if (startDate != null) queryParams['start_date'] = startDate;
      if (endDate != null) queryParams['end_date'] = endDate;
      if (sortBy != null) queryParams['sort_by'] = sortBy;

      final response = await _dioClient.get<dynamic>(
        ApiConstants.publications,
        queryParameters: queryParams,
      );

      List<dynamic> itemsData;
      int total;
      int pages;
      int currentPage = page;
      int currentLimit = limit;

      if (response.data is List) {
        itemsData = response.data as List<dynamic>;
        total = itemsData.length;
        pages = 1;
      } else if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        itemsData = data['items'] as List<dynamic>? ?? const <dynamic>[];
        total = data['total'] as int? ?? 0;
        pages = data['pages'] as int? ?? 0;
        currentPage = data['page'] as int? ?? page;
        currentLimit = data['limit'] as int? ?? limit;
      } else {
        itemsData = const <dynamic>[];
        total = 0;
        pages = 0;
      }

      // ignore: avoid_print
      print('DEBUG: getPublications response data: $itemsData');

      final items = itemsData
          .map(
            (json) =>
                PublicationListingModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();

      return items;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<PublicationListingModel> getPublicationById(String id) async {
    try {
      final response = await _dioClient.get<Map<String, dynamic>>(
        '${ApiConstants.publications}/$id',
      );

      final data = response.data ?? const <String, dynamic>{};
      return PublicationListingModel.fromJson(data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<PublicationListingModel>> getPublicationsAvailableToday({
    int limit = 10,
  }) async {
    try {
      final response = await _dioClient.get<Map<String, dynamic>>(
        '${ApiConstants.publications}/available-today',
        queryParameters: {'limit': limit},
      );

      final data = response.data ?? const <String, dynamic>{};
      final itemsData = data['items'] as List<dynamic>? ?? const <dynamic>[];
      return itemsData
          .map(
            (json) =>
                PublicationListingModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<PublicationCategoryModel>> getCategories() async {
    try {
      final response = await _dioClient.get<List<dynamic>>(
        ApiConstants.categories,
      );

      final data = response.data ?? const <dynamic>[];
      return data
          .map(
            (json) =>
                PublicationCategoryModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<FilterShortcutModel>> getFilterShortcuts() async {
    try {
      final response = await _dioClient.get<List<dynamic>>(
        ApiConstants.filterShortcuts,
      );

      final data = response.data ?? const <dynamic>[];
      return data
          .map(
            (json) =>
                FilterShortcutModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<PublicationListingModel>> getRecommendedPublications(
    String gameId,
  ) async {
    try {
      final response = await _dioClient.get<List<dynamic>>(
        ApiConstants.publications,
        queryParameters: {'game_id': gameId, 'limit': 10},
      );

      final data = response.data ?? const <dynamic>[];
      return data
          .map(
            (json) =>
                PublicationListingModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<PublicationListingModel>> getMyPublications() async {
    try {
      final response = await _dioClient.get<dynamic>(
        '${ApiConstants.publications}/my-publications',
      );

      final data = response.data;
      final List<dynamic> itemsData;

      if (data is List) {
        itemsData = data;
      } else if (data is Map<String, dynamic>) {
        itemsData = data['items'] as List<dynamic>? ?? const <dynamic>[];
      } else {
        itemsData = const <dynamic>[];
      }
      return itemsData
          .map(
            (json) =>
                PublicationListingModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    var message = e.message ?? 'Error de conexión';
    final data = e.response?.data;
    if (data is Map && data['detail'] != null) {
      message = data['detail'].toString();
    }
    return Exception(message);
  }
}
