import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/features/catalog/data/datasources/publication_remote_datasource.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';
import 'package:mobile_table_hopping/features/catalog/domain/repositories/publication_repository.dart';

/// Implementation of [PublicationRepository] using remote datasource.
@LazySingleton(as: PublicationRepository)
class PublicationRepositoryImpl implements PublicationRepository {
  /// Creates a [PublicationRepositoryImpl] with the provided datasource.
  PublicationRepositoryImpl(this._datasource);

  final PublicationRemoteDatasource _datasource;

  @override
  Future<List<PublicationListing>> getPublications({
    String? query,
    String? category,
    String? players,
    String? duration,
    int? priceMin,
    int? priceMax,
    String? startDate,
    String? endDate,
    String? sortBy,
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _datasource.getPublications(
      query: query,
      category: category,
      players: players,
      duration: duration,
      priceMin: priceMin,
      priceMax: priceMax,
      startDate: startDate,
      endDate: endDate,
      sortBy: sortBy,
      page: page,
      limit: limit,
    );
    return response.map((m) => m.toDomainModel()).toList();
  }

  @override
  Future<PublicationListing?> getPublicationById(String id) async {
    try {
      final model = await _datasource.getPublicationById(id);
      return model.toDomainModel();
    } on Exception catch (e) {
      print('ERROR getPublicationById: $e');
      return null;
    }
  }

  @override
  Future<List<PublicationListing>> getPublicationsAvailableToday({
    int limit = 10,
  }) async {
    final models =
        await _datasource.getPublicationsAvailableToday(limit: limit);
    return models.map((m) => m.toDomainModel()).toList();
  }

  @override
  Future<List<PublicationListing>> getRecommendedPublications(
      String gameId) async {
    // For now, we fetch publications with similar categories
    // This could be enhanced with a proper recommendation endpoint
    final models = await _datasource.getRecommendedPublications(gameId);
    return models.map((m) => m.toDomainModel()).toList();
  }

  @override
  Future<List<GameCategory>> getCategories() async {
    final models = await _datasource.getCategories();
    return models
        .map((m) => GameCategory(
              id: m.id,
              name: m.name,
              icon: m.icon,
              query: m.query,
              description: m.description,
            ))
        .toList();
  }

  @override
  Future<List<FilterShortcut>> getFilterShortcuts() async {
    final models = await _datasource.getFilterShortcuts();
    return models
        .map((m) => FilterShortcut(
              id: m.id,
              name: m.name,
              icon: m.icon,
              type: m.type,
              query: m.query,
              value: m.value,
            ))
        .toList();
  }

  @override
  Future<List<PublicationListing>> getMyPublications() async {
    final models = await _datasource.getMyPublications();
    return models.map((m) => m.toDomainModel()).toList();
  }
}
