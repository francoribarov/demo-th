import 'package:dio/dio.dart';

/// Error interceptor placeholder.
///
/// Data layer error mapping is centralized in DataException.fromDioError
/// from BaseDataSource; this interceptor forwards Dio errors unchanged.
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}
