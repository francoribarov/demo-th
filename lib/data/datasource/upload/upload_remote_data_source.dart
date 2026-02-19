import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/network/api_constants.dart';
import 'package:mobile_table_hopping/core/network/dio_client.dart';
import 'package:mobile_table_hopping/core/resources/api_result.dart';
import 'package:mobile_table_hopping/core/resources/base_data_source.dart';
import 'package:mobile_table_hopping/data/dto/upload/image_upload_response.dart';

/// Remote datasource contract for upload operations.
class UploadRemoteDataSource {
  /// Uploads an image file to the server.
  Future<ApiResult<ImageUploadResponse>> uploadImage(String filePath) {
    throw UnimplementedError();
  }
}

/// Implementation of [UploadRemoteDataSource] using DioClient.
@LazySingleton(as: UploadRemoteDataSource)
class UploadRemoteDataSourceImpl extends BaseDataSource
    implements UploadRemoteDataSource {
  /// Creates an [UploadRemoteDataSourceImpl].
  UploadRemoteDataSourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<ApiResult<ImageUploadResponse>> uploadImage(String filePath) {
    return getStateOf<ImageUploadResponse>(
      request: () async {
        final file = File(filePath);
        final fileName = file.path.split(Platform.pathSeparator).last;

        final formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(
            filePath,
            filename: fileName,
          ),
        });

        final response = await _dioClient.post<Map<String, dynamic>>(
          ApiConstants.imageUpload,
          data: formData,
          options: Options(
            contentType: 'multipart/form-data',
          ),
        );

        final data = response.data;
        if (data == null) {
          throw Exception('Invalid response from image upload');
        }

        return ImageUploadResponse.fromJson(data);
      },
    );
  }
}
