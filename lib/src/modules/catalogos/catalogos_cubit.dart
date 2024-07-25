import 'package:corasa_core/corasa_core.dart';
import 'package:flutter/material.dart';

part 'catalogos_state.dart';

abstract class CatalogosCubit<T extends CatalogosModel>
    extends Cubit<CatalogosState<T>> {
  CatalogosCubit() : super(CatalogosState<T>());

  DataColumnSortCallback onSort(String property) =>
      (int columnIndex, bool ascending) {
        emit(state.copyWith(
          sortColumnIndex: columnIndex,
          sortAscending: ascending,
        ));
        state.dataSource?.onSort(SortRequest(
          property: property,
          direction: ascending ? PageableDirection.asc : PageableDirection.desc,
        ));
      };

  Function(String) onSearchEvent() => (newValue) {
        emit(state.copyWith(search: newValue));
      };

  Function() onEditComplete() => () {
        state.dataSource?.onFilters(state.search ?? '');
      };

  void clean() => emit(state.copyWith(clean: true));

  void onCreateDataSource(CatalogosAsyncDataSource<T> dataSource) =>
      emit(state.copyWith(dataSource: dataSource));

  ValueChanged<int?> onChangeRowsPerPage() =>
      (value) => emit(state.copyWith(rowsPerPage: value));
}
