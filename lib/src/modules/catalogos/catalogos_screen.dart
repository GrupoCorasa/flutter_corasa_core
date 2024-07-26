import 'package:corasa_core/src/config/constants.dart';
import 'package:corasa_core/src/model/catalogos.dart';
import 'package:corasa_core/src/modules/catalogos/catalogos_async_data_source.dart';
import 'package:corasa_core/src/modules/catalogos/catalogos_cubit.dart';
import 'package:corasa_core/src/modules/common/main_screen/main_screen.dart';
import 'package:corasa_core/src/utils/ui_utils.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

abstract class CatalogoScreen<T extends CatalogosModel> extends MainScreen {
  const CatalogoScreen({
    super.key,
    required super.title,
    required super.openSidebarWidth,
  });

  @override
  Function()? onEditComplete(BuildContext context) =>
      context.read<CatalogosCubit<T>>().onEditComplete();

  @override
  Function(String p1)? onSearchEvent(BuildContext context) =>
      context.read<CatalogosCubit<T>>().onSearchEvent();

  @override
  List<Widget>? actions(
          BuildContext context, GlobalKey<FormBuilderState>? formKey) =>
      null;

  @override
  Widget? endWidget(BuildContext context) => ElevatedButton.icon(
        onPressed: () => goCatalogo(context, null),
        label: const Text('Agregar'),
        icon: const Icon(Icons.add),
        style: UiUtils.submitDecoration(),
      );

  List<DataColumn2> columns(BuildContext context);

  List<DataCell> cells(T value);

  @override
  Widget body(BuildContext context) {
    return BlocBuilder<CatalogosCubit<T>, CatalogosState<T>>(
      builder: (context, state) => state.loading
          ? const Center(child: CircularProgressIndicator())
          : AsyncPaginatedDataTable2(
              columns: columns(context),
              sortColumnIndex: state.sortColumnIndex,
              sortAscending: state.sortAscending,
              columnSpacing: Constants.defaultGap,
              renderEmptyRowsInTheEnd: false,
              showFirstLastButtons: true,
              rowsPerPage: state.rowsPerPage,
              availableRowsPerPage: state.availableRowsPerPage,
              onRowsPerPageChanged:
                  context.read<CatalogosCubit<T>>().onChangeRowsPerPage(),
              source: state.dataSource ?? createDataSource(context),
              minWidth: state.tableMinWidth,
              hidePaginator: false,
              pageSyncApproach: PageSyncApproach.goToFirst,
            ),
    );
  }

  @override
  Widget? floatingActionButton(BuildContext context) => null;

  CatalogosAsyncDataSource<T> createDataSource(BuildContext context);

  String appPath(T? value);

  Future<void> goCatalogo(BuildContext context, T? value) async {
    CatalogosCubit<T> cubit = context.read<CatalogosCubit<T>>();
    await GoRouter.of(context).push(appPath(value));
    cubit.clean();
  }
}
