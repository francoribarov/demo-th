import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/core/network/api_constants.dart';
import 'package:mobile_table_hopping/core/network/dio_client.dart';
import 'package:mobile_table_hopping/features/catalog/data/models/game_model.dart';

/// Remote datasource for categories API calls
abstract class CategoryRemoteDatasource {
  /// Fetches available game categories.
  Future<List<GameCategoryModel>> getCategories();

  /// Fetches filter shortcut options.
  Future<List<FilterShortcutModel>> getFilterShortcuts();
}

/// Default implementation backed by [DioClient].
@LazySingleton(as: CategoryRemoteDatasource)
class CategoryRemoteDatasourceImpl implements CategoryRemoteDatasource {
  /// Creates a [CategoryRemoteDatasourceImpl] with the provided client.
  CategoryRemoteDatasourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<List<GameCategoryModel>> getCategories() async {
    try {
      final response = await _dioClient.get<Map<String, dynamic>>(
        ApiConstants.categories,
      );
      final data = response.data ?? const <String, dynamic>{};
      final categories =
          data['categories'] as List<dynamic>? ?? const <dynamic>[];
      return categories
          .map(
            (json) => GameCategoryModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<FilterShortcutModel>> getFilterShortcuts() async {
    try {
      final response = await _dioClient.get<Map<String, dynamic>>(
        ApiConstants.filterShortcuts,
      );
      final data = response.data ?? const <String, dynamic>{};
      final shortcuts =
          data['shortcuts'] as List<dynamic>? ?? const <dynamic>[];
      return shortcuts
          .map(
            (json) =>
                FilterShortcutModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final data = error.response!.data;

      var message = 'Error al obtener las categorías';
      if (data is Map && data['detail'] != null) {
        message = data['detail'].toString();
      } else if (data is Map && data['message'] != null) {
        message = data['message'].toString();
      }

      if (statusCode == 404) {
        return Exception('Categorías no encontradas');
      } else if (statusCode == 400) {
        return Exception(message);
      }
    }
    return Exception('Error de conexión. Intente nuevamente.');
  }
}
