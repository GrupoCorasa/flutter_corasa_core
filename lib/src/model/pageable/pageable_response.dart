import 'package:corasa_core/src/model/pageable/sort_response.dart';

class PageableResponse {
  final int? pageNumber;
  final int? pageSize;
  final SortResponse? sort;
  final int? offset;
  final bool? paged;
  final bool? unpaged;

  PageableResponse({
    required this.pageNumber,
    required this.pageSize,
    required this.sort,
    required this.offset,
    required this.paged,
    required this.unpaged,
  });

  factory PageableResponse.fromMap(Map<String, dynamic> map) {
    return PageableResponse(
      pageNumber: map['pageNumber'].toInt() as int,
      pageSize: map['pageSize'].toInt() as int,
      sort: map['sort'] == null
          ? null
          : SortResponse.fromMap(map['sort'] as Map<String, dynamic>),
      offset: map['offset'].toInt() as int,
      paged: map['paged'] as bool,
      unpaged: map['unpaged'] as bool,
    );
  }
}
