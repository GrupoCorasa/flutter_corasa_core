import 'package:corasa_core/src/model/permission.dart';

abstract mixin class CoreUser {
  String? get getName;
  String? get getUsername;
  List<Permission> get getPermissions;

  List<Permission> sideMenuPermission() =>
      getPermissions.where((p) => p.sideMenuPermission != null).toList();
}
