import 'package:corasa_core/src/model/side_menu_model.dart';
import 'package:go_router/go_router.dart';

class Permission {
  final String routePath;
  final GoRouterPageBuilder goRouterPage;
  final SideMenuPermission? sideMenuPermission;

  Permission({
    required this.routePath,
    required this.goRouterPage,
    this.sideMenuPermission,
  });
}
