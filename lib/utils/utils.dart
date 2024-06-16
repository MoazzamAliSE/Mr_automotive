import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import '../res/app_color.dart';

class Utils {
  static bool validateEmail(String email) {
    return EmailValidator.validate(email);
  }

  static String formatDate(DateTime date) {
    return DateFormat('dd-MMM-yy').format(date);
  }

  static String formatDateDay(DateTime date) {
    return DateFormat('dd-MMM-EEEE').format(date);
  }

  static String formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  static showImage(BuildContext context, String image) {
    showGeneralDialog(
      barrierColor: Colors.black,
      transitionDuration: const Duration(milliseconds: 100),
      barrierDismissible: true,
      barrierLabel: 'Barrier',
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Hero(
            tag: 'IMAGEVIEW',
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Container(
                  color: Colors.black,
                  child: Center(
                      child: CachedNetworkImage(
                    imageUrl: image,
                    errorWidget: (context, url, error) {
                      return const Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 80,
                        ),
                      );
                    },
                    imageBuilder: (context, imageProvider) {
                      return PhotoView(imageProvider: imageProvider);
                    },
                  ))),
            ),
          ),
        );
      },
    );
  }

  static String extractFirebaseError(String error) {
    return error.substring(error.indexOf(']') + 1);
  }

  static void showSnackBar(String title, String message, Widget icon) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: primaryColor.withOpacity(.4),
      title: title,
      isDismissible: true,
      duration: const Duration(milliseconds: 3000),
      icon: icon,
      message: message,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 20,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      snackStyle: SnackStyle.GROUNDED,
      barBlur: 30,
    ));
  }
}
