import 'package:auto_motive/res/app_images.dart';
import 'package:flutter/material.dart';

import '../../res/app_color.dart';
import '../../view model/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashServices.checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: Center(
          child: Image.asset(
        AppImages.splashLogo,
        height: 150,
        width: 150,
      )),
    );
  }
}
