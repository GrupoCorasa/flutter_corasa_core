import 'package:corasa_core/src/config/constants.dart';
import 'package:corasa_core/src/enum/module_position.dart';
import 'package:corasa_core/src/modules/common/auth/auth_cubit.dart';
import 'package:corasa_core/src/utils/ui_utils.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class LeftSideMenu extends StatelessWidget {
  final double openWidth;
  final double compactWidth;

  final Color? hoverColor;
  final Color? selectedColor;
  final Color? selectedIconColor;
  final Color? unselectedIconColor;
  final Color? backgroundColor;
  final Color? toggleColor;

  const LeftSideMenu({
    super.key,
    required this.openWidth,
    this.compactWidth = 60,
    this.hoverColor,
    this.selectedColor,
    this.selectedIconColor,
    this.unselectedIconColor,
    this.backgroundColor,
    this.toggleColor,
  });

  SideMenuStyle _sideBarStyle(BuildContext context) => SideMenuStyle(
        displayMode: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
            ? SideMenuDisplayMode.compact
            : SideMenuDisplayMode.open,
        decoration: UiUtils.boxDecoration(context),
        openSideMenuWidth: openWidth,
        compactSideMenuWidth: compactWidth,
        hoverColor: hoverColor,
        selectedColor: selectedColor,
        selectedIconColor: selectedIconColor,
        unselectedIconColor: unselectedIconColor,
        backgroundColor: backgroundColor,
        iconSize: 20,
        showTooltip: true,
        showHamburger: false,
        toggleColor: toggleColor,
        iconSizeExpandable: 25.0,
      );

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) => SideMenu(
          showToggle: true,
          style: _sideBarStyle(context),
          controller: state.sideMenucontroller,
          title: Container(
              margin: const EdgeInsets.all(Constants.defaultGap),
              child: Image(image: state.logo)),
          items: [
            SideMenuItem(
              title: 'Home',
              onTap: (index, controller) => _onTap(context, state, index, '/'),
              icon: const Icon(Icons.home),
            ),
            if (state.user!.sideMenuPermission().any((p) =>
                p.sideMenuPermission!.modulePosition == ModulePosition.top &&
                p.sideMenuPermission!.parent == null))
              ...state.user!
                  .sideMenuPermission()
                  .where((p) =>
                      p.sideMenuPermission!.modulePosition ==
                          ModulePosition.top &&
                      p.sideMenuPermission!.parent == null)
                  .map((p) => SideMenuItem(
                        title: p.sideMenuPermission!.displayName,
                        onTap: (index, controller) =>
                            _onTap(context, state, index, p.routePath),
                        icon: Icon(p.sideMenuPermission!.icon),
                      )),
            if (state.user!.sideMenuPermission().any((p) =>
                p.sideMenuPermission!.modulePosition == ModulePosition.top &&
                p.sideMenuPermission!.parent != null))
              ...state.user!
                  .sideMenuPermission()
                  .where((p) =>
                      p.sideMenuPermission!.modulePosition ==
                          ModulePosition.top &&
                      p.sideMenuPermission!.parent != null)
                  .map((p) => p.sideMenuPermission!.parent!)
                  .toSet()
                  .map((p) => SideMenuExpansionItem(
                        title: p.displayName,
                        icon: Icon(p.icon),
                        children: state.user!
                            .sideMenuPermission()
                            .where((c) =>
                                c.sideMenuPermission!.modulePosition ==
                                    ModulePosition.top &&
                                p == c.sideMenuPermission!.parent)
                            .map((p) => SideMenuItem(
                                  title: p.sideMenuPermission!.displayName,
                                  onTap: (index, controller) => _onTap(
                                      context, state, index, p.routePath),
                                  icon: Icon(p.sideMenuPermission!.icon),
                                ))
                            .toList(),
                      )),
            if (state.user!.sideMenuPermission().any((p) =>
                p.sideMenuPermission!.modulePosition ==
                    ModulePosition.catalog &&
                p.sideMenuPermission!.parent == null))
              SideMenuExpansionItem(
                title: 'Catálogos',
                icon: const Icon(Icons.list_rounded),
                children: state.user!
                    .sideMenuPermission()
                    .where((p) =>
                        p.sideMenuPermission!.modulePosition ==
                            ModulePosition.catalog &&
                        p.sideMenuPermission!.parent == null)
                    .map((p) => SideMenuItem(
                          title: p.sideMenuPermission!.displayName,
                          onTap: (index, controller) =>
                              _onTap(context, state, index, p.routePath),
                          icon: Icon(p.sideMenuPermission!.icon),
                        ))
                    .toList(),
              ),
            if (state.user!.sideMenuPermission().any((p) =>
                p.sideMenuPermission!.modulePosition ==
                    ModulePosition.catalog &&
                p.sideMenuPermission!.parent != null))
              ...state.user!
                  .sideMenuPermission()
                  .where((p) =>
                      p.sideMenuPermission!.modulePosition ==
                          ModulePosition.catalog &&
                      p.sideMenuPermission!.parent != null)
                  .map((p) => p.sideMenuPermission!.parent!)
                  .toSet()
                  .map((p) => SideMenuExpansionItem(
                        title: p.displayName,
                        icon: Icon(p.icon),
                        children: state.user!
                            .sideMenuPermission()
                            .where((c) =>
                                c.sideMenuPermission!.modulePosition ==
                                    ModulePosition.catalog &&
                                p == c.sideMenuPermission!.parent)
                            .map((p) => SideMenuItem(
                                  title: p.sideMenuPermission!.displayName,
                                  onTap: (index, controller) => _onTap(
                                      context, state, index, p.routePath),
                                  icon: Icon(p.sideMenuPermission!.icon),
                                ))
                            .toList(),
                      )),
            if (state.user!.sideMenuPermission().any((p) =>
                p.sideMenuPermission!.modulePosition == ModulePosition.mid &&
                p.sideMenuPermission!.parent == null))
              ...state.user!
                  .sideMenuPermission()
                  .where((p) =>
                      p.sideMenuPermission!.modulePosition ==
                          ModulePosition.mid &&
                      p.sideMenuPermission!.parent == null)
                  .map((p) => SideMenuItem(
                        title: p.sideMenuPermission!.displayName,
                        onTap: (index, controller) =>
                            _onTap(context, state, index, p.routePath),
                        icon: Icon(p.sideMenuPermission!.icon),
                      )),
            if (state.user!.sideMenuPermission().any((p) =>
                p.sideMenuPermission!.modulePosition == ModulePosition.mid &&
                p.sideMenuPermission!.parent != null))
              ...state.user!
                  .sideMenuPermission()
                  .where((p) =>
                      p.sideMenuPermission!.modulePosition ==
                          ModulePosition.mid &&
                      p.sideMenuPermission!.parent != null)
                  .map((p) => p.sideMenuPermission!.parent!)
                  .toSet()
                  .map((p) => SideMenuExpansionItem(
                        title: p.displayName,
                        icon: Icon(p.icon),
                        children: state.user!
                            .sideMenuPermission()
                            .where((c) =>
                                c.sideMenuPermission!.modulePosition ==
                                    ModulePosition.mid &&
                                p == c.sideMenuPermission!.parent)
                            .map((p) => SideMenuItem(
                                  title: p.sideMenuPermission!.displayName,
                                  onTap: (index, controller) => _onTap(
                                      context, state, index, p.routePath),
                                  icon: Icon(p.sideMenuPermission!.icon),
                                ))
                            .toList(),
                      )),
            if (state.user!.sideMenuPermission().any((p) =>
                p.sideMenuPermission!.modulePosition ==
                    ModulePosition.settings &&
                p.sideMenuPermission!.parent == null))
              SideMenuExpansionItem(
                title: 'Configuración',
                icon: const Icon(Icons.settings),
                children: state.user!
                    .sideMenuPermission()
                    .where((p) =>
                        p.sideMenuPermission!.modulePosition ==
                            ModulePosition.settings &&
                        p.sideMenuPermission!.parent == null)
                    .map((p) => SideMenuItem(
                          title: p.sideMenuPermission!.displayName,
                          onTap: (index, controller) =>
                              _onTap(context, state, index, p.routePath),
                          icon: Icon(p.sideMenuPermission!.icon),
                        ))
                    .toList(),
              ),
            if (state.user!.sideMenuPermission().any((p) =>
                p.sideMenuPermission!.modulePosition ==
                    ModulePosition.settings &&
                p.sideMenuPermission!.parent != null))
              ...state.user!
                  .sideMenuPermission()
                  .where((p) =>
                      p.sideMenuPermission!.modulePosition ==
                          ModulePosition.settings &&
                      p.sideMenuPermission!.parent != null)
                  .map((p) => p.sideMenuPermission!.parent!)
                  .toSet()
                  .map((p) => SideMenuExpansionItem(
                        title: p.displayName,
                        icon: Icon(p.icon),
                        children: state.user!
                            .sideMenuPermission()
                            .where((c) =>
                                c.sideMenuPermission!.modulePosition ==
                                    ModulePosition.settings &&
                                p == c.sideMenuPermission!.parent)
                            .map((p) => SideMenuItem(
                                  title: p.sideMenuPermission!.displayName,
                                  onTap: (index, controller) => _onTap(
                                      context, state, index, p.routePath),
                                  icon: Icon(p.sideMenuPermission!.icon),
                                ))
                            .toList(),
                      )),
            if (state.user!.sideMenuPermission().any((p) =>
                p.sideMenuPermission!.modulePosition == ModulePosition.bottom &&
                p.sideMenuPermission!.parent == null))
              ...state.user!
                  .sideMenuPermission()
                  .where((p) =>
                      p.sideMenuPermission!.modulePosition ==
                      ModulePosition.bottom)
                  .map((p) => SideMenuItem(
                        title: p.sideMenuPermission!.displayName,
                        onTap: (index, controller) =>
                            _onTap(context, state, index, p.routePath),
                        icon: Icon(p.sideMenuPermission!.icon),
                      )),
            if (state.user!.sideMenuPermission().any((p) =>
                p.sideMenuPermission!.modulePosition == ModulePosition.bottom &&
                p.sideMenuPermission!.parent != null))
              ...state.user!
                  .sideMenuPermission()
                  .where((p) =>
                      p.sideMenuPermission!.modulePosition ==
                          ModulePosition.bottom &&
                      p.sideMenuPermission!.parent != null)
                  .map((p) => p.sideMenuPermission!.parent!)
                  .toSet()
                  .map((p) => SideMenuExpansionItem(
                        title: p.displayName,
                        icon: Icon(p.icon),
                        children: state.user!
                            .sideMenuPermission()
                            .where((c) =>
                                c.sideMenuPermission!.modulePosition ==
                                    ModulePosition.bottom &&
                                p == c.sideMenuPermission!.parent)
                            .map((p) => SideMenuItem(
                                  title: p.sideMenuPermission!.displayName,
                                  onTap: (index, controller) => _onTap(
                                      context, state, index, p.routePath),
                                  icon: Icon(p.sideMenuPermission!.icon),
                                ))
                            .toList(),
                      )),
            if (state.user!.sideMenuPermission().any((p) =>
                p.sideMenuPermission!.modulePosition ==
                    ModulePosition.reports &&
                p.sideMenuPermission!.parent == null))
              SideMenuExpansionItem(
                title: 'Reportes',
                icon: const Icon(Icons.dashboard_customize),
                children: state.user!
                    .sideMenuPermission()
                    .where((p) =>
                        p.sideMenuPermission!.modulePosition ==
                        ModulePosition.reports)
                    .map((p) => SideMenuItem(
                          title: p.sideMenuPermission!.displayName,
                          onTap: (index, controller) =>
                              _onTap(context, state, index, p.routePath),
                          icon: Icon(p.sideMenuPermission!.icon),
                        ))
                    .toList(),
              ),
            if (state.user!.sideMenuPermission().any((p) =>
                p.sideMenuPermission!.modulePosition ==
                    ModulePosition.reports &&
                p.sideMenuPermission!.parent != null))
              ...state.user!
                  .sideMenuPermission()
                  .where((p) =>
                      p.sideMenuPermission!.modulePosition ==
                          ModulePosition.reports &&
                      p.sideMenuPermission!.parent != null)
                  .map((p) => p.sideMenuPermission!.parent!)
                  .toSet()
                  .map((p) => SideMenuExpansionItem(
                        title: p.displayName,
                        icon: Icon(p.icon),
                        children: state.user!
                            .sideMenuPermission()
                            .where((c) =>
                                c.sideMenuPermission!.modulePosition ==
                                    ModulePosition.reports &&
                                p == c.sideMenuPermission!.parent)
                            .map((p) => SideMenuItem(
                                  title: p.sideMenuPermission!.displayName,
                                  onTap: (index, controller) => _onTap(
                                      context, state, index, p.routePath),
                                  icon: Icon(p.sideMenuPermission!.icon),
                                ))
                            .toList(),
                      )),
          ],
        ),
      );

  void _onTap(
    BuildContext context,
    AuthState state,
    int index,
    String routePath,
  ) {
    state.sideMenucontroller.changePage(index);
    if (!routePath.startsWith(r'/')) {
      routePath = '/$routePath';
    }
    GoRouter.of(context).replace(routePath);
  }
}
