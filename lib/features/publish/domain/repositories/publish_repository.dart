import 'package:mobile_table_hopping/features/publish/domain/entities/listing.dart';

/// Repository contract for publishing listings.
// ignore: one_member_abstracts
abstract class PublishRepository {
  /// Creates a listing from the provided draft.
  Future<Listing> createListing(ListingDraft draft);
}
