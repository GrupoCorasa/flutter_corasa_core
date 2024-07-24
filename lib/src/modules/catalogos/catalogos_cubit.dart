import 'package:corasa_core/src/model/catalogos.dart';
import 'package:corasa_core/src/modules/catalogos/catalogo_data_source.dart';
import 'package:corasa_core/src/service/catalogo_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'catalogos_state.dart';

abstract class CatalogosCubit<T extends CatalogosModel>
    extends Cubit<CatalogosState<T>> {
  final CatalogoService<T> _service;

  CatalogosCubit(this._service) : super(CatalogosState<T>()) {
    fetch();
  }

  Future<void> fetch() async {
    emit(state.copyWith(loading: true));
    List<T> catalogos = await _service.getAll();
    emit(state.copyWith(loading: false, catalogos: catalogos));
  }

  bool Function(T value) filtered();

  int Function(T a, T b)? sorted();

  DataColumnSortCallback onSort() => (int columnIndex, bool ascending) {
        emit(state.copyWith(
          sortColumnIndex: columnIndex,
          sortAscending: ascending,
        ));
      };

  Function(String) onSearchEvent() =>
      (newValue) => emit(state.copyWith(search: newValue));

  void clean() => emit(state.copyWith(clean: true));

  ValueChanged<int?> onChangeRowsPerPage() =>
      (value) => emit(state.copyWith(rowsPerPage: value));
}
