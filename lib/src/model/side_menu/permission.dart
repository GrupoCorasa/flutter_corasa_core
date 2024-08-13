import 'package:corasa_core/src/model/side_menu/side_menu_model.dart';
import 'package:equatable/equatable.dart';
import 'package:go_router/go_router.dart';

class Permission extends Equatable {
  final String routePath;
  final GoRouterPageBuilder goRouterPage;
  final SideMenuPermission? sideMenuPermission;

  const Permission({
    required this.routePath,
    required this.goRouterPage,
    this.sideMenuPermission,
  });

  @override
  List<Object?> get props => [routePath, goRouterPage, sideMenuPermission];
}
