import 'package:auto_motive/main.dart';
import 'package:auto_motive/model/user_model.dart';
import 'package:auto_motive/res/app_collections.dart';
import 'package:auto_motive/res/routes/routes.dart';
import 'package:auto_motive/utils/utils.dart';
import 'package:auto_motive/view/verification/email_verificaion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view model/controller/signin_controller.dart';
import '../../../view model/controller/signup_controller.dart';
import '../../shared pref/shared_pref.dart';

class FirebaseServices {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static final signInController = Get.put(SignInController());
  static final signUpController = Get.put(SignupController());

  static Future<void> createAccount(
      {required double latitude, required double longitude}) async {
    // try {
    // signUpController.setLoading(true);
    final userCredential = await auth.createUserWithEmailAndPassword(
        email: signUpController.email.value.text.toString(),
        password: signUpController.password.value.text.toString());
    final user = UserModel(
        name: signUpController.name.value.text.toString(),
        profilePicture: '',
        latitude: latitude,
        myServices: [],
        mySpareParts: [],
        longitude: longitude,
        token: userCredential.user!.uid,
        email: signUpController.email.value.text.toString(),
        phoneNumber: signUpController.phoneNumber.value.text.toString());

    await db.collection(AppCollections.usersCollection).doc(user.token).set({
      'name': user.name,
      'email': user.email,
      'phoneNumber': user.phoneNumber,
      'token': user.token,
      'profilePicture': user.profilePicture,
      'latitude': user.latitude,
      'longitude': user.longitude,
      'myServices': [],
      'mySpareParts': [],
    });
    UserPref.setUser(user: user);
    localUser = user;
    // signUpController.setLoading(false);
    Get.offAllNamed(Routes.profilePicture);
    // } catch (error) {
    //   signUpController.setLoading(false);
    //   Utils.showSnackBar(
    //       'Error',
    //       error.toString(),
    //       const Icon(
    //         Icons.warning_amber,
    //         color: Colors.red,
    //       ));
    //   if (kDebugMode) {
    //     print(error.toString());
    //   }
    // }
  }

  static Future<void> loginAccount() async {
    try {
      signInController.setLoading(true);
      final userCredential = await auth.signInWithEmailAndPassword(
          email: signInController.email.value.text.toString(),
          password: signInController.password.value.text.toString());
      if (FirebaseAuth.instance.currentUser!.emailVerified == false) {
        Get.off(() => const EmailVerificationPage());
        return;
      } else {
        final userSnapshot = await db
            .collection(AppCollections.usersCollection)
            .doc(userCredential.user!.uid)
            .get();
        final user = UserModel(
          name: userSnapshot.get('name'),
          profilePicture: userSnapshot.get('profilePicture'),
          latitude: userSnapshot.get('latitude'),
          myServices: userSnapshot.get('myServices'),
          mySpareParts: userSnapshot.get('mySpareParts'),
          longitude: userSnapshot.get('longitude'),
          token: userSnapshot.get('token'),
          email: userSnapshot.get('email'),
          phoneNumber: userSnapshot.get('phoneNumber'),
        );
        signInController.setLoading(false);
        UserPref.setUser(user: user);
        localUser = user;
        Get.offAllNamed(Routes.home);
      }
    } catch (error) {
      signInController.setLoading(false);
      Utils.showSnackBar(
          'Error',
          error.toString(),
          const Icon(
            Icons.warning_amber,
            color: Colors.red,
          ));
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

  static Future<void> updateProfilePicture({required String url}) async {
    await db
        .collection(AppCollections.usersCollection)
        .doc(localUser!.token)
        .update({
      'profilePicture': url,
    });
  }
}
