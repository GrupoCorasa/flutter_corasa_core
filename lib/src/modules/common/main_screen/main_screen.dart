import 'package:corasa_core/src/modules/common/main_screen/header.dart';
import 'package:corasa_core/src/modules/common/main_screen/left_side_menu.dart';
import 'package:flutter/material.dart';

abstract class MainScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final String title;
  final double openSidebarWidth;
  final double compactSidebarWidth;
  final Map<Widget, VoidCallback>? headerActions;

  const MainScreen({
    super.key,
    this.scaffoldKey,
    required this.title,
    required this.openSidebarWidth,
    this.compactSidebarWidth = 60,
    this.headerActions,
  });

  Function()? onEditComplete(BuildContext context);

  Function(String)? onSearchEvent(BuildContext context);

  List<Widget>? actions(BuildContext context);

  Widget? endWidget(BuildContext context);

  Widget body(BuildContext context);

  Widget? floatingActionButton(BuildContext context);

  @override
  Widget build(BuildContext context) => Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(5.0),
                child: LeftSideMenu(
                  openWidth: openSidebarWidth,
                  compactWidth: compactSidebarWidth,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Header(
                      additional: actions(context),
                      title: title,
                      onEditComplete: onEditComplete(context),
                      onSearchEvent: onSearchEvent(context),
                      endWidget: endWidget(context),
                      headerActions: headerActions,
                    ),
                    Expanded(child: body(context)),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: floatingActionButton(context),
      );
}
