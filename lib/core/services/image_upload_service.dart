import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/network/api_constants.dart';
import 'package:mobile_table_hopping/core/network/dio_client.dart';

/// Service for handling image selection and upload.
@injectable
class ImageUploadService {
  /// Creates an [ImageUploadService].
  ImageUploadService(this._dioClient) : _imagePicker = ImagePicker();

  final DioClient _dioClient;
  final ImagePicker _imagePicker;

  /// Pick an image from the gallery.
  /// Returns the file path if selected, null otherwise.
  Future<String?> pickImageFromGallery() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    return pickedFile?.path;
  }

  /// Pick an image from the camera.
  /// Returns the file path if selected, null otherwise.
  Future<String?> pickImageFromCamera() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    return pickedFile?.path;
  }

  /// Pick multiple images from the gallery.
  /// Returns list of file paths.
  Future<List<String>> pickMultipleImages() async {
    final pickedFiles = await _imagePicker.pickMultiImage(
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    return pickedFiles.map((f) => f.path).toList();
  }

  /// Upload an image file to the server.
  /// Returns the URL of the uploaded image.
  Future<String> uploadImage(String filePath) async {
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
    if (data == null || !data.containsKey('url')) {
      throw Exception('Invalid response from image upload');
    }

    return data['url'] as String;
  }

  /// Upload multiple images to the server.
  /// Returns list of URLs.
  Future<List<String>> uploadImages(List<String> filePaths) async {
    final urls = <String>[];
    for (final path in filePaths) {
      final url = await uploadImage(path);
      urls.add(url);
    }
    return urls;
  }
}
