import 'package:corasa_core/src/model/pageable/page_request.dart';
import 'package:corasa_core/src/model/pageable/page_response.dart';
import 'package:corasa_core/src/model/pageable/sort_request.dart';
import 'package:corasa_core/src/service/pageable_service.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

abstract class CatalogosAsyncDataSource<T> extends AsyncDataTableSource {
  final BuildContext context;
  final PageableService<T> service;
  final Function(T) onTap;
  SortRequest sortRequest;
  String? filter;

  CatalogosAsyncDataSource({
    required this.context,
    required this.service,
    required this.onTap,
    required this.sortRequest,
  });

  void onFilters(String filter) {
    this.filter = filter;
    refreshDatasource();
  }

  void onSort(SortRequest sortRequest) {
    this.sortRequest = sortRequest;
    refreshDatasource();
  }

  WidgetStateProperty<Color?>? rowColor(BuildContext context, T value);

  @override
  Future<AsyncRowsResponse> getRows(int startIndex, int count) async {
    PageResponse<T> pageResponse = await service.getAll(
      pageRequest: PageRequest(
        page: startIndex ~/ count,
        size: count,
        sort: [
          SortRequest(
            property: sortRequest.property,
            direction: sortRequest.direction,
          )
        ],
      ),
      query: filter == null ? null : {'search': filter!},
    );

    return AsyncRowsResponse(
        pageResponse.totalElements!,
        pageResponse.content!
            .map((catalogo) => contentToDataRow(catalogo))
            .toList());
  }

  DataRow2 contentToDataRow(T content);
}
