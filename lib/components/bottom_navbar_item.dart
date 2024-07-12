import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavItem {
  final dynamic
      icon; // Can be IconData or SvgPicture
  final String label;
  final String page;

  BottomNavItem({
    required this.icon,
    required this.label,
    required this.page,
  });

  BottomNavigationBarItem build() {
    if (icon is IconData) {
      return BottomNavigationBarItem(
        icon: Icon(
          icon,
          size: 36,
        ),
        label: label,
      );
    } else if (icon is SvgPicture) {
      return BottomNavigationBarItem(
        icon: icon,
        label: label,
      );
    } else {
      throw Exception('Unsupported icon type');
    }
  }
}
