import 'package:mobile_table_hopping/data/dto/catalog/game_model.dart';
import 'package:mobile_table_hopping/data/dto/catalog/publication_list_item_model.dart';
import 'package:mobile_table_hopping/data/dto/catalog/publication_listing_model.dart';

/// Wrapped response for publication listing collections.
class PublicationListingCollectionResponse {
  const PublicationListingCollectionResponse(this.items);
  // TODO(TEAM): We have to improve the backend response to be more consistent and predictable. This is a temporary solution to get the data we need. In the future, we should use the PublicationListingModel directly.
  factory PublicationListingCollectionResponse.fromDynamic(dynamic data) {
    final rawList = _extractList(data);
    return PublicationListingCollectionResponse(
      rawList.map(PublicationListingModel.fromJson).toList(growable: false),
    );
  }

  final List<PublicationListingModel> items;
}

/// Wrapped response for game category collections.
class GameCategoryCollectionResponse {
  const GameCategoryCollectionResponse(this.items);

  factory GameCategoryCollectionResponse.fromDynamic(dynamic data) {
    final rawList = _extractList(data);
    return GameCategoryCollectionResponse(
      rawList.map(GameCategoryModel.fromJson).toList(growable: false),
    );
  }

  final List<GameCategoryModel> items;
}

/// Wrapped response for filter shortcut collections.
class FilterShortcutCollectionResponse {
  const FilterShortcutCollectionResponse(this.items);

  factory FilterShortcutCollectionResponse.fromDynamic(dynamic data) {
    final rawList = _extractList(data);
    return FilterShortcutCollectionResponse(
      rawList.map(FilterShortcutModel.fromJson).toList(growable: false),
    );
  }

  final List<FilterShortcutModel> items;
}

/// Wrapped response for publication list item collections.
class PublicationListItemCollectionResponse {
  const PublicationListItemCollectionResponse(this.items);

  factory PublicationListItemCollectionResponse.fromDynamic(dynamic data) {
    final rawList = _extractList(data);
    return PublicationListItemCollectionResponse(
      rawList.map(PublicationListItemModel.fromJson).toList(growable: false),
    );
  }

  final List<PublicationListItemModel> items;
}

/// Wrapped response for game collections.
class GameCollectionResponse {
  const GameCollectionResponse(this.items);

  factory GameCollectionResponse.fromDynamic(dynamic data) {
    final rawList = _extractList(data);
    return GameCollectionResponse(
      rawList.map(GameModel.fromJson).toList(growable: false),
    );
  }

  final List<GameModel> items;
}

List<Map<String, dynamic>> _extractList(dynamic data) {
  if (data is List) {
    return data.whereType<Map<String, dynamic>>().toList(growable: false);
  }

  if (data is Map<String, dynamic>) {
    const candidateKeys = [
      'items',
      'data',
      'results',
      'categories',
      'filter_shortcuts',
      'shortcuts',
    ];
    for (final key in candidateKeys) {
      final value = data[key];
      if (value is List) {
        return value.whereType<Map<String, dynamic>>().toList(growable: false);
      }
    }
  }

  return const [];
}
