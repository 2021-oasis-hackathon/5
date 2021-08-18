import 'package:flutter/material.dart';
import 'package:qount/models/user.dart';

mixin BasePageGenerator {
  Image get icon;
  Image get activeIcon => icon;
  String get label;

  Widget createWidget({
    required UserMe me,
  });

  BottomNavigationBarItem toWidgetItem() {
    return BottomNavigationBarItem(
      icon: icon,
      activeIcon: activeIcon,
      label: label,
    );
  }
}
