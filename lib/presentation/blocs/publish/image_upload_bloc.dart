import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/domain/usecase/upload/upload_images_use_case.dart';
import 'package:mobile_table_hopping/presentation/gateway/image_picker_gateway.dart';

part 'image_upload_bloc.freezed.dart';

/// Events for [ImageUploadBloc].
@freezed
abstract class ImageUploadEvent with _$ImageUploadEvent {
  /// Pick and upload multiple images.
  const factory ImageUploadEvent.pickAndUpload() = _PickAndUpload;

  /// Remove image at specified index.
  const factory ImageUploadEvent.imageRemoved(int index) = _ImageRemoved;

  /// Reset all images.
  const factory ImageUploadEvent.reset() = _Reset;
}

/// State for [ImageUploadBloc].
@freezed
abstract class ImageUploadState with _$ImageUploadState {
  const factory ImageUploadState({
    @Default([]) List<String> images,
    @Default(false) bool isUploading,
    String? errorMessage,
  }) = _ImageUploadState;
}

@injectable

/// Bloc for managing image uploads.
class ImageUploadBloc extends Bloc<ImageUploadEvent, ImageUploadState> {
  /// Creates an [ImageUploadBloc].
  ImageUploadBloc({
    required ImagePickerGateway imagePickerGateway,
    required UploadImagesUseCase uploadImages,
  })  : _gateway = imagePickerGateway,
        _uploadImages = uploadImages,
        super(const ImageUploadState()) {
    on<_PickAndUpload>(_onPickAndUpload);
    on<_ImageRemoved>(_onImageRemoved);
    on<_Reset>(_onReset);
  }

  final ImagePickerGateway _gateway;
  final UploadImagesUseCase _uploadImages;

  Future<void> _onPickAndUpload(
    _PickAndUpload event,
    Emitter<ImageUploadState> emit,
  ) async {
    try {
      final imagePaths = await _gateway.pickMultipleImages();
      if (imagePaths.isNotEmpty) {
        emit(state.copyWith(isUploading: true, errorMessage: null));

        final result = await _uploadImages(imagePaths);
        result.fold(
          (error) {
            emit(
              state.copyWith(
                isUploading: false,
                errorMessage: 'Error al subir imágenes: ${error.message}',
              ),
            );
          },
          (imageUrls) {
            emit(
              state.copyWith(
                images: [...state.images, ...imageUrls],
                isUploading: false,
              ),
            );
          },
        );
      }
    } on Object catch (e) {
      emit(
        state.copyWith(
          isUploading: false,
          errorMessage: 'Error al subir imágenes: $e',
        ),
      );
    }
  }

  void _onImageRemoved(_ImageRemoved event, Emitter<ImageUploadState> emit) {
    if (event.index >= 0 && event.index < state.images.length) {
      final updated = List<String>.from(state.images)..removeAt(event.index);
      emit(state.copyWith(images: updated));
    }
  }

  void _onReset(_Reset event, Emitter<ImageUploadState> emit) {
    emit(const ImageUploadState());
  }
}
