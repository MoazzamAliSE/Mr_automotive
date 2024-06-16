import 'package:auto_motive/res/app_color.dart';
import 'package:auto_motive/res/app_text_styles.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: SafeArea(
          child: Column(
        children: [
          const CircleAvatar(
            child: Text(
              "MR.",
              style: AppTextStyles.black24BoldTextStyle,
            ),
          ),
          const Text(
            "Automotive.",
            style: AppTextStyles.white24BoldTextStyle,
          ),
          const SizedBox(
            height: 300,
          ),
          const Text(
            "Unlocking a World of\n Automotive at your\n finger tips.",
            style: AppTextStyles.white24TextStyle,
          ),
          ElevatedButton(onPressed: () {}, child: const Text("Get Started"))
        ],
      )),
    );
  }
}
