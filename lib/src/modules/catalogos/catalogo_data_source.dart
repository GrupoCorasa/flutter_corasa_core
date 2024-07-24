import 'package:corasa_core/src/model/catalogos.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class CatalogoDataSource<T extends CatalogosModel> extends DataTableSource {
  final List<T> catalogos;

  final List<DataCell> Function(T value) cells;
  final WidgetStateProperty<Color?>? Function(T) rowColor;
  final Function(T?) goCatalogo;

  CatalogoDataSource(
    this.catalogos,
    this.cells,
    this.rowColor,
    this.goCatalogo,
  );

  @override
  DataRow2 getRow(int index, [Color? color]) {
    final catalogo = catalogos[index];
    return DataRow2.byIndex(
      index: index,
      color: rowColor(catalogo),
      cells: cells(catalogo),
      onTap: () => goCatalogo(catalogo),
    );
  }

  @override
  int get rowCount => catalogos.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
