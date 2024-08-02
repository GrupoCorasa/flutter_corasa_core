import 'package:corasa_core/corasa_core.dart';
import 'package:flutter/material.dart';

class SideMenuParent extends Equatable {
  final String displayName;
  final IconData icon;
  final ModulePosition modulePosition;

  const SideMenuParent({
    required this.displayName,
    required this.icon,
    required this.modulePosition,
  });

  @override
  List<Object?> get props => [displayName, icon, modulePosition];
}
