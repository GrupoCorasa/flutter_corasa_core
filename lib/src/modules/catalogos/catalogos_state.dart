part of 'catalogos_cubit.dart';

class CatalogosState<T extends CatalogosModel> extends Equatable {
  final bool loading;
  final double tableMinWidth;

  final String? search;
  final CatalogosAsyncDataSource<T>? dataSource;
  final int? sortColumnIndex;
  final bool sortAscending;
  final List<int> availableRowsPerPage;
  final int rowsPerPage;

  const CatalogosState({
    this.loading = false,
    this.tableMinWidth = Constants.twoColumnWidth,
    this.search,
    this.dataSource,
    this.sortColumnIndex = 0,
    this.sortAscending = true,
    this.availableRowsPerPage = const [20, 50, 100],
    this.rowsPerPage = 20,
  });

  CatalogosState<T> copyWith({
    bool? loading,
    double? tableMinWidth,
    CatalogosAsyncDataSource<T>? dataSource,
    bool clean = false,
    String? search,
    int? sortColumnIndex,
    bool? sortAscending,
    List<int>? availableRowsPerPage,
    int? rowsPerPage,
  }) {
    return CatalogosState(
      loading: loading ?? this.loading,
      tableMinWidth: tableMinWidth ?? this.tableMinWidth,
      dataSource: dataSource ?? this.dataSource,
      search: clean ? null : search ?? this.search,
      sortColumnIndex: clean ? null : sortColumnIndex ?? this.sortColumnIndex,
      sortAscending: clean ? true : sortAscending ?? this.sortAscending,
      availableRowsPerPage: availableRowsPerPage ?? this.availableRowsPerPage,
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        tableMinWidth,
        dataSource,
        search,
        sortColumnIndex,
        sortAscending,
        availableRowsPerPage,
        rowsPerPage,
      ];
}
