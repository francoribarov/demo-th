import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/network/api_constants.dart';
import 'package:mobile_table_hopping/core/network/dio_client.dart';
import 'package:mobile_table_hopping/features/rental/data/models/rental_models.dart';

/// Remote datasource contract for rental operations.
// ignore: one_member_abstracts
abstract class RentalRemoteDatasource {
  /// Creates a rental on the backend.
  Future<void> createRental(RentalCreateRequestModel request);
}

@LazySingleton(as: RentalRemoteDatasource)

/// Remote datasource implementation using Dio.
class RentalRemoteDatasourceImpl implements RentalRemoteDatasource {
  /// Creates a datasource backed by the shared Dio client.
  RentalRemoteDatasourceImpl(this._dioClient);
  final DioClient _dioClient;

  @override
  Future<void> createRental(RentalCreateRequestModel request) async {
    try {
      await _dioClient.post<void>(
        ApiConstants.rentals,
        data: request.toJson(),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final data = error.response!.data;

      var message = 'Error al confirmar alquiler';
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
