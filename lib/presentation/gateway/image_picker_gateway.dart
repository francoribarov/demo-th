import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

/// Gateway for image picking operations in the presentation layer.
abstract class ImagePickerGateway {
  /// Pick an image from the gallery.
  Future<String?> pickImageFromGallery();

  /// Pick an image from the camera.
  Future<String?> pickImageFromCamera();

  /// Pick multiple images from the gallery.
  Future<List<String>> pickMultipleImages();
}

/// Implementation of [ImagePickerGateway] using ImagePicker.
@LazySingleton(as: ImagePickerGateway)
class ImagePickerGatewayImpl implements ImagePickerGateway {
  /// Creates an [ImagePickerGatewayImpl].
  ImagePickerGatewayImpl() : _imagePicker = ImagePicker();

  final ImagePicker _imagePicker;

  @override
  Future<String?> pickImageFromGallery() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    return pickedFile?.path;
  }

  @override
  Future<String?> pickImageFromCamera() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    return pickedFile?.path;
  }

  @override
  Future<List<String>> pickMultipleImages() async {
    final pickedFiles = await _imagePicker.pickMultiImage(
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    return pickedFiles.map((f) => f.path).toList();
  }
}
