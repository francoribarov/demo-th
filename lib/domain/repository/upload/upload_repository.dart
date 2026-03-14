import 'package:dartz/dartz.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';

/// Repository interface for upload operations.
abstract class UploadRepository {
  /// Uploads a single image and returns the URL.
  Future<Either<DomainException, String>> uploadImage(String filePath);

  /// Uploads multiple images and returns the URLs.
  Future<Either<DomainException, List<String>>> uploadImages(
    List<String> filePaths,
  );
}
