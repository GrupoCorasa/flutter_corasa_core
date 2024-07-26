import 'package:corasa_core/src/config/constants.dart';
import 'package:corasa_core/src/enum/pageable_direction.dart';
import 'package:corasa_core/src/model/catalogos.dart';
import 'package:corasa_core/src/model/pageable/sort_request.dart';
import 'package:corasa_core/src/modules/catalogos/catalogos_async_data_source.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void clean() {
    emit(state.copyWith(clean: true));
    state.dataSource?.refreshDatasource();
  }

  void onCreateDataSource(CatalogosAsyncDataSource<T> dataSource) =>
      emit(state.copyWith(dataSource: dataSource));

  ValueChanged<int?> onChangeRowsPerPage() =>
      (value) => emit(state.copyWith(rowsPerPage: value));
}
