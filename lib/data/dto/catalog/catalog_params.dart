/// Request params wrapper for publications listing queries.
class PublicationsQueryParams {
  const PublicationsQueryParams({
    this.query,
    this.category,
    this.players,
    this.duration,
    this.priceMin,
    this.priceMax,
    this.startDate,
    this.endDate,
    this.sortBy,
    this.page = 1,
    this.limit = 100,
  });

  final String? query;
  final String? category;
  final String? players;
  final String? duration;
  final int? priceMin;
  final int? priceMax;
  final String? startDate;
  final String? endDate;
  final String? sortBy;
  final int page;
  final int limit;

  Map<String, String> toQueryMap() => <String, String>{
    'q': ?query,
    'category': ?category,
    'players': ?players,
    'duration': ?duration,
    if (priceMin != null) 'price_min': priceMin.toString(),
    if (priceMax != null) 'price_max': priceMax.toString(),
    'start_date': ?startDate,
    'end_date': ?endDate,
    'sort_by': ?sortBy,
    'page': page.toString(),
    'limit': limit.toString(),
  };
}

/// Request params wrapper for "available today" query.
class AvailableTodayQueryParams {
  const AvailableTodayQueryParams({this.limit = 10});

  final int limit;
}

/// Request params wrapper for recommended publications query.
class RecommendedPublicationsQueryParams {
  const RecommendedPublicationsQueryParams({
    required this.gameId,
    this.limit = 10,
  });

  final String gameId;
  final int limit;

  Map<String, String> toQueryMap() => <String, String>{
    'game_id': gameId,
    'limit': limit.toString(),
  };
}

/// Request params wrapper for publication listings query.
class PublicationListingsQueryParams {
  const PublicationListingsQueryParams({this.query});

  final String? query;

  Map<String, String> toQueryMap() => <String, String>{'q': ?query};
}

/// Request params wrapper for game search query.
class SearchGamesQueryParams {
  const SearchGamesQueryParams({
    this.query,
    this.players,
    this.duration,
    this.difficulty,
    this.category,
    this.startDate,
    this.endDate,
    this.sortBy,
  });

  final String? query;
  final String? players;
  final String? duration;
  final String? difficulty;
  final String? category;
  final String? startDate;
  final String? endDate;
  final String? sortBy;

  Map<String, String> toQueryMap() => <String, String>{
    'q': ?query,
    'players': ?players,
    'duration': ?duration,
    'difficulty': ?difficulty,
    'category': ?category,
    'start_date': ?startDate,
    'end_date': ?endDate,
    'sort_by': ?sortBy,
  };
}
