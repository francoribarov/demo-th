import 'package:dio/dio.dart';
import 'package:mobile_table_hopping/core/errors/exceptions.dart';

/// Error interceptor to convert Dio errors to app exceptions.
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = _mapDioError(err);
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        response: err.response,
        type: err.type,
      ),
    );
  }

  AppException _mapDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException(
          message: 'La conexión tardó demasiado. Intente nuevamente.',
        );
      case DioExceptionType.connectionError:
        return const NetworkException(message: 'Sin conexión a internet.');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = _extractErrorMessage(error.response);
        if (statusCode == 401) {
          return ServerException(
            message: message ?? 'No autorizado.',
            statusCode: statusCode,
          );
        }
        if (statusCode == 404) {
          return NotFoundException(
            message: message ?? 'No se encontró el recurso.',
          );
        }
        if (statusCode != null && statusCode >= 500) {
          return ServerException(
            message: message ?? 'Error del servidor. Intente más tarde.',
            statusCode: statusCode,
          );
        }
        return ServerException(
          message: message ?? 'Error desconocido.',
          statusCode: statusCode,
        );
      case DioExceptionType.cancel:
        return const ServerException(message: 'La solicitud fue cancelada.');
      case DioExceptionType.badCertificate:
        return const ServerException(message: 'Certificado SSL inválido.');
      case DioExceptionType.unknown:
        return const ServerException(message: 'Ocurrió un error inesperado.');
    }
  }

  String? _extractErrorMessage(Response<dynamic>? response) {
    if (response?.data is Map) {
      final data = response!.data as Map;
      return data['message'] as String? ?? data['error'] as String?;
    }
    return null;
  }
}
