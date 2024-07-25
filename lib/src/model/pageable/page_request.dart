import 'package:corasa_core/src/model/pageable/sort_request.dart';

class PageRequest {
  final int? size;
  final int? page;
  final List<SortRequest>? sort;

  PageRequest({
    this.size,
    this.page,
    this.sort,
  });

  Map<String, dynamic> toMap() {
    return {
      'size': size?.toString(),
      'page': page?.toString(),
      'sort': sort?.map((x) => x.toMap()).toList(),
    };
  }
}
