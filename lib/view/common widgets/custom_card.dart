import 'package:auto_motive/res/app_color.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.shadowColor,
    this.color,
  });
  final Color? shadowColor;
  final Color? color;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: whiteColor,
      color: darkBackgroundColor,
      child: child,
    );
  }
}
