import 'package:dartz/dartz.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart';

/// Repository contract for publishing.
// ignore: one_member_abstracts
abstract class PublishRepository {
  /// Creates a publication from the provided draft.
  /// [ownerId] is the ID of the authenticated user creating the publication.
  Future<Either<DomainException, Publication>> createPublication(
    PublicationDraft draft, {
    required String ownerId,
  });
}
