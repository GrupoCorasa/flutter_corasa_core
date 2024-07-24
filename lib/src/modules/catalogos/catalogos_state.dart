part of 'catalogos_cubit.dart';

class CatalogosState<T extends CatalogosModel> extends Equatable {
  final bool loading;
  final List<T> catalogos;
  final CatalogoDataSource<T>? dataSource;
  final String? search;
  final int? sortColumnIndex;
  final bool sortAscending;
  final int rowsPerPage;

  const CatalogosState({
    this.loading = false,
    this.catalogos = const [],
    this.dataSource,
    this.search,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.rowsPerPage = 20,
  });

  CatalogosState<T> copyWith({
    bool? loading,
    List<T>? catalogos,
    CatalogoDataSource<T>? dataSource,
    bool clean = false,
    String? search,
    int? sortColumnIndex,
    bool? sortAscending,
    int? rowsPerPage,
  }) {
    return CatalogosState(
      loading: loading ?? this.loading,
      catalogos: catalogos ?? this.catalogos,
      dataSource: dataSource ?? this.dataSource,
      search: clean ? null : search ?? this.search,
      sortColumnIndex: clean ? null : sortColumnIndex ?? this.sortColumnIndex,
      sortAscending: clean ? true : sortAscending ?? this.sortAscending,
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        catalogos,
        dataSource,
        search,
        sortColumnIndex,
        sortAscending,
      ];
}
