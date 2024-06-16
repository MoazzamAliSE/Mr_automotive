import 'package:auto_motive/model/user_model.dart';
import 'package:auto_motive/res/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPref {
  static Future<void> setUser({required UserModel user}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('NAME', user.name.toString());
    pref.setString('EMAIL', user.email.toString());
    pref.setDouble('LONGITUDE', user.longitude!);
    pref.setDouble('LATITUDE', user.latitude!);
    pref.setString('PHONENUMBER', user.phoneNumber.toString());
    pref.setString('TOKEN', user.token.toString());
    pref.setString('PROFILEPICTURE', user.profilePicture.toString());
  }

  static Future<UserModel> getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return UserModel(
        name: pref.getString('NAME'),
        profilePicture: pref.getString('PROFILEPICTURE'),
        latitude: pref.getDouble('LATITUDE')!,
        myServices: [],
        mySpareParts: [],
        longitude: pref.getDouble('LONGITUDE'),
        token: pref.getString('TOKEN'),
        email: pref.getString('EMAIL'),
        phoneNumber: pref.getString('PHONENUMBER'));
  }

  static Future<void> removeUser() async {
    FirebaseAuth.instance.signOut();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Get.offAllNamed(Routes.signUpScreen);
  }


}