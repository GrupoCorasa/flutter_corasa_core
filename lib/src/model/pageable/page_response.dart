import 'package:corasa_core/src/model/pageable/pageable_response.dart';
import 'package:corasa_core/src/model/pageable/sort_response.dart';

class PageResponse<T> {
  final int? totalPages;
  final int? totalElements;
  final PageableResponse? pageable;
  final bool? first;
  final bool? last;
  final int? size;
  final List<T>? content;
  final int? number;
  final SortResponse? sort;
  final int? numberOfElements;
  final bool? empty;

  PageResponse({
    this.totalPages,
    this.totalElements,
    this.pageable,
    this.first,
    this.last,
    this.size,
    this.content,
    this.number,
    this.sort,
    this.numberOfElements,
    this.empty,
  });

  factory PageResponse.fromMap(
      Map<String, dynamic> map, T Function(dynamic) fromMap) {
    return PageResponse(
      totalPages: map['totalPages'],
      totalElements: map['totalElements'],
      pageable: map['pageable'] != null
          ? PageableResponse.fromMap(map['pageable'])
          : null,
      first: map['first'],
      last: map['last'],
      size: map['size'],
      content: map['content'] != null
          ? List<T>.from(map['content'].map(fromMap))
          : null,
      number: map['number'],
      sort: map['sort'] != null ? SortResponse.fromMap(map['sort']) : null,
      numberOfElements: map['numberOfElements'],
      empty: map['empty'],
    );
  }
}
