import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/repository/upload/upload_repository.dart';

@injectable

/// Use case for uploading multiple images.
class UploadImagesUseCase {
  /// Creates an [UploadImagesUseCase].
  UploadImagesUseCase(this._repository);

  final UploadRepository _repository;

  /// Uploads multiple images and returns the URLs.
  Future<Either<DomainException, List<String>>> call(List<String> filePaths) {
    return _repository.uploadImages(filePaths);
  }
}
