import 'package:auto_motive/res/app_images.dart';
import 'package:auto_motive/res/app_text_styles.dart';
import 'package:auto_motive/view/common%20widgets/home_round_button.dart';
import 'package:flutter/material.dart';

class BrowseCategoriesHomeComponent extends StatelessWidget {
  const BrowseCategoriesHomeComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Browse Categories",
          style: AppTextStyles.white16BoldTextStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            RoundedImageButton(
              text: 'Press me',
              imagePath: AppImages.splashLogo,
              onPressed: () {
                print('Button pressed!');
              },
            ),
            const SizedBox(
              width: 10,
            ),
            RoundedImageButton(
              text: 'Press me',
              imagePath: AppImages.splashLogo,
              onPressed: () {
                print('Button pressed!');
              },
            ),
          ],
        ),
      ],
    );
  }
}
