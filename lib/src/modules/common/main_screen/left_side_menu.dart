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

  const LeftSideMenu({
    super.key,
    required this.openWidth,
    this.compactWidth = 60,
  });

  SideMenuStyle _sideBarStyle(BuildContext context) => SideMenuStyle(
        displayMode: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
            ? SideMenuDisplayMode.compact
            : SideMenuDisplayMode.open,
        decoration: UiUtils.boxDecoration(context),
        openSideMenuWidth: openWidth,
        compactSideMenuWidth: compactWidth,
        hoverColor: Colors.blue[100],
        selectedColor: Colors.lightBlue,
        selectedIconColor: Colors.white,
        unselectedIconColor: Colors.black54,
        backgroundColor: Theme.of(context).splashColor,
        selectedTitleTextStyle: const TextStyle(color: Colors.white),
        unselectedTitleTextStyle: const TextStyle(color: Colors.black54),
        iconSize: 20,
        itemBorderRadius: const BorderRadius.all(Radius.circular(40.0)),
        showTooltip: true,
        showHamburger: false,
        toggleColor: Colors.black54,
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
                  .toSet()
                  .map((p) => SideMenuExpansionItem(
                        title: p.sideMenuPermission!.parent!.displayName,
                        icon: Icon(p.sideMenuPermission!.parent!.icon),
                        children: state.user!
                            .sideMenuPermission()
                            .where((c) =>
                                c.sideMenuPermission!.modulePosition ==
                                    ModulePosition.top &&
                                p.sideMenuPermission!.parent ==
                                    c.sideMenuPermission!.parent)
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
                  .toSet()
                  .map((p) => SideMenuExpansionItem(
                        title: p.sideMenuPermission!.parent!.displayName,
                        icon: Icon(p.sideMenuPermission!.parent!.icon),
                        children: state.user!
                            .sideMenuPermission()
                            .where((c) =>
                                c.sideMenuPermission!.modulePosition ==
                                    ModulePosition.catalog &&
                                p.sideMenuPermission!.parent ==
                                    c.sideMenuPermission!.parent)
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
                  .toSet()
                  .map((p) => SideMenuExpansionItem(
                        title: p.sideMenuPermission!.parent!.displayName,
                        icon: Icon(p.sideMenuPermission!.parent!.icon),
                        children: state.user!
                            .sideMenuPermission()
                            .where((c) =>
                                c.sideMenuPermission!.modulePosition ==
                                    ModulePosition.mid &&
                                p.sideMenuPermission!.parent ==
                                    c.sideMenuPermission!.parent)
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
                  .toSet()
                  .map((p) => SideMenuExpansionItem(
                        title: p.sideMenuPermission!.parent!.displayName,
                        icon: Icon(p.sideMenuPermission!.parent!.icon),
                        children: state.user!
                            .sideMenuPermission()
                            .where((c) =>
                                c.sideMenuPermission!.modulePosition ==
                                    ModulePosition.settings &&
                                p.sideMenuPermission!.parent ==
                                    c.sideMenuPermission!.parent)
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
                  .toSet()
                  .map((p) => SideMenuExpansionItem(
                        title: p.sideMenuPermission!.parent!.displayName,
                        icon: Icon(p.sideMenuPermission!.parent!.icon),
                        children: state.user!
                            .sideMenuPermission()
                            .where((c) =>
                                c.sideMenuPermission!.modulePosition ==
                                    ModulePosition.bottom &&
                                p.sideMenuPermission!.parent ==
                                    c.sideMenuPermission!.parent)
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
                  .toSet()
                  .map((p) => SideMenuExpansionItem(
                        title: p.sideMenuPermission!.parent!.displayName,
                        icon: Icon(p.sideMenuPermission!.parent!.icon),
                        children: state.user!
                            .sideMenuPermission()
                            .where((c) =>
                                c.sideMenuPermission!.modulePosition ==
                                    ModulePosition.reports &&
                                p.sideMenuPermission!.parent ==
                                    c.sideMenuPermission!.parent)
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
