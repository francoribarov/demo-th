import 'package:mobile_table_hopping/features/publish/domain/entities/publication.dart';

/// Repository contract for publishing.
// ignore: one_member_abstracts
abstract class PublishRepository {
  /// Creates a publication from the provided draft.
  Future<Publication> createPublication(PublicationDraft draft);
}
