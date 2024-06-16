import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common widgets/back_button.dart';

class SignUpBar extends StatelessWidget {
  const SignUpBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomBackButton(
          onTap: () => Get.back(),
        ),
        const SizedBox(
          width: 20,
        ),
        const Text(
          'Sign up',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        )
      ],
    );
  }
}
