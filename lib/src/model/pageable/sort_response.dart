class SortResponse {
  final bool? sorted;
  final bool? unsorted;
  final bool? empty;

  SortResponse({
    this.sorted,
    this.unsorted,
    this.empty,
  });

  factory SortResponse.fromMap(Map<String, dynamic> map) {
    return SortResponse(
      sorted: map['sorted'] as bool,
      unsorted: map['unsorted'] as bool,
      empty: map['empty'] as bool,
    );
  }
}
