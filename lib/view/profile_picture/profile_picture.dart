import 'dart:io';

import 'package:auto_motive/res/routes/routes.dart';
import 'package:auto_motive/view%20model/controller/profile_picture_controller.dart';
import 'package:auto_motive/view/common%20widgets/back_button.dart';
import 'package:auto_motive/view/sign%20up/components/button.dart';
import 'package:auto_motive/view/verification/email_verificaion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePicture extends StatelessWidget {
  ProfilePicture({super.key});
  final controller = Get.put(ProfilePictureController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: darkBackgroundColor,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.black,
              Colors.black,
              Colors.black54,
            ])),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    CustomBackButton(
                      onTap: () => Get.offAllNamed(Routes.home),
                    ),
                    const Spacer(),
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        if (FirebaseAuth.instance.currentUser!.emailVerified ==
                            false) {
                          Get.to(() => const EmailVerificationPage());
                        } else {
                          Get.offAllNamed(Routes.home);
                        }
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          'Skip',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                    child: GestureDetector(
                  onTap: () => controller.pickImage(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(140),
                    child: Stack(
                      children: [
                        Obx(
                          () => Container(
                            height: 140,
                            width: 140,
                            color: Colors.white12,
                            child: controller.picture.isEmpty
                                ? const Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.white,
                                  )
                                : Image.file(
                                    File(controller.picture.value),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            child: Container(
                              height: 40,
                              width: 140,
                              color: Colors.white12,
                              child: const Center(
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                )),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Set your profile picture',
                  style: TextStyle(color: Colors.white),
                ),
                const Spacer(),
                AccountButton(
                  text: 'Update Picture',
                  loading: false,
                  onTap: () {
                    controller.uploadImage();
                  },
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
