/// Generic paginated response model matching backend PaginatedResponse.
class PaginatedResponse<T> {
  /// Creates a paginated response.
  const PaginatedResponse({
    required this.items,
    required this.total,
    required this.page,
    required this.limit,
    required this.pages,
  });

  /// Builds a paginated response from JSON.
  factory PaginatedResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) {
    return PaginatedResponse<T>(
      items: (json['items'] as List).map((item) => fromJsonT(item)).toList(),
      total: json['total'] as int,
      page: json['page'] as int,
      limit: json['limit'] as int,
      pages: json['pages'] as int,
    );
  }

  /// Current page items.
  final List<T> items;

  /// Total number of items across all pages.
  final int total;

  /// Current page index.
  final int page;

  /// Page size.
  final int limit;

  /// Total number of pages.
  final int pages;
}
