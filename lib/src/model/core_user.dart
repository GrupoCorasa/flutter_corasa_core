import 'package:corasa_core/src/model/side_menu/permission.dart';
import 'package:flutter/material.dart';

abstract mixin class CoreUser {
  String? get getName;
  String? get getUsername;
  List<Permission> get getPermissions;

  List<Permission> sideMenuPermission() =>
      getPermissions.where((p) => p.sideMenuPermission != null).toList();

  Future<void> onLogout(BuildContext context);
}
