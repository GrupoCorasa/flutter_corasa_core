import 'package:corasa_core/src/model/catalogos.dart';
import 'package:corasa_core/src/modules/catalogos/catalogo_data_source.dart';
import 'package:corasa_core/src/modules/catalogos/catalogos_cubit.dart';
import 'package:corasa_core/src/modules/common/main_screen/main_screen.dart';
import 'package:corasa_core/src/utils/ui_utils.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class CatalogoScreen<T extends CatalogosModel> extends MainScreen {
  const CatalogoScreen({
    super.key,
    required super.title,
    required super.openSidebarWidth,
  });

  @override
  Function(String p1)? onSearchEvent(BuildContext context) =>
      context.read<CatalogosCubit<T>>().onSearchEvent();

  @override
  List<Widget>? actions(BuildContext context) => null;

  @override
  Widget? endWidget(BuildContext context) => ElevatedButton.icon(
        onPressed: () => goCatalogo(context, null),
        label: const Text('Agregar'),
        icon: const Icon(Icons.add),
        style: UiUtils.submitDecoration(),
      );

  List<DataColumn2> columns(BuildContext context);

  List<DataCell> cells(T value);

  WidgetStateProperty<Color?>? rowColor(BuildContext context, T value);

  @override
  Widget body(BuildContext context) {
    return BlocBuilder<CatalogosCubit<T>, CatalogosState<T>>(
      builder: (context, state) => state.loading
          ? const Center(child: CircularProgressIndicator())
          : PaginatedDataTable2(
              columns: columns(context),
              sortColumnIndex: state.sortColumnIndex,
              sortAscending: state.sortAscending,
              renderEmptyRowsInTheEnd: false,
              rowsPerPage: 20,
              availableRowsPerPage: const [20, 50, 100],
              onRowsPerPageChanged: (value) =>
                  context.read<CatalogosCubit<T>>().onChangeRowsPerPage(),
              source: CatalogoDataSource(
                (state.catalogos
                    .where(context.read<CatalogosCubit<T>>().filtered())
                    .toList())
                  ..sort(context.read<CatalogosCubit<T>>().sorted()),
                (value) => cells(value),
                (value) => rowColor(context, value),
                (value) => goCatalogo(context, value),
              ),
              hidePaginator: false,
            ),
    );
  }

  @override
  Widget? floatingActionButton(BuildContext context) => null;

  String appPath(T? value);

  Future<void> goCatalogo(BuildContext context, T? value) async {
    CatalogosCubit<T> cubit = context.read<CatalogosCubit<T>>();
    await GoRouter.of(context).push(appPath(value));
    cubit
      ..clean()
      ..fetch();
  }
}
