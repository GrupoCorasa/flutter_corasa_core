import 'package:corasa_core/src/enum/module_position.dart';
import 'package:corasa_core/src/model/side_menu/side_menu_parent.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SideMenuPermission extends Equatable {
  final String module;
  final String displayName;
  final IconData icon;
  final ModulePosition modulePosition;
  final SideMenuParent? parent;

  const SideMenuPermission({
    required this.module,
    required this.displayName,
    required this.icon,
    required this.modulePosition,
    this.parent,
  });

  @override
  List<Object?> get props {
    return [
      module,
      displayName,
      icon,
      modulePosition,
      parent,
    ];
  }
}
