/// Pagination response helper for managing paginated data
///
/// Handles pagination metadata and provides utility methods to:
/// - Get next page number
/// - Calculate loaded items count
/// - Calculate remaining items count
/// - Check if more pages are available
class BxPaginationResponse {
  final int page;
  final int limit;
  final int total;
  final int pages;

  const BxPaginationResponse({required this.page, required this.limit, required this.total, required this.pages});

  /// Creates a [BxPaginationResponse] from a JSON map
  factory BxPaginationResponse.fromJson(Map<String, dynamic> json) {
    return BxPaginationResponse(page: json['page'] as int, limit: json['limit'] as int, total: json['total'] as int, pages: json['pages'] as int);
  }

  /// Converts this pagination response to a JSON map
  Map<String, dynamic> toJson() {
    return {'page': page, 'limit': limit, 'total': total, 'pages': pages};
  }

  /// Returns the next page number, or null if on the last page
  int? get nextPage => hasNextPage ? page + 1 : null;

  /// Returns the previous page number, or null if on the first page
  int? get previousPage => hasPreviousPage ? page - 1 : null;

  /// Returns true if there is a next page available
  bool get hasNextPage => page < pages;

  /// Returns true if there is a previous page available
  bool get hasPreviousPage => page > 1;

  /// Returns the number of items loaded so far (up to current page)
  int get loadedCount => page * limit > total ? total : page * limit;

  /// Returns the number of remaining items to load
  int get remainingCount => total - loadedCount;

  /// Returns the number of remaining pages to fetch
  int get remainingPages => pages - page;

  /// Returns true if all data has been loaded
  bool get isComplete => page >= pages;

  /// Returns true if this is the first page
  bool get isFirstPage => page == 1;

  /// Returns true if this is the last page
  bool get isLastPage => page == pages;

  /// Returns the progress percentage (0.0 to 1.0)
  double get progress => total == 0 ? 1.0 : loadedCount / total;

  /// Returns the progress percentage as an integer (0 to 100)
  int get progressPercentage => (progress * 100).round();

  /// Returns a list of all page numbers
  List<int> get allPages => List.generate(pages, (index) => index + 1);

  /// Returns a list of page numbers around the current page (for pagination UI)
  /// [range] specifies how many pages to show on each side of current page
  List<int> getPagesAroundCurrent({int range = 2}) {
    final start = (page - range).clamp(1, pages);
    final end = (page + range).clamp(1, pages);
    return List.generate(end - start + 1, (index) => start + index);
  }

  /// Creates a copy of this response with updated page
  BxPaginationResponse copyWith({int? page, int? limit, int? total, int? pages}) {
    return BxPaginationResponse(page: page ?? this.page, limit: limit ?? this.limit, total: total ?? this.total, pages: pages ?? this.pages);
  }

  @override
  String toString() {
    return 'BxPaginationResponse(page: $page, limit: $limit, '
        'total: $total, pages: $pages)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BxPaginationResponse && other.page == page && other.limit == limit && other.total == total && other.pages == pages;
  }

  @override
  int get hashCode => Object.hash(page, limit, total, pages);
}
