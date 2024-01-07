import 'package:flutter/material.dart';

class BottomNavBarItem extends StatelessWidget {
  final int index;
  final bool isActive;
  final String label;
  final String icon;
  final String activeIcon;

  const BottomNavBarItem(
      {super.key,
      required this.index,
      required this.isActive,
      required this.label,
      required this.icon,
      required this.activeIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25,
          width: 25,
          child: Image.asset(isActive ? activeIcon : icon),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
