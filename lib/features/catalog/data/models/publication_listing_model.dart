import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/core/network/base_dto_response.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';

part 'publication_listing_model.freezed.dart';
part 'publication_listing_model.g.dart';

/// Availability range model.
@freezed
sealed class AvailabilityRangeModel with _$AvailabilityRangeModel {
  const factory AvailabilityRangeModel({
    required String from,
    required String to,
  }) = _AvailabilityRangeModel;

  factory AvailabilityRangeModel.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityRangeModelFromJson(json);

  const AvailabilityRangeModel._();

  AvailabilityRange toDomainModel() => AvailabilityRange(from: from, to: to);
}

/// Category model as returned by the publications endpoint.
@freezed
sealed class PublicationCategoryModel with _$PublicationCategoryModel {
  const factory PublicationCategoryModel({
    required int id,
    required String name,
    @Default('') String icon,
    String? query,
    String? description,
  }) = _PublicationCategoryModel;

  const PublicationCategoryModel._();

  factory PublicationCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$PublicationCategoryModelFromJson(json);

  GameCategory toDomainModel() => GameCategory(
        id: id,
        name: name,
        icon: icon,
        query: query,
        description: description,
      );
}

/// Nested game data model within a publication listing.
/// Note: The backend only returns players, duration, and categories - no id/title.
@freezed
sealed class PublicationGameDataModel with _$PublicationGameDataModel {
  const factory PublicationGameDataModel({
    @Default('') String players,
    @Default(0) int duration,
    @Default([]) List<PublicationCategoryModel> categories,
  }) = _PublicationGameDataModel;

  const PublicationGameDataModel._();

  factory PublicationGameDataModel.fromJson(Map<String, dynamic> json) =>
      _$PublicationGameDataModelFromJson(json);

  PublicationGameData toDomainModel() => PublicationGameData(
        players: players,
        duration: duration,
        categories: categories.map((c) => c.toDomainModel()).toList(),
      );
}

/// Publication listing model as returned by GET /api/publications.
@freezed
sealed class PublicationListingModel
    with _$PublicationListingModel
    implements BaseDtoResponse<PublicationListing> {
  const factory PublicationListingModel({
    required String id,
    @JsonKey(name: 'owner_id') required String ownerId,
    @JsonKey(name: 'game_id') required String gameId,
    required String title,
    required String condition,
    required double price,
    @Default(0.0) double deposit,
    @Default([]) List<String> images,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'booked_ranges')
    @Default([])
    List<AvailabilityRangeModel> bookedRanges,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    PublicationGameDataModel? game,
  }) = _PublicationListingModel;

  const PublicationListingModel._();

  factory PublicationListingModel.fromJson(Map<String, dynamic> json) =>
      _$PublicationListingModelFromJson(json);

  @override
  PublicationListing toDomainModel() => PublicationListing(
        id: id,
        ownerId: ownerId,
        gameId: gameId,
        title: title,
        condition: condition,
        price: price,
        deposit: deposit,
        images: images,
        isActive: isActive,
        availability: bookedRanges.map((a) => a.toDomainModel()).toList(),
        createdAt: createdAt,
        game: (game ?? const PublicationGameDataModel()).toDomainModel(),
      );

  Game toGameEntity() {
    final gameData = game ?? const PublicationGameDataModel();
    return Game(
      id: id,
      title: title,
      categories: gameData.categories.map((c) => c.toDomainModel()).toList(),
      description: '',
      duration: gameData.duration,
      players: gameData.players,
      difficulty: 'Medio',
      rules: const GameRules(
        videoUrl: '',
        ruleCompleteUrl: '',
        summaryRules: '',
      ),
      images: images,
      rating: 0.0,
      reviewsCount: 0,
    );
  }
}
