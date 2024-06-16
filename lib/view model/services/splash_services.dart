import 'dart:async';
import 'package:auto_motive/Data/shared%20pref/shared_pref.dart';
import 'package:auto_motive/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../res/routes/routes.dart';

class SplashServices {
  static  checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? uid = pref.getString('TOKEN');
    Timer(const Duration(milliseconds: 2000), () async {
      if (uid == null || FirebaseAuth.instance.currentUser==null) {
        Get.offNamed(Routes.signUpScreen);
      } else {
        localUser = await UserPref.getUser();
        Get.offNamed(Routes.home);
      }
    });
  }
}
