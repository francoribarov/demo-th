import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/data/base_repository.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/data/datasource/upload/upload_remote_data_source.dart';
import 'package:mobile_table_hopping/data/dto/upload/image_upload_response.dart';
import 'package:mobile_table_hopping/domain/repository/upload/upload_repository.dart';

/// Implementation of [UploadRepository].
@LazySingleton(as: UploadRepository)
class UploadRepositoryImpl extends BaseRepository implements UploadRepository {
  /// Creates an [UploadRepositoryImpl].
  UploadRepositoryImpl(this._dataSource);

  final UploadRemoteDataSource _dataSource;

  @override
  Future<Either<DomainException, String>> uploadImage(String filePath) async {
    final result = await executeDataSource<ImageUploadResponse, List<String>>(
      function: () => _dataSource.uploadImage(filePath),
    );

    return result.fold(
      Left.new,
      (urls) => Right(urls.first),
    );
  }

  @override
  Future<Either<DomainException, List<String>>> uploadImages(
    List<String> filePaths,
  ) async {
    final urls = <String>[];

    for (final filePath in filePaths) {
      final result = await uploadImage(filePath);

      // Fail-fast on first error
      final either = result.fold<Either<DomainException, List<String>>>(
        Left.new,
        (url) {
          urls.add(url);
          return Right(urls);
        },
      );

      if (either.isLeft()) {
        return either;
      }
    }

    return Right(urls);
  }
}
