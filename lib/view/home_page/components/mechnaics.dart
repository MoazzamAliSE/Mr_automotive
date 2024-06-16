import 'package:auto_motive/res/app_images.dart';
import 'package:auto_motive/res/app_text_styles.dart';
import 'package:auto_motive/view/common%20widgets/home_round_button.dart';
import 'package:flutter/material.dart';

class MechanicsHomeComponent extends StatelessWidget {
  const MechanicsHomeComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Mechanics",
              style: AppTextStyles.white16BoldTextStyle,
            ),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward),
                label: const Text("See All"))
          ],
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
