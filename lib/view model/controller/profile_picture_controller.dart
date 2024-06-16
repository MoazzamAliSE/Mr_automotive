import 'dart:developer';

import 'package:auto_motive/Data/network/firebase/user_services.dart';
import 'package:auto_motive/Data/shared%20pref/shared_pref.dart';
import 'package:auto_motive/data/network/firebase/file_services.dart';
import 'package:auto_motive/main.dart';
import 'package:auto_motive/utils/utils.dart';
import 'package:auto_motive/view%20model/controller/profile_controller.dart';
import 'package:auto_motive/view/verification/email_verificaion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePictureController extends GetxController {
  RxString picture = ''.obs;

  pickImage() async {
    final picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picker != null) {
      picture.value = picker.path;
    }
  }

  uploadImage() async {
    Utils.showSnackBar(
        'Profile Picture',
        'We are updating your profile picture',
        const Icon(
          Icons.timer_outlined,
          color: Colors.white,
        ));
    try {
      String url = await FileServices.uploadFile(
          filePath: picture.value,
          uploadPath:
              'profilePictures/${localUser!.token.toString()}/${DateTime.now().microsecondsSinceEpoch.toString()}.jpeg');
      await FirebaseServices.updateProfilePicture(url: url);
      log("image set $url ");
      Utils.showSnackBar(
          'Success',
          'Successfully update image',
          const Icon(
            Icons.done_all,
            color: Colors.white,
          ));
      localUser = localUser!.copyWith(profilePicture: url);
      log("image ${localUser?.profilePicture}");
      Get.put(ProfileController()).user.value = localUser!;
      UserPref.setUser(user: localUser!);
      Get.off(() => const EmailVerificationPage());
      update();
    } catch (error) {
      Utils.showSnackBar(
          'Error',
          error.toString(),
          const Icon(
            Icons.warning_amber,
            color: Colors.red,
          ));
    }
  }
}
