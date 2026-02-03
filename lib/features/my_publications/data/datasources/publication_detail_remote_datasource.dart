import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/network/api_constants.dart';
import 'package:mobile_table_hopping/core/network/dio_client.dart';
import 'package:mobile_table_hopping/features/my_publications/data/models/publication_detail_model.dart';

/// Remote datasource contract for publication details.
abstract class PublicationDetailRemoteDatasource {
  /// Gets publication details by [id].
  Future<PublicationDetailModel> getPublicationDetail(String id);

  /// Updates the publication with [id] using the [request] data.
  Future<PublicationDetailModel> updatePublication(
    String id,
    PublicationUpdateRequestModel request,
  );

  /// Deletes the publication with [id].
  Future<void> deletePublication(String id);
}

@LazySingleton(as: PublicationDetailRemoteDatasource)

/// Remote datasource implementation using Dio.
class PublicationDetailRemoteDatasourceImpl
    implements PublicationDetailRemoteDatasource {
  /// Creates a datasource backed by the shared Dio client.
  PublicationDetailRemoteDatasourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<PublicationDetailModel> getPublicationDetail(String id) async {
    try {
      final response = await _dioClient.get<Map<String, dynamic>>(
        '${ApiConstants.publications}/$id',
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return PublicationDetailModel.fromJson(data);
      }
      throw Exception('Respuesta inválida del servidor.');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<PublicationDetailModel> updatePublication(
    String id,
    PublicationUpdateRequestModel request,
  ) async {
    try {
      final response = await _dioClient.put<Map<String, dynamic>>(
        '${ApiConstants.publications}/$id',
        data: request.toJson(),
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return PublicationDetailModel.fromJson(data);
      }
      throw Exception('Respuesta inválida del servidor.');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> deletePublication(String id) async {
    try {
      await _dioClient.delete<void>('${ApiConstants.publications}/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final data = error.response!.data;

      var message = 'Error al procesar la publicación';
      if (data is Map && data['detail'] != null) {
        message = data['detail'].toString();
      } else if (data is Map && data['message'] != null) {
        message = data['message'].toString();
      }

      if (statusCode == 401) {
        return Exception('No autorizado');
      }
      if (statusCode == 404) {
        return Exception('Publicación no encontrada');
      }
      return Exception(message);
    }
    return Exception('Error de conexión. Intente nuevamente.');
  }
}
