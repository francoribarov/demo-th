import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/network/api_constants.dart';
import 'package:mobile_table_hopping/core/network/dio_client.dart';
import 'package:mobile_table_hopping/features/publish/data/models/publication_model.dart';

/// Remote datasource contract for publishing publications.
// ignore: one_member_abstracts
abstract class PublishRemoteDatasource {
  /// Creates a publication on the backend.
  Future<PublicationModel> createPublication(PublicationCreateRequestModel request);
}

@LazySingleton(as: PublishRemoteDatasource)
/// Remote datasource implementation using Dio.
class PublishRemoteDatasourceImpl implements PublishRemoteDatasource {
  /// Creates a datasource backed by the shared Dio client.
  PublishRemoteDatasourceImpl(this._dioClient);
  final DioClient _dioClient;

  @override
  Future<PublicationModel> createPublication(PublicationCreateRequestModel request) async {
    try {
      final response = await _dioClient.post<Map<String, dynamic>>(
        ApiConstants.publications,
        data: request.toJson(),
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return PublicationModel.fromJson(data);
      }
      throw Exception('Respuesta inválida del servidor.');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final data = error.response!.data;

      var message = 'Error al publicar';
      if (data is Map && data['detail'] != null) {
        message = data['detail'].toString();
      } else if (data is Map && data['message'] != null) {
        message = data['message'].toString();
      }

      if (statusCode == 401) {
        return Exception('No autorizado');
      }
      return Exception(message);
    }
    return Exception('Error de conexión. Intente nuevamente.');
  }
}
