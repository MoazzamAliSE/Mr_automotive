import 'package:auto_motive/res/app_color.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      required this.title,
      this.automaticallyImplyLeading = true,
      this.icon = Icons.arrow_forward,
      this.onPressed});
  final String title;
  final bool? automaticallyImplyLeading;
  final void Function()? onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      centerTitle: true,
      backgroundColor: darkBackgroundColor,
      foregroundColor: whiteColor,
      actions: [
        if (onPressed != null)
          IconButton(onPressed: onPressed, icon: Icon(icon))
      ],
      title: Text(
        title,
        style: const TextStyle(
            color: whiteColor, fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
