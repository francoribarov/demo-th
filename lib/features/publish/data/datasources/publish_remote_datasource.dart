import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/network/api_constants.dart';
import 'package:mobile_table_hopping/core/network/dio_client.dart';
import 'package:mobile_table_hopping/features/publish/data/models/listing_model.dart';

/// Remote datasource contract for publishing listings.
// ignore: one_member_abstracts
abstract class PublishRemoteDatasource {
  /// Creates a listing on the backend.
  Future<ListingModel> createListing(ListingCreateRequestModel request);
}

@LazySingleton(as: PublishRemoteDatasource)
/// Remote datasource implementation using Dio.
class PublishRemoteDatasourceImpl implements PublishRemoteDatasource {
  /// Creates a datasource backed by the shared Dio client.
  PublishRemoteDatasourceImpl(this._dioClient);
  final DioClient _dioClient;

  @override
  Future<ListingModel> createListing(ListingCreateRequestModel request) async {
    try {
      final response = await _dioClient.post<Map<String, dynamic>>(
        ApiConstants.listings,
        data: request.toJson(),
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return ListingModel.fromJson(data);
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
