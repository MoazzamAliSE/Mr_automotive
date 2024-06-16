import 'package:auto_motive/res/app_color.dart';
import 'package:auto_motive/res/app_text_styles.dart';
import 'package:auto_motive/view/common%20widgets/custom_card.dart';
import 'package:flutter/material.dart';

class OptionsCard extends StatelessWidget {
  const OptionsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ListTile(
        leading: Icon(
          icon,
          color: whiteColor,
        ),
        title: Text(
          title,
          style: AppTextStyles.white12BoldTextStyle,
        ),
        onTap: onTap,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
      ),
    );
  }
}
