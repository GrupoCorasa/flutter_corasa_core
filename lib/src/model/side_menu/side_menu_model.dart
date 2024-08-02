import 'package:corasa_core/src/enum/module_position.dart';
import 'package:corasa_core/src/model/side_menu/side_menu_parent.dart';
import 'package:flutter/material.dart';

class SideMenuPermission {
  final String module;
  final String displayName;
  final IconData icon;
  final ModulePosition modulePosition;
  final SideMenuParent? parent;

  SideMenuPermission({
    required this.module,
    required this.displayName,
    required this.icon,
    required this.modulePosition,
    this.parent,
  });
}
