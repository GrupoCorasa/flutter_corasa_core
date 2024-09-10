import 'package:corasa_core/corasa_core.dart';
import 'package:flutter/material.dart';

abstract class MainScreen extends StatelessWidget {
  final GlobalKey<FormBuilderState>? formKey;
  final String title;
  final double openSidebarWidth;
  final double compactSidebarWidth;
  final Map<Widget, void Function(BuildContext)>? headerActions;

  final Color? hoverColor;
  final Color? selectedColor;
  final Color? selectedIconColor;
  final Color? unselectedIconColor;
  final Color? backgroundColor;
  final Color? toggleColor;

  const MainScreen({
    super.key,
    this.formKey,
    required this.title,
    required this.openSidebarWidth,
    this.compactSidebarWidth = 60,
    this.headerActions,
    this.hoverColor,
    this.selectedColor,
    this.selectedIconColor,
    this.unselectedIconColor,
    this.backgroundColor,
    this.toggleColor,
  });

  Function()? onEditComplete(BuildContext context);

  Function(String)? onSearchEvent(BuildContext context);

  List<Widget>? actions(
      BuildContext context, GlobalKey<FormBuilderState>? formKey);

  Widget? endWidget(BuildContext context);

  Widget body(BuildContext context);

  Widget? floatingActionButton(BuildContext context);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(5.0),
                child: LeftSideMenu(
                  openWidth: openSidebarWidth,
                  compactWidth: compactSidebarWidth,
                  hoverColor: hoverColor,
                  selectedColor: selectedColor,
                  selectedIconColor: selectedIconColor,
                  unselectedIconColor: unselectedIconColor,
                  backgroundColor: backgroundColor,
                  toggleColor: toggleColor,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Header(
                      formKey: formKey,
                      additional: actions(context, formKey),
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
